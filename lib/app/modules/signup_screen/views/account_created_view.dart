import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/dashboard_screen/views/dashboard_screen_view.dart';
import 'package:restaurant/app/modules/login_screen/controllers/login_screen_controller.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/screen_size.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class AccountCreatedView extends StatelessWidget {
  const AccountCreatedView({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<DarkThemeProvider>(context);
    return GetBuilder(
        init: LoginScreenController(),
        builder: (controller) {
          return Container(
            height: ScreenSize.height(100, context),
            width: ScreenSize.width(100, context),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/success-image.png",
                  ),
                ),
                spaceH(height: 42.h),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF0FF), // light blue background
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFFC7D2FF), // subtle blue border
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        size: 18,
                        color: Color(0xFF4F39F6),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Welcome to ZEZALE",
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: FontFamily.medium,
                          color: Color(0xFF4F39F6),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.auto_awesome,
                        size: 18,
                        color: Color(0xFF4F39F6),
                      ),
                    ],
                  ),
                ),
                spaceH(height: 20.h),
                Padding(
                  padding: paddingEdgeInsets(horizontal: 39, vertical: 0),
                  child: TextCustom(
                    title: "Account Created\nSuccessfully".tr,
                    maxLine: 2,
                    color: AppThemeData.textBlack,
                    fontSize: 30,
                    fontFamily: FontFamily.bold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: paddingEdgeInsets(horizontal: 50, vertical: 20),
                  child: TextCustom(
                    title:
                        "Congratulations! Your account has been successfully created. Start exploring now!"
                            .tr,
                    maxLine: 3,
                    color: Color(0xff45556C),
                    fontSize: 16,
                    fontFamily: FontFamily.regular,
                  ),
                ),
                spaceH(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: GradientRoundShapeButton(
                      size: Size(259.w, ScreenSize.height(6, context)),
                      title: "Set up Restaurant".tr,
                      onTap: () {
                        Get.offAll(DashboardScreenView());
                      },
                      gradientColors: const [
                        Color(0xff4F39F6),
                        Color(0xff615FFF),
                        Color(0xff155DFC),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
