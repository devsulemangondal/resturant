// ignore_for_file: must_be_immutable, depend_on_referenced_packages, use_super_parameters, deprecated_member_use, use_build_context_synchronously

import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/models/cuisine_model.dart';
import 'package:restaurant/app/models/location_lat_lng.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/controllers/add_restaurant_screen_controller.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/views/widget/packaging_fee_card.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/views/widget/restaurant_type_card.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_field_widget.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant/place_picker/location_picker_screen.dart';
import 'package:restaurant/constant/place_picker/selected_location_model.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class RestaurantDetailWidget extends GetView<AddRestaurantScreenController> {
  RestaurantDetailWidget({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
      init: AddRestaurantScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: paddingEdgeInsets(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      title: "Add The Restaurant Details".tr,
                      fontSize: 18,
                      maxLine: 2,
                      color: Color(0xff1D293D),
                      fontFamily: FontFamily.medium,
                      textAlign: TextAlign.start,
                    ),
                    2.height,
                    TextCustom(
                      title:
                          "Please provide essential information about your restaurant to help customers discover and connect with you."
                              .tr,
                      fontSize: 14,
                      maxLine: 2,
                      color: Color(0xff45556C),
                      fontFamily: FontFamily.regular,
                      textAlign: TextAlign.start,
                    ),
                    spaceH(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => RestaurantTypeCard(
                              title: "Veg".tr,
                              isSelected: controller.restaurantType.value ==
                                  RestaurantType.veg,
                              onTap: () {
                                controller.restaurantType.value =
                                    RestaurantType.veg;
                              },
                            )),
                        Obx(() => RestaurantTypeCard(
                              title: "Non-Veg".tr,
                              isSelected: controller.restaurantType.value ==
                                  RestaurantType.nonVeg,
                              onTap: () {
                                controller.restaurantType.value =
                                    RestaurantType.nonVeg;
                              },
                            )),
                        Obx(() => RestaurantTypeCard(
                              title: "Both".tr,
                              isSelected: controller.restaurantType.value ==
                                  RestaurantType.both,
                              onTap: () {
                                controller.restaurantType.value =
                                    RestaurantType.both;
                              },
                            )),
                      ],
                    ),
                    TextFieldWidget(
                      isRequired: true,
                      title: "Restaurant Name".tr,
                      hintText: "Enter Restaurant Name".tr,
                      controller: controller.restaurantNameController.value,
                    ),
                  
                    InkWell(
                      onTap: () async {
                        if (controller
                            .restaurantAddressController.value.text.isEmpty) {
                          controller.checkPermission(() async {
                            ShowToastDialog.showLoader("Please Wait..".tr);
                            try {
                              await Geolocator.requestPermission();
                              await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high);
                              ShowToastDialog.closeLoader();

                              if (context.mounted) {
                                Get.to(LocationPickerScreen())!
                                    .then((value) async {
                                  SelectedLocationModel selectedLocation =
                                      value!;
                                  final placeMark =
                                      await placemarkFromCoordinates(
                                          selectedLocation.latLng!.latitude,
                                          selectedLocation.latLng!.longitude);
                                  if (placeMark.isNotEmpty) {
                                    final result = placeMark.first;
                                    controller.restaurantAddressController.value
                                            .text =
                                        "${result.name}, ${result.locality}, ${result.administrativeArea}, ${result.postalCode}, ${result.country}";
                                    controller.locationLatLng.value =
                                        LocationLatLng(
                                      latitude:
                                          selectedLocation.latLng!.latitude,
                                      longitude:
                                          selectedLocation.latLng!.longitude,
                                    );
                                    controller.locality.value =
                                        result.locality!;
                                    controller.landmark.value =
                                        result.subLocality!;
                                  }
                                });
                              }
                            } catch (e, stack) {
                              developer.log("Error getting location: $e",
                                  stackTrace: stack);
                              try {
                                final valuePlaceMaker =
                                    await placemarkFromCoordinates(
                                        19.228825, 72.854118);
                                final placeMark = valuePlaceMaker.first;

                                controller.locationLatLng.value =
                                    LocationLatLng(
                                        latitude: 19.228825,
                                        longitude: 72.854118);
                                controller.restaurantAddressController.value
                                        .text =
                                    "${placeMark.name}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.administrativeArea}, ${placeMark.postalCode}, ${placeMark.country}";
                              } catch (e, stack) {
                                developer.log(
                                    "Error getting default location: $e",
                                    stackTrace: stack);
                              }
                              ShowToastDialog.closeLoader();
                            }
                          });
                        }
                      },
                      child: TextFieldWidget(
                        isRequired: true,
                        title: "Restaurant Address".tr,
                        hintText: "Restaurant Address".tr,
                        line: 2,
                        enable: controller
                                .restaurantAddressController.value.text.isEmpty
                            ? false
                            : true,
                        controller:
                            controller.restaurantAddressController.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: RichText(
                              text: TextSpan(
                                text: "Select Cuisine",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: FontFamily.regular,
                                  color: themeChange.isDarkTheme()
                                      ? AppThemeData.grey200
                                      : AppThemeData.grey800,
                                ),
                                children: [
                                  const TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DropdownButtonFormField(
                            isExpanded: true,
                            onChanged: (value) {
                              controller.selectedCuisine.value = value!;
                            },
                            value: controller.cuisineList
                                    .contains(controller.selectedCuisine.value)
                                ? controller.selectedCuisine.value
                                : null,
                            items: controller.cuisineList.map((item) {
                              return DropdownMenuItem<CuisineModel>(
                                value: item,
                                child: Text(item.cuisineName.toString()),
                              );
                            }).toList(),
                            validator: (value) =>
                                value != null ? null : "This field required".tr,
                            icon: Icon(Icons.keyboard_arrow_down_outlined,
                                color: themeChange.isDarkTheme()
                                    ? AppThemeData.grey600
                                    : AppThemeData.grey400),
                            borderRadius: BorderRadius.circular(6),
                            dropdownColor: themeChange.isDarkTheme()
                                ? AppThemeData.grey800
                                : AppThemeData.grey200,
                            focusColor: Colors.transparent,
                            elevation: 0,
                            hint: TextCustom(
                                title: "Select Cuisine".tr,
                                fontSize: 14,
                                color: themeChange.isDarkTheme()
                                    ? AppThemeData.grey400
                                    : AppThemeData.grey600,
                                fontFamily: FontFamily.regular),
                            style: TextStyle(
                                color: themeChange.isDarkTheme()
                                    ? AppThemeData.grey200
                                    : AppThemeData.grey800,
                                fontFamily: FontFamily.regular,
                                fontSize: 14),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                  fontFamily: FontFamily.regular),
                              isDense: true,
                              filled: true,
                              fillColor: themeChange.isDarkTheme()
                                  ? AppThemeData.grey900
                                  : AppThemeData.grey50,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: themeChange.isDarkTheme()
                                        ? AppThemeData.grey600
                                        : AppThemeData.grey400,
                                    width: 1),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: themeChange.isDarkTheme()
                                        ? AppThemeData.grey600
                                        : AppThemeData.grey400,
                                    width: 1),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: themeChange.isDarkTheme()
                                        ? AppThemeData.grey600
                                        : AppThemeData.grey400,
                                    width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: AppThemeData.danger300, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: themeChange.isDarkTheme()
                                        ? AppThemeData.grey600
                                        : AppThemeData.grey400,
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: AppThemeData.primary300, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    spaceH(height: 12),
                    if ((Constant
                            .platFormFeeSettingModel?.packagingFeeActive) ==
                        true)
                      Obx(
                        () => PackagingFeeCard(
                          isEnabled: controller.packagingFee.value,
                          priceController:
                              controller.packagingPriceController.value,
                          onToggle: (value) {
                            controller.packagingFee.value = value;
                            if (!value) {
                              controller.packagingPriceController.value.clear();
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
              padding: paddingEdgeInsets(vertical: 8),
              child: GradientRoundShapeButton(
                buttonTextColor: controller.restaurantDetailButton.value
                    ? AppThemeData.grey50
                    : AppThemeData.grey500,
                title: "Next".tr,
                buttonColor: controller.restaurantDetailButton.value
                    ? AppThemeData.primary300
                    : AppThemeData.grey200,
                size: Size(double.infinity, 52.h),
                gradientColors: !controller.restaurantDetailButton.value
                    ? []
                    : const [
                        Color(0xff4F39F6),
                        Color(0xff155DFC),
                        Color(0xff155DFC),
                      ],
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    if (controller.restaurantDetailButton.value) {
                      if (controller.editPage.value ==
                          "Upload Restaurant Cover and Logo") {
                        controller.nextStep();
                      } else {
                        controller.nextStep();
                      }
                    }
                  }
                },
              )),
        );
      },
    );
  }
}
