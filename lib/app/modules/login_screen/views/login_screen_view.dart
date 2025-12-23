// ignore_for_file: deprecated_member_use, must_be_immutable, depend_on_referenced_packages, use_super_parameters

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/login_screen/controllers/login_screen_controller.dart';
import 'package:restaurant/app/modules/login_screen/views/enter_mobile_number_view.dart';
import 'package:restaurant/app/modules/login_screen/views/forgot_password_view.dart';
import 'package:restaurant/app/modules/signup_screen/views/signup_screen_view.dart';
import 'package:restaurant/app/widget/custom_line.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_field_widget.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

import '../../../../themes/screen_size.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  LoginScreenView({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder(
      init: LoginScreenController(),
      builder: (controller) {
        controller.emailController.value
            .addListener(() => controller.checkFieldsFilled());
        controller.passwordController.value
            .addListener(() => controller.checkFieldsFilled());

        return Scaffold(
          backgroundColor: themeChange.isDarkTheme()
              ? AppThemeData.grey1000
              : AppThemeData.primaryWhite,
          body: Form(
            key: formKey,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      spaceH(height: 60.h),

                      /// 🔵 APP ICON
                      Image.asset(
                        "assets/images/auth-image.png",
                        height: 70,
                      ),

                      /// 👋 TITLE
                      TextCustom(
                        title: "Welcome Back",
                        fontSize: 26,
                        fontFamily: FontFamily.bold,
                        color: AppThemeData.grey1000,
                      ),

                      spaceH(height: 6),

                      TextCustom(
                        title: "Sign in to continue",
                        fontSize: 14,
                        fontFamily: FontFamily.regular,
                        color: AppThemeData.grey600,
                      ),

                      spaceH(height: 32),

                      /// 🧾 LOGIN CARD
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Color(0xffE3E3E3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 30,
                              offset: const Offset(0, 16),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 🔐 CARD TITLE
                            SectionHeader(
                              icon: CupertinoIcons.lock,
                              title: "LOGIN CREDENTIALS",
                            ),

                            spaceH(height: 20),

                            /// 📧 EMAIL
                            buildEmailPasswordWidget(context),

                            /// 🔑 FORGOT PASSWORD
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => ForgotPassword());
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppThemeData.accent300,
                                    fontFamily: FontFamily.medium,
                                  ),
                                ),
                              ),
                            ),

                            spaceH(height: 10),
                            CustomLine(),
                            spaceH(height: 20),

                            /// 🔵 LOGIN BUTTON
                            Container(
                              width: double.infinity,
                              child: GradientRoundShapeButton(
                                title: "Sign In".tr,
                                size: Size(double.infinity, 52.h),
                                gradientColors: [
                                  Color(0xff4F39F6),
                                  Color(0xff615FFF),
                                  Color(0xff155DFC),
                                ],
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.emailSignIn();
                                  } else {
                                    ShowToastDialog.toast(
                                        "Please fill in valid information.".tr);
                                  }
                                },
                              ),
                            ),

                            spaceH(height: 18),

                            /// 🆕 CREATE ACCOUNT
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppThemeData.grey600,
                                    fontFamily: FontFamily.regular,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Create Account",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppThemeData.accent300,
                                        fontFamily: FontFamily.medium,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Get.to(
                                              () => SignupScreenView(),
                                              arguments: {
                                                "type": Constant.emailLoginType
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      spaceH(height: 24),

                      /// 🔒 FOOTER TEXT
                      Text(
                        "Secure login protected by industry-standard encryption",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppThemeData.grey500,
                          fontFamily: FontFamily.regular,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Column buildEmailPasswordWidget(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "Email or Phone Number",
          hintText: "Enter email or phone number",
          controller: controller.emailController.value,
          prefixIcon:
              const Icon(Icons.email_outlined, color: Color(0xFF90A1B9)),
          validator: (value) => value!.isEmpty ? "Required" : null,
        ),
        Obx(() {
          return CustomTextField(
              label: "Password",
              hintText: "Enter your password",
              validator: (value) => Constant.validatePassword(value),
              controller: controller.passwordController.value,
              obscureText: controller.isPasswordVisible.value,
              prefixIcon:
                  const Icon(Icons.lock_outline, color: Color(0xFF9CA3AF)),
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.isPasswordVisible.value =
                        !controller.isPasswordVisible.value;
                  },
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(0xff90A1B9),
                  )));
        }),
      ],
    );
  }
}
