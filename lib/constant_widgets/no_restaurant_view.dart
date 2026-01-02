// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/views/add_restaurant_screen_view.dart';
import 'package:restaurant/app/modules/restaurant_screen/controllers/restaurant_screen_controller.dart';
import 'package:restaurant/app/widget/custom_app_bar.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/responsive.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

import '../themes/screen_size.dart';
import 'round_shape_button.dart';

class NoRestaurantView extends StatelessWidget {
  final double? height;
  final RestaurantScreenController controller;

  const NoRestaurantView({
    super.key,
    required this.themeChange,
    this.height,
    required this.controller,
  });

  final DarkThemeProvider themeChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width(100, context),
      height: Responsive.height(100, context),
      decoration: BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          color: Colors.transparent,
          height: height ?? Responsive.height(100, context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(),
              Spacer(),
              Center(
                child: Image.asset(
                  "assets/images/no_restaurant.png",
                  height: 140.0,
                  width: 140.0,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              TextCustom(
                title: "No Restaurants Found".tr,
                fontSize: 16,
                fontFamily: FontFamily.regular,
                color: Color(0xff1D293D),
              ),
              spaceH(height: 10),
              Padding(
                padding: paddingEdgeInsets(horizontal: 53.w, vertical: 0),
                child: TextCustom(
                  title:
                      "You haven't added any restaurants yet. Start by adding your first restaurant to manage orders."
                          .tr,
                  maxLine: 3,
                  fontSize: 14,
                  fontFamily: FontFamily.regular,
                  color: themeChange.isDarkTheme()
                      ? AppThemeData.grey400
                      : AppThemeData.grey600,
                ),
              ),
              spaceH(height: 4),
              InkWell(
                onTap: () => Get.to(() => AddRestaurantScreenView()),
                child: Text(
                  'Click add button to add the restaurant'.tr,
                  style: TextStyle(
                      fontSize: 14,
                      color: AppThemeData.accent300,
                      fontFamily: FontFamily.regular,
                      decorationColor: AppThemeData.accent300,
                      decoration: TextDecoration.underline),
                ),
              ),
              Spacer(),
              Center(
                child: GradientRoundShapeButton(
                  size: Size(358.w, ScreenSize.height(6, context)),
                  title: "Add Restaurant".tr,
                  onTap: () {
                    Get.to(() => AddRestaurantScreenView())!.then(
                      (value) async {
                        if (value == true) {
                          await controller.getData();
                        }
                      },
                    );
                  },
                  gradientColors: [
                    Color(0xff4F39F6),
                    Color(0xff155DFC),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
