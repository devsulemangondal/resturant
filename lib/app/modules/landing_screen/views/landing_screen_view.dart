import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/login_screen/controllers/login_screen_controller.dart';
import 'package:restaurant/app/modules/login_screen/views/login_screen_view.dart';
import 'package:restaurant/app/modules/signup_screen/views/signup_screen_view.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class LandingScreenView extends StatelessWidget {
  const LandingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return GetBuilder(
      init: LoginScreenController(),
      builder: (controller) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,

            /// 🎨 GRADIENT BACKGROUND (FIGMA STYLE)
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0B1026), // deep navy
                  Color(0xFF151B3D), // indigo
                  Color(0xFF1E2A6D), // blue glow
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),

            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    /// 🔵 APP ICON
                    spaceH(height: 80.h),
                    Image.asset(
                      "assets/images/landing-image.png",
                      height: 150,
                    ),

                    spaceH(height: 100.h),

                    /// 📝 TITLE
                    TextCustom(
                      title: 'Join ZEZALE',
                      fontSize: 28,
                      fontFamily: FontFamily.bold,
                      color: Colors.white,
                    ),

                    spaceH(height: 12.h),

                    /// 📄 SUBTITLE
                    TextCustom(
                      title:
                          "Create an account to start managing your restaurant.",
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      fontFamily: FontFamily.regular,
                      color: Colors.white.withOpacity(0.72),
                      maxLine: 2,
                    ),

                    spaceH(height: 49.h),

                    /// 🔹 SIGN UP WITH EMAIL
                    RoundShapeButton(
                      size: Size(double.infinity, 56.h),
                      buttonColor: AppThemeData.primary300,
                      onTap: () {
                        Get.to(
                          () => SignupScreenView(),
                          arguments: {"type": Constant.emailLoginType},
                        );
                      },
                      titleWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.email_outlined,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 12),
                          Text(
                            "Sign Up with Email".tr,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: FontFamily.medium,
                            ),
                          ),
                        ],
                      ),
                      title: '',
                      buttonTextColor: Colors.white,
                    ),

                    spaceH(height: 24.h),

                    /// ─── OR ───
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.22),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "or",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.55),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.22),
                          ),
                        ),
                      ],
                    ),

                    spaceH(height: 24.h),

                    /// 🔹 GOOGLE SIGN IN
                    RoundShapeButton(
                      size: Size(double.infinity, 56.h),
                      buttonColor: Colors.white,
                      onTap: controller.loginWithGoogle,
                      titleWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ic_google.svg",
                            height: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Continue with Google".tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: FontFamily.medium,
                              color: AppThemeData.grey1000,
                            ),
                          ),
                        ],
                      ),
                      title: '',
                      buttonTextColor: Colors.white,
                    ),

                    spaceH(height: 12.h),

                    /// 🍎 APPLE SIGN IN
                    if (Platform.isIOS)
                      RoundShapeButton(
                        size: Size(double.infinity, 56.h),
                        buttonColor: Colors.black,
                        onTap: controller.loginWithApple,
                        titleWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/ic_apple.svg",
                              height: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Continue with Apple".tr,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: FontFamily.medium,
                              ),
                            ),
                          ],
                        ),
                        title: '',
                        buttonTextColor: Colors.white,
                      ),

                    const Spacer(),

                    /// 🔹 FOOTER LOGIN
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 14,
                            fontFamily: FontFamily.regular,
                          ),
                          children: [
                            TextSpan(
                              text: "Log in",
                              style: TextStyle(
                                color: Color(0xff7C86FF),
                                fontSize: 14,
                                fontFamily: FontFamily.medium,
                                // decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => LoginScreenView()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
