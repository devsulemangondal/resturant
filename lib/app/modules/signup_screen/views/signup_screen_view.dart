// ignore_for_file: must_be_immutable, use_super_parameters, depend_on_referenced_packages, deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/login_screen/views/login_screen_view.dart';
import 'package:restaurant/app/widget/custom_line.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_field_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

import '../../../../themes/screen_size.dart';
import '../controllers/signup_screen_controller.dart';

class SignupScreenView extends GetView<SignupScreenController> {
  SignupScreenView({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder(
      init: SignupScreenController(),
      builder: (controller) {
        controller.firstNameController.value
            .addListener(() => controller.checkFieldsFilled());
        controller.lastNameController.value
            .addListener(() => controller.checkFieldsFilled());
        controller.mobileNumberController.value
            .addListener(() => controller.checkFieldsFilled());
        controller.emailController.value
            .addListener(() => controller.checkFieldsFilled());
        controller.passwordController.value
            .addListener(() => controller.checkFieldsFilled());
        controller.confirmPasswordController.value
            .addListener(() => controller.checkFieldsFilled());

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                /// 🌈 BACKGROUND

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      spaceH(height: 60.h),

                      /// 🔵 ICON
                      Image.asset(
                        "assets/images/auth-image.png",
                        height: 70,
                      ),

                      spaceH(height: 16),

                      /// 📝 TITLE
                      Text(
                        "Create Your Account",
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: FontFamily.bold,
                          color: AppThemeData.grey1000,
                        ),
                      ),

                      spaceH(height: 6),

                      Text(
                        "Start your journey with us",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: FontFamily.regular,
                          color: AppThemeData.grey600,
                        ),
                      ),

                      spaceH(height: 28),

                      /// 🧾 SIGNUP CARD
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0xffE3E3E3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 30,
                              offset: const Offset(0, 16),
                            ),
                          ],
                        ),
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// 🧍 PERSONAL INFO
                              SectionHeader(
                                icon: Icons.person_outline,
                                title: "PERSONAL INFO",
                              ),

                              spaceH(height: 16),

                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      label: "First Name",
                                      hintText: "John",
                                      controller:
                                          controller.firstNameController.value,
                                      validator: (v) =>
                                          v!.isEmpty ? "Required" : null,
                                    ),
                                  ),
                                  spaceW(width: 12),
                                  Expanded(
                                    child: CustomTextField(
                                      label: "Last Name",
                                      hintText: "Doe",
                                      controller:
                                          controller.lastNameController.value,
                                      validator: (v) =>
                                          v!.isEmpty ? "Required" : null,
                                    ),
                                  ),
                                ],
                              ),

                              spaceH(height: 20),

                              /// 📞 CONTACT
                              SectionHeader(
                                icon: Icons.phone_outlined,
                                title: "CONTACT",
                              ),

                              spaceH(height: 16),

                              MobileNumberTextField(
                                label: "Phone Number",
                                controller:
                                    controller.mobileNumberController.value,
                                countryCode: controller.countryCode.value!,
                                onCountryChanged: (code) {
                                  controller.countryCode.value = code;
                                },
                              ),

                              CustomTextField(
                                label: "Email Address",
                                hintText: "john.doe@example.com",
                                controller: controller.emailController.value,
                                validator: Constant.validateEmail,
                                prefixIcon: const Icon(Icons.email_outlined,
                                    color: Color(0xFF90A1B9)),
                                enabled:
                                    !(controller.ownerModel.value.loginType ==
                                            Constant.googleLoginType ||
                                        controller.ownerModel.value.loginType ==
                                            Constant.appleLoginType),
                              ),

                              spaceH(height: 20),

                              /// 🔐 SECURITY
                              if (controller.loginType.value ==
                                  Constant.emailLoginType) ...[
                                SectionHeader(
                                  icon: Icons.lock_outline,
                                  title: "SECURITY",
                                ),
                                spaceH(height: 16),
                                Obx(() => CustomTextField(
                                      label: "Password",
                                      hintText: "Create a strong password",
                                      controller:
                                          controller.passwordController.value,
                                      obscureText:
                                          controller.isPasswordVisible.value,
                                      validator: Constant.validatePassword,
                                      suffixIcon: Icon(
                                        !controller.isPasswordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color(0xff90A1B9),
                                      ),
                                      onSuffixTap: () {
                                        controller.isPasswordVisible.value =
                                            !controller.isPasswordVisible.value;
                                      },
                                    )),
                                Obx(() => CustomTextField(
                                      label: "Confirm Password",
                                      hintText: "Re-enter your password",
                                      controller: controller
                                          .confirmPasswordController.value,
                                      obscureText:
                                          controller.isPasswordVisible.value,
                                      validator: Constant.validatePassword,
                                      suffixIcon: Icon(
                                        !controller.isPasswordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color(0xff90A1B9),
                                      ),
                                      onSuffixTap: () {
                                        controller.isPasswordVisible.value =
                                            !controller.isPasswordVisible.value;
                                      },
                                    )),
                              ],

                              spaceH(height: 20),

                              /// 🎁 BONUS
                              SectionHeader(
                                icon: Icons.card_giftcard_outlined,
                                title: "BONUS",
                              ),

                              spaceH(height: 16),

                              CustomTextField(
                                label: "Referral Code (Optional)",
                                hintText: "Enter code if you have one",
                                controller:
                                    controller.referralCodeController.value,
                              ),

                              spaceH(height: 24),

                              /// 🔵 CREATE ACCOUNT
                              GradientRoundShapeButton(
                                title: "Create Account",
                                size: Size(double.infinity, 52.h),
                                gradientColors: const [
                                  Color(0xff4F39F6),
                                  Color(0xff615FFF),
                                  Color(0xff155DFC),
                                ],
                                onTap: () async {
                                  if (!formKey.currentState!.validate()) {
                                    ShowToastDialog.toast(
                                        "Please fill in all required fields."
                                            .tr);
                                    return;
                                  }

                                  if (controller.loginType.value ==
                                      Constant.emailLoginType) {
                                    if (controller
                                            .passwordController.value.text !=
                                        controller.confirmPasswordController
                                            .value.text) {
                                      ShowToastDialog.toast(
                                          "Passwords do not match.".tr);
                                      return;
                                    }
                                    await controller.signUp();
                                  } else {
                                    controller.saveData();
                                  }
                                },
                              ),

                              spaceH(height: 18),

                              /// 🔁 LOGIN LINK
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Already have an account? ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppThemeData.grey600,
                                      fontFamily: FontFamily.regular,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Log in",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppThemeData.accent300,
                                          fontFamily: FontFamily.medium,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () =>
                                              Get.to(() => LoginScreenView()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      spaceH(height: 24),

                      /// 📜 TERMS
                      Text(
                        "By creating an account, you agree to our Terms & Privacy Policy",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppThemeData.grey500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      spaceH(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: const Color(0xffE0E7FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 14, color: const Color(0xff4F39F6)),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 1,
            fontFamily: FontFamily.medium,
            color: Color(0xff45556C),
          ),
        ),
        Expanded(child: CustomLine())
      ],
    );
  }
}
