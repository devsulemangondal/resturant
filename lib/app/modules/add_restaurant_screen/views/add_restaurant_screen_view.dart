// ignore_for_file: deprecated_member_use, must_be_immutable, depend_on_referenced_packages, use_build_context_synchronously, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/controllers/add_restaurant_screen_controller.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/views/widget/select_opening_hours_widget.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/views/widget/upload_restaurant_image_widget.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/responsive.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

import 'widget/restaurant_detail_widget.dart';

class AddRestaurantScreenView extends GetView<AddRestaurantScreenController> {
  const AddRestaurantScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder(
      init: AddRestaurantScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppThemeData.grey50,
          body: Column(
            children: [
              Container(
                  width: Responsive.width(100, context),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppThemeData.accent300,
                        AppThemeData.primary300,
                      ],
                    ),
                  ),
                  child: SafeArea(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                if (controller.editPage.isEmpty) {
                                  if (controller.currentStep.value == 0) {
                                    Get.back();
                                  } else {
                                    controller.previousStep();
                                  }
                                } else {
                                  if (controller.currentStep.value == 1) {
                                    controller.previousStep();
                                  } else {
                                    Get.back();
                                  }
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xff5952f8),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                    child: Icon(Icons.arrow_back_rounded,
                                        color: Colors.white, size: 20)),
                              ),
                            ),
                            Spacer(),
                            Obx(() {
                              return Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: controller.currentStep.value == 0
                                            ? Colors.white
                                            : Colors.white.withOpacity(.4)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: controller.currentStep.value == 1
                                            ? Colors.white
                                            : Colors.white.withOpacity(.4)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: controller.currentStep.value == 2
                                            ? Colors.white
                                            : Colors.white.withOpacity(.4)),
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Obx(() {
                          return Text(
                            controller.currentStep.value == 0
                                ? "Restaurant Details"
                                : controller.currentStep.value == 1
                                    ? "Restaurant Details"
                                    : "Opening Hours",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          );
                        }),
                        Obx(() {
                          return Text(
                            controller.currentStep.value == 0
                                ? "Upload your restaurant cover and logo"
                                : controller.currentStep.value == 1
                                    ? "Tell us about your restaurant"
                                    : "Set your restaurant's schedule",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          );
                        })
                      ],
                    ),
                  ))),
              Expanded(child: Obx(() => stepper(context))),
            ],
          ),
        );
      },
    );
  }

  Widget stepper(BuildContext context) {
    return controller.isLoading.value
        ? Center(child: Constant.loader())
        : IndexedStack(
            index: controller.currentStep.value,
            children: [
              const UploadRestaurantImage(),
              RestaurantDetailWidget(),
              SelectOpeningHoursWidget(),
              
            ],
          );
  }
}
