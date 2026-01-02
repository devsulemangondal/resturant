// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/edit_profile_screen/controllers/edit_profile_screen_controller.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/network_image_widget.dart';
import 'package:restaurant/app/widget/profile_custom_app_bar.dart';
import 'package:restaurant/app/widget/text_field_widget.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/responsive.dart';
import 'package:restaurant/themes/screen_size.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class EditProfileScreenView extends StatelessWidget {
  const EditProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX<EditProfileScreenController>(
        init: EditProfileScreenController(),
        builder: (controller) {
          print(Constant.ownerModel!.countryCode.toString().toString());
          return Container(
            width: Responsive.width(100, context),
            height: Responsive.height(100, context),
            decoration: BoxDecoration(color: Colors.white),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileCustomAppBar(
                          title: "Edit Profile".tr,
                          showBackButton: true,
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              spaceH(height: 32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                        height: 116.w,
                                        width: 116.w,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: controller.isLoading.value
                                              ? Constant.loader()
                                              : controller.profileImage.value
                                                      .isNotEmpty
                                                  ? (Constant.hasValidUrl(
                                                          controller
                                                              .profileImage
                                                              .value))
                                                      ? NetworkImageWidget(
                                                          imageUrl: controller
                                                              .profileImage
                                                              .value,
                                                          height: 56.h,
                                                          width: 56.h,
                                                          borderRadius: 0,
                                                          fit: BoxFit.cover,
                                                          isProfile: true,
                                                        )
                                                      : Image.asset(
                                                          controller
                                                              .profileImage
                                                              .value,
                                                          height: 56.h,
                                                          width: 56.h,
                                                          fit: BoxFit.cover,
                                                        )
                                                  : Image.asset(
                                                      Constant.userPlaceHolder,
                                                      height: 56.h,
                                                      width: 56.h,
                                                      fit: BoxFit.cover,
                                                    ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          buildBottomSheet(
                                              context, controller, themeChange);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 4, bottom: 4),
                                          height: 32.h,
                                          width: 32.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppThemeData.primary300),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7),
                                            child: SvgPicture.asset(
                                              "assets/icons/ic_camera.svg",
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Text("Tap to change photo".tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff62748E))),
                              SizedBox(
                                height: 31,
                              ),
                              CustomTextField(
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF314158), // grey
                                ),
                                label: "First Name *".tr,
                                hintText: "Enter First Name".tr,
                                controller:
                                    controller.firstNameController.value,
                                validator: (value) =>
                                    value != null && value.isNotEmpty
                                        ? null
                                        : "This field required".tr,
                              ),
                              CustomTextField(
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF314158), // grey
                                ),
                                label: "Last Name *".tr,
                                hintText: "Enter Last Name".tr,
                                controller: controller.lastNameController.value,
                                validator: (value) =>
                                    value != null && value.isNotEmpty
                                        ? null
                                        : "This field required".tr,
                              ),
                              CustomTextField(
                                label: "Email Address *",
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF314158), // grey
                                ),
                                hintText: "john.doe@example.com",
                                controller: controller.emailController.value,
                                validator: Constant.validateEmail,
                                prefixIcon: const Icon(Icons.email_outlined,
                                    color: Color(0xFF90A1B9)),
                                enabled: Constant.ownerModel!.loginType ==
                                            Constant.emailLoginType ||
                                        Constant.ownerModel!.loginType ==
                                            Constant.googleLoginType ||
                                        Constant.ownerModel!.loginType ==
                                            Constant.appleLoginType
                                    ? true
                                    : false,
                              ),
                              MobileNumberTextField(
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF314158), // grey
                                ),
                                label: "Phone Number *".tr,
                                controller:
                                    controller.mobileNumberController.value,
                                countryCode: controller.countryCode.value!,
                                onCountryChanged: (code) {
                                  controller.countryCode.value = code;
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  height: 105,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Color(0xffE2E8F0),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                      padding: paddingEdgeInsets(vertical: 22, horizontal: 24),
                      child: GradientRoundShapeButton(
                        title: "Save Details".tr,
                        size: Size(double.infinity, 52.h),
                        gradientColors: const [
                          Color(0xff4F39F6),
                          Color(0xff155DFC),
                          Color(0xff155DFC),
                        ],
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.updateProfile();
                          }
                        },
                      )),
                )),
          );
        });
  }
}

Future buildBottomSheet(BuildContext context,
    EditProfileScreenController controller, DarkThemeProvider themeChange) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: themeChange.isDarkTheme()
        ? AppThemeData.primaryBlack
        : AppThemeData.primaryWhite,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: ScreenSize.height(22, context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: paddingEdgeInsets(),
                  child: TextCustom(
                    title: "Please Select".tr,
                    fontSize: 18,
                    fontFamily: FontFamily.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: paddingEdgeInsets(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => controller.pickFile(
                                  source: ImageSource.camera),
                              icon: Icon(
                                Icons.camera_alt,
                                size: 32,
                                color: AppThemeData.primary300,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: TextCustom(
                              title: "Camera".tr,
                            ),
                          ),
                        ],
                      ),
                    ),
                    spaceW(width: 36),
                    Padding(
                      padding: paddingEdgeInsets(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => controller.pickFile(
                                  source: ImageSource.gallery),
                              icon: Icon(
                                Icons.photo,
                                size: 32,
                                color: AppThemeData.primary300,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: TextCustom(
                              title: "Gallery".tr,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
