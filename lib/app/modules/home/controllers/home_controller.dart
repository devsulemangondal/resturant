// ignore_for_file: depend_on_referenced_packages

import 'dart:developer' as developer;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:restaurant/app/models/driver_user_model.dart';
import 'package:restaurant/app/models/order_model.dart';
import 'package:restaurant/app/models/wallet_transaction_model.dart';
import 'package:restaurant/constant/collection_name.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant/order_status.dart';
import 'package:restaurant/utils/fire_store_utils.dart';
import '../../../../constant/show_toast_dialogue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  RxBool restaurantStatus = false.obs;
  var minutes = 15.obs;
  RxString selectedTags = "Preparing".obs;

  late TabController tabController;
  RxList<OrderModel> newOrderList = <OrderModel>[].obs;
  RxList<OrderModel> preparingOrderList = <OrderModel>[].obs;
  Rx<OrderModel> orderModel = OrderModel().obs;

  RxList<OrderModel> readyOrderList = <OrderModel>[].obs;
  RxList<OrderModel> pickUpOrderList = <OrderModel>[].obs;
  RxList<OrderModel> filterOrderList = <OrderModel>[].obs;

  @override
  void onInit() {
    getData();
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  int getOrderPrepMinutes(OrderModel order) {
    int maxP = 0;

    if (order.items != null && order.items!.isNotEmpty) {
      for (final item in order.items!) {
        final p = Constant.parsePreparationTime(item.preparationTime);
        if (p > maxP) maxP = p;
      }
    }

    // sensible default
    if (maxP == 0) maxP = 10;

    return maxP;
  }

  Future<void> getData() async {
    isLoading.value = true;
    try {
      getNewOrder();
      getInPrepareOrder();

      restaurantStatus.value = Constant.vendorModel?.isOnline ?? false;
    } catch (e, stack) {
      developer.log(
        'Error getting data: ',
        error: e,
        stackTrace: stack,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> isOnlineRestaurant() async {
    try {
      Constant.ownerModel?.isOpen = restaurantStatus.value;
      await FireStoreUtils.updateOwner(Constant.ownerModel!);

      Constant.vendorModel?.isOnline = restaurantStatus.value;
      await FireStoreUtils.updateRestaurant(Constant.vendorModel!);
    } catch (e, stack) {
      developer.log(
        'Error updating online status: ',
        error: e,
        stackTrace: stack,
      );
      ShowToastDialog.toast("Failed to update online status.".tr);
    }
  }

  Future<void> updateOrder(OrderModel bookingOrder) async {
    try {
      await FireStoreUtils.updateOrder(bookingOrder);
    } catch (e, stack) {
      developer.log(
        'Error updating order: ',
        error: e,
        stackTrace: stack,
      );
    }
  }

  void getNewOrder() {
    isLoading.value = true;
    try {
      FireStoreUtils.fireStore
          .collection(CollectionName.orders)
          .where('vendorId', isEqualTo: Constant.ownerModel!.vendorId)
          .where('orderStatus', isEqualTo: OrderStatus.orderPending)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen(
        (event) {
          newOrderList.clear();
          List<OrderModel> orderList = [];

          for (var doc in event.docs) {
            OrderModel model = OrderModel.fromJson(doc.data());
            orderList.add(model);
          }

          newOrderList.assignAll(orderList);
          isLoading.value = false;
        },
      );
    } catch (e) {
      isLoading.value = false;
      developer.log("Error in getNewOrder(): $e");
    }
  }

  void getInPrepareOrder() {
    isLoading.value = true;
    try {
      FireStoreUtils.fireStore
          .collection(CollectionName.orders)
          .where('vendorId', isEqualTo: Constant.ownerModel!.vendorId)
          .where("orderStatus", whereIn: [
            OrderStatus.orderAccepted,
            OrderStatus.driverAssigned,
            OrderStatus.driverAccepted,
            OrderStatus.driverRejected,
            OrderStatus.orderOnReady,
            OrderStatus.driverPickup,
          ])
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((event) {
            preparingOrderList.clear();
            List<OrderModel> orderList = [];

            for (var doc in event.docs) {
              OrderModel model = OrderModel.fromJson(doc.data());
              orderList.add(model);
            }

            preparingOrderList.assignAll(orderList);
            isLoading.value = false;
          });
    } catch (e) {
      isLoading.value = false;
      developer.log("Error in getInPrepareOrder(): $e");
    }
  }

  Future<void> addPaymentInWalletForRestaurant(OrderModel orderModel) async {
    try {
      double orderSubTotalAmount = double.tryParse(orderModel.subTotal ?? "0") ?? 0;
      int discount = double.tryParse(orderModel.discount ?? "0")?.toInt() ?? 0;
      double tax = 0;

      tax = double.parse(Constant.calculateTax(amount: orderSubTotalAmount.toString(), taxModel: orderModel.taxList![0]).toString());

      double finalOwnerAmount = 0;
      double commissionBaseAmount = 0;

      if (orderModel.coupon != null && orderModel.coupon!.isVendorOffer == true) {
        finalOwnerAmount = orderSubTotalAmount + tax - discount;
        commissionBaseAmount = orderSubTotalAmount - discount;
      } else {
        finalOwnerAmount = orderSubTotalAmount + tax;
        commissionBaseAmount = orderSubTotalAmount;
      }

      /// --- ADMIN COMMISSION AMOUNT ---
      String commissionAmount = Constant.calculateAdminCommission(
        amount: commissionBaseAmount.toStringAsFixed(2),
        adminCommission: orderModel.adminCommissionVendor,
      ).toString();

      /// --- ADMIN COMMISSION TRANSACTION ---
      WalletTransactionModel adminCommissionTransaction = WalletTransactionModel(
        id: Constant.getUuid(),
        amount: commissionAmount,
        createdDate: Timestamp.now(),
        paymentType: orderModel.paymentType,
        transactionId: orderModel.transactionPaymentId,
        userId: Constant.ownerModel!.id.toString(),
        isCredit: false,
        type: Constant.owner,
        note: "Admin Commission",
      );

      /// --- COMMISSION DEDUCTION ---
      bool? debitSuccess = await FireStoreUtils.setWalletTransaction(adminCommissionTransaction);
      if (debitSuccess!) {
        await FireStoreUtils.updateOwnerWalletDebited(
          amount: commissionAmount,
          ownerID: Constant.ownerModel!.id.toString(),
        );
      }

      if (orderModel.paymentType != "Cash on Delivery") {
        WalletTransactionModel ownerTransaction = WalletTransactionModel(
          id: Constant.getUuid(),
          amount: finalOwnerAmount.toStringAsFixed(2),
          createdDate: Timestamp.now(),
          paymentType: orderModel.paymentType,
          transactionId: orderModel.transactionPaymentId,
          userId: Constant.ownerModel!.id.toString(),
          isCredit: true,
          type: Constant.owner,
          note: "Order Amount",
        );

        bool? creditSuccess = await FireStoreUtils.setWalletTransaction(ownerTransaction);
        if (creditSuccess!) {
          await FireStoreUtils.updateOwnerWallet(
            amount: finalOwnerAmount.toStringAsFixed(2),
            ownerID: Constant.ownerModel!.id.toString(),
          );
        }
      }
    } catch (e, stacktrace) {
      debugPrint("Error in addPaymentInWalletForRestaurant: $e");
      debugPrint("Stacktrace: $stacktrace");
    }
  }

  Future<bool> checkNearestDriverAvailable(double restaurantLat, double restaurantLng) async {
    try {
      QuerySnapshot driverSnapshot = await FirebaseFirestore.instance.collection(CollectionName.driver).where('isOnline', isEqualTo: true).where('status', isEqualTo: 'free').get();

      if (driverSnapshot.docs.isEmpty) {
        debugPrint("No online drivers found.");
        return false;
      }

      log("Driver count: ${driverSnapshot.docs.length}");

      double maxDistance = double.tryParse(Constant.driverRadius) ?? 50;
      bool isKm = Constant.driverDistanceType.toLowerCase() == "km";

      for (var doc in driverSnapshot.docs) {
        try {
          final location = doc.data() is Map && doc['location'] != null ? doc['location'] : null;
          if (location == null || location['latitude'] == null || location['longitude'] == null) {
            debugPrint("Skipping driver ${doc.id} due to missing location field.");
            continue;
          }

          double driverLat = (location['latitude'] as num).toDouble();
          double driverLng = (location['longitude'] as num).toDouble();

          double distanceInMeters = Geolocator.distanceBetween(
            restaurantLat,
            restaurantLng,
            driverLat,
            driverLng,
          );

          double distance = isKm ? (distanceInMeters / 1000) : (distanceInMeters / 1609.34);

          if (distance <= maxDistance) {
            debugPrint("✅ Found driver ${doc.id} within $distance ${Constant.driverDistanceType}");
            return true;
          }
        } catch (e) {
          debugPrint("Skipping driver ${doc.id} due to error: $e");
        }
      }

      debugPrint("❌ No drivers found within $maxDistance ${Constant.driverDistanceType}");
      return false;
    } catch (e) {
      debugPrint("Error checking driver availability: $e");
      return false;
    }
  }

  Future<void> computeAndSaveEtaLocalFallback(OrderModel order, {double avgKmph = 30.0}) async {
    try {
      if (order.id == null) return;

      // 1) PREP MINUTES = MAX item prep time
      int prepMinutes = 0;
      if (order.items != null && order.items!.isNotEmpty) {
        for (final item in order.items!) {
          final p = Constant.parsePreparationTime(item.preparationTime);
          if (p > prepMinutes) prepMinutes = p;
        }
      }
      if (prepMinutes == 0) prepMinutes = 10;

      // 2) VENDOR & CUSTOMER
      final vendorLoc = order.vendorAddress?.location;
      final customerLoc = order.customerAddress?.location;
      if (vendorLoc == null || vendorLoc.latitude == null || vendorLoc.longitude == null) {
        print('computeAndSaveEtaLocalFallback: vendor location missing, skipping ETA write for order ${order.id}');
        return;
      }
      final vendorLat = vendorLoc.latitude!.toDouble();
      final vendorLng = vendorLoc.longitude!.toDouble();

      int vendorToCustomerMin = 0;
      if (customerLoc != null && customerLoc.latitude != null && customerLoc.longitude != null) {
        final km = Constant.haversineDistanceKm(
          vendorLat,
          vendorLng,
          customerLoc.latitude!.toDouble(),
          customerLoc.longitude!.toDouble(),
        );
        vendorToCustomerMin = Constant.estimateMinutesByDistanceKm(km, avgKmph: avgKmph);
      }

      // 3) DRIVER -> VENDOR (only if driver already assigned)
      int driverToVendorMin = 0;
      if (order.driverId != null && order.driverId!.isNotEmpty) {
        final drvDoc = await FirebaseFirestore.instance.collection(CollectionName.driver).doc(order.driverId).get();
        if (drvDoc.exists && drvDoc.data() != null) {
          final driver = DriverUserModel.fromJson(drvDoc.data()!);
          if (driver.location != null && driver.location!.latitude != null && driver.location!.longitude != null) {
            final km = Constant.haversineDistanceKm(
              driver.location!.latitude!.toDouble(),
              driver.location!.longitude!.toDouble(),
              vendorLat,
              vendorLng,
            );
            driverToVendorMin = Constant.estimateMinutesByDistanceKm(km, avgKmph: avgKmph);
          } else {
            print('computeAndSaveEtaLocalFallback: driver ${order.driverId} has no location yet');
          }
        }
      }

      order.estimatedDeliveryTime ??= ETAModel();

      final total = prepMinutes + driverToVendorMin + vendorToCustomerMin;
      final estimatedAt = DateTime.now().add(Duration(minutes: total));

      order.estimatedDeliveryTime!
        ..prepMinutes = prepMinutes.toString()
        ..driverToVendorMinutes = driverToVendorMin.toString()
        ..vendorToCustomerMinutes = vendorToCustomerMin.toString()
        ..totalMinutes = total.toString()
        ..estimatedDeliveryAt = Timestamp.fromDate(estimatedAt)
        ..lastUpdated = Timestamp.now();

      FireStoreUtils.updateOrder(order);

      print('computeAndSaveEtaLocalFallback: wrote ETA for order ${order.id} -> '
          'prep=$prepMinutes, d2v=$driverToVendorMin, v2c=$vendorToCustomerMin, total=$total, eta=$estimatedAt');
    } catch (e, st) {
      print('computeAndSaveEtaLocalFallback error: $e\n$st');
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
