// ignore_for_file: must_be_immutable, deprecated_member_use, depend_on_referenced_packages, use_super_parameters, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/controllers/add_restaurant_screen_controller.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/views/widget/restaurant_day_timing_card.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

import '../../../../../constant_widgets/round_shape_button.dart';

class SelectOpeningHoursWidget extends GetView<AddRestaurantScreenController> {
  SelectOpeningHoursWidget({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
      init: AddRestaurantScreenController(),
      builder: (controller) {
        controller.validateOpeningHours();
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: paddingEdgeInsets(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      title: "Select Opening Hours".tr,
                      fontSize: 18,
                      maxLine: 2,
                      color: Color(0xff1D293D),
                      fontFamily: FontFamily.medium,
                      textAlign: TextAlign.start,
                    ),
                    2.height,
                    TextCustom(
                      title:
                          "Choose the days and times your restaurant is open for business."
                              .tr,
                      fontSize: 14,
                      maxLine: 2,
                      color: Color(0xff45556C),
                      fontFamily: FontFamily.regular,
                      textAlign: TextAlign.start,
                    ),
                    ListView.builder(
                      itemCount: 7,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Obx(
                          () => RestaurantDayTimingCard(
                            shortDay:
                                controller.getWeekDay(index).substring(0, 3),
                            fullDay: controller.getWeekDay(index),
                            isEnabled: controller.daySwitches[index].value,
                            onToggle: () => controller.toggleDaySwitch(index),
                            openController:
                                controller.openingHoursController[index],
                            closeController:
                                controller.closingHoursController[index],
                            onOpenTap: () async {
                              await controller.selectOpeningHour(index);
                              controller.openingHoursController[index].text =
                                  controller.openingHours[index].value
                                      .format(context);
                            },
                            onCloseTap: () async {
                              await controller.selectClosingHour(index);
                              controller.closingHoursController[index].text =
                                  controller.closingHours[index].value
                                      .format(context);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
              padding: paddingEdgeInsets(vertical: 8),
              child: GradientRoundShapeButton(
                title: "Complete Setup".tr,
                size: Size(double.infinity, 52.h),
                gradientColors: [
                  Color(0xff4F39F6),
                  Color(0xff155DFC),
                  Color(0xff155DFC),
                ],
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    controller.validateOpeningHours();
                    if (!controller.isAllOpeningHoursSelected.value) {
                      ShowToastDialog.toast(
                          "Please select at least one valid opening and closing hour."
                              .tr);
                      return;
                    }
                    await controller.openingHoursEntries();
                    controller.saveData();
                    controller.editPage.value = "";
                  }
                },
              )),
        );
      },
    );
  }
}
