import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:restaurant/app/models/owner_model.dart';
import 'package:restaurant/constant/collection_name.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/utils/fire_store_utils.dart';

import '../../../models/vendor_model.dart';

class ProfileScreenController extends GetxController {
  Rx<OwnerModel> ownerModel = OwnerModel().obs;
  Rx<VendorModel> vendorModel = VendorModel().obs;
  RxBool isSelfDelivery = false.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    try {
      ownerModel.value = Constant.ownerModel!;
      vendorModel.value = Constant.vendorModel!;
      isSelfDelivery.value = Constant.vendorModel?.isSelfDelivery ?? false;
      update();
    } catch (e, stack) {
      if (kDebugMode) {
        developer.log('Error fetching owner data: $e', error: e, stackTrace: stack);
      }
    }
  }

  Future<void> isSelfDeliveryRestaurant() async {
    try {
      Constant.vendorModel?.isSelfDelivery = isSelfDelivery.value;
      await FireStoreUtils.updateRestaurant(Constant.vendorModel!);
      developer.log("Self delivery status updated to: ${isSelfDelivery.value}");
    } catch (e, stack) {
      developer.log(
        'Error updating self delivery status: ',
        error: e,
        stackTrace: stack,
      );
      ShowToastDialog.toast("Failed to update status.".tr);
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      final String? ownerId = FireStoreUtils.getCurrentUid();
      if (ownerId == null) {
        developer.log("Owner ID is null — cannot delete account.");
        return;
      }

      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Step 1: Get all vendors belonging to this owner
      final vendorSnapshot = await firestore.collection(CollectionName.vendors).where('ownerId', isEqualTo: ownerId).get();

      // Step 2: For each vendor, delete its drivers and then the vendor itself
      await Future.wait(vendorSnapshot.docs.map((vendorDoc) async {
        final String vendorId = vendorDoc.id;

        // Get drivers of this vendor
        final driverSnapshot = await firestore.collection(CollectionName.driver).where('vendorId', isEqualTo: vendorId).get();

        // Delete all drivers in parallel
        await Future.wait(driverSnapshot.docs.map((driverDoc) async {
          await firestore.collection(CollectionName.driver).doc(driverDoc.id).delete();
        }));

        // Delete vendor
        await firestore.collection(CollectionName.vendors).doc(vendorId).delete();
      }));

      // Step 3: Delete owner document
      await firestore.collection(CollectionName.owner).doc(ownerId).delete();

      // Step 4: Delete Firebase Auth account
      await FirebaseAuth.instance.currentUser!.delete();

      developer.log("✅ Owner, vendors, and drivers deleted successfully.");
    } on FirebaseAuthException catch (error) {
      developer.log("Firebase Auth Exception: $error");
    } catch (error, stack) {
      developer.log("Error deleting user account: $error", error: error, stackTrace: stack);
    }
  }
}
