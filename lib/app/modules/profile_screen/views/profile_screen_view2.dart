// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/views/widget/upload_document.dart';
import 'package:restaurant/app/modules/all_orders/views/all_orders_view.dart';
import 'package:restaurant/app/modules/dashboard_screen/controllers/dashboard_screen_controller.dart';
import 'package:restaurant/app/modules/driver_details/views/driver_details_views.dart';
import 'package:restaurant/app/modules/edit_profile_screen/views/edit_profile_screen_view.dart';
import 'package:restaurant/app/modules/language_screen/views/language_screen_view.dart';
import 'package:restaurant/app/modules/login_screen/views/login_screen_view.dart';
import 'package:restaurant/app/modules/my_bank/views/my_bank_view.dart';
import 'package:restaurant/app/modules/my_wallet/views/my_wallet_view.dart';
import 'package:restaurant/app/modules/notification_screen/views/notification_screen_view.dart';
import 'package:restaurant/app/modules/privacy_policy_screen/views/privacy_policy_screen_view.dart';
import 'package:restaurant/app/modules/profile_screen/controllers/profile_screen_controller.dart';
import 'package:restaurant/app/modules/referral_screen/views/referral_screen_view.dart';
import 'package:restaurant/app/modules/statement_screen/views/statement_view.dart';
import 'package:restaurant/app/routes/app_pages.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/network_image_widget.dart';
import 'package:restaurant/app/widget/profile_custom_app_bar.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant_widgets/custom_dialog_box.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/responsive.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';
import '../../../../constant/show_toast_dialogue.dart';

class ProfileScreenView2 extends StatelessWidget {
  const ProfileScreenView2({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
        autoRemove: false,
        init: ProfileScreenController(),
        builder: (controller) {
          return Container(
            width: Responsive.width(100, context),
            height: Responsive.height(100, context),
            decoration: BoxDecoration(color: Colors.white),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileCustomAppBar(
                    title: "Profile".tr,
                    showBackButton: false,
                  ),
                  ProfileHeaderCard(
                    name: controller.ownerModel.value.fullNameString(),
                    email: controller.ownerModel.value.email.toString(),
                    phone: controller.ownerModel.value.phoneNumber.toString(),
                    imageUrl:
                        controller.ownerModel.value.profileImage.toString(),
                    onEditTap: () {
                      Get.to(() => EditProfileScreenView());
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            spaceH(height: 4),
                            labelWidget(name: "Services".tr),
                            Constant.isSelfDelivery == true
                                ? Padding(
                                    padding: paddingEdgeInsets(
                                        horizontal: 0, vertical: 4),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: themeChange.isDarkTheme()
                                                ? AppThemeData.grey900
                                                : AppThemeData.grey50,
                                          ),
                                          height: 46.h,
                                          width: 46.w,
                                          child: Center(
                                            child: SizedBox(
                                              height: 18.h,
                                              width: 18.w,
                                              child: SvgPicture.asset(
                                                "assets/icons/ic_selfdelivery.svg",
                                                color: AppThemeData.pending400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        spaceW(),
                                        TextCustom(
                                          title: "SelfDelivery".tr,
                                          fontSize: 16,
                                          fontFamily: FontFamily.bold,
                                          color: themeChange.isDarkTheme()
                                              ? AppThemeData.grey50
                                              : AppThemeData.grey1000,
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          height: 26.h,
                                          child: FittedBox(
                                            child: CupertinoSwitch(
                                              activeTrackColor:
                                                  AppThemeData.primary300,
                                              value: controller
                                                  .isSelfDelivery.value,
                                              onChanged: (value) {
                                                if (Constant.vendorModel !=
                                                    null) {
                                                  controller.isSelfDelivery
                                                      .value = value;
                                                  controller
                                                      .isSelfDeliveryRestaurant();
                                                } else {
                                                  ShowToastDialog.toast(
                                                      "First Add your restaurant to change Status."
                                                          .tr);
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            (Constant.isSelfDelivery == true &&
                                    controller
                                            .vendorModel.value.isSelfDelivery ==
                                        true)
                                ? GestureDetector(
                                    child: rowWidget(
                                        name: "Drivers".tr,
                                        icon: "assets/icons/ic_bank.svg"),
                                    onTap: () {
                                      Get.to(() => DriverDetailsViews());
                                    },
                                  )
                                : SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ServiceGridItem(
                                  title: "My Wallet",
                                  iconPath: "assets/icons/ic_wallet_2.svg",
                                  iconBgColor:
                                      const Color(0xFF8B5CF6), // purple
                                  onTap: () {
                                    Get.to(() => MyWalletView());
                                  },
                                ),
                                spaceW(width: 12),
                                ServiceGridItem(
                                  title: "My Bank",
                                  iconPath: "assets/icons/ic_bank.svg",
                                  iconBgColor: const Color(0xFF3B82F6), // blue
                                  onTap: () {
                                    Get.to(() => MyBankView());
                                  },
                                ),
                                spaceW(width: 12),
                                ServiceGridItem(
                                  title: "All Orders",
                                  iconPath: "assets/icons/ic_order.svg",
                                  iconBgColor: const Color(0xFF22C55E), // green
                                  onTap: () {
                                    Get.to(() => AllOrdersView());
                                  },
                                ),
                              ],
                            ),
                            spaceH(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ServiceGridItem(
                                  title: "Notifications",
                                  iconPath: "assets/icons/ic_bell_2.svg",
                                  iconBgColor:
                                      const Color(0xFFF97316), // orange
                                  onTap: () {
                                    Get.to(() => NotificationScreenView());
                                  },
                                ),
                                spaceW(width: 12),
                                ServiceGridItem(
                                  title: "Order\nStatement",
                                  iconPath: "assets/icons/ic_downlod.svg",
                                  iconBgColor:
                                      const Color(0xFF6366F1), // indigo
                                  onTap: () {
                                    Get.to(() => StatementView());
                                  },
                                ),
                                spaceW(width: 12),
                                ServiceGridItem(
                                  title: "Refer & Earn",
                                  iconPath: "assets/icons/ic_refer.svg",
                                  iconBgColor: const Color(0xFFEC4899), // pink
                                  onTap: () {
                                    Get.to(() => ReferralScreenView());
                                  },
                                ),
                              ],
                            ),
                            if (Constant.isDocumentVerificationEnable == true)
                              GestureDetector(
                                child: rowWidget(
                                    name: "Document".tr,
                                    icon: "assets/icons/ic_document.svg",
                                    iconColor: AppThemeData.success300),
                                onTap: () {
                                  Get.to(() => UploadDocumentView());
                                },
                              ),
                            labelWidget(name: "About".tr),
                            ProfileOptionCard(
                              children: [
                                ProfileOptionTile(
                                  icon: Icons.shield_outlined,
                                  title: "Privacy & Policy",
                                  onTap: () {
                                    Get.to(() => PrivacyPolicyScreenView(
                                        title: "Privacy & Policy".tr,
                                        htmlData: Constant.privacyPolicy));
                                  },
                                ),
                                ProfileOptionTile(
                                  icon: Icons.info_outline,
                                  title: "About App",
                                  onTap: () {
                                    Get.to(() => PrivacyPolicyScreenView(
                                        title: "AboutApp".tr,
                                        htmlData: Constant.aboutApp));
                                  },
                                ),
                                ProfileOptionTile(
                                  icon: Icons.description_outlined,
                                  title: "Terms & Conditions",
                                  onTap: () {
                                    Get.to(() => PrivacyPolicyScreenView(
                                        title: "Terms & Condition".tr,
                                        htmlData: Constant.termsAndConditions));
                                  },
                                ),
                              ],
                            ),
                            labelWidget(name: "App Settings".tr),
                            ProfileOptionCard(
                              children: [
                                /// 🌙 DARK MODE
                                // ProfileOptionTile(
                                //   icon: Icons.dark_mode_outlined,
                                //   iconColor: Colors.white,
                                //   title: "Dark Mode",
                                //   trailing: Switch(
                                //     value: themeChange.isDarkTheme(),
                                //     activeColor: Colors.white,
                                //     activeTrackColor: const Color(0xFF4F39F6),
                                //     onChanged: (value) {
                                //       themeChange.darkTheme = value ? 1 : 0;
                                //     },
                                //   ), onTap: () {  },
                                // ),

                                /// 🌐 LANGUAGE
                                // ProfileOptionTile(
                                //   icon: Icons.language,
                                //   iconColor: Color(0xff4F39F6),
                                //   boxColor: Color(0xffE0E7FF),
                                //   title: "Language",
                                //   onTap: () {
                                //     Get.to(() => LanguageScreenView());
                                //   },
                                // ),

                                /// 🗑 DELETE ACCOUNT
                                ProfileOptionTile(
                                  icon: Icons.delete_outline,
                                  iconColor: Colors.red,
                                  boxColor: Color(0xffFFC9C9),
                                  title: "Delete Account",
                                  textColor: Colors.red,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                          themeChange: themeChange,
                                          title: "Delete Account".tr,
                                          descriptions:
                                              "Your account will be deleted permanently. Your Data will not be Restored Again"
                                                  .tr,
                                          positiveString: "Delete".tr,
                                          negativeString: "Cancel".tr,
                                          positiveClick: () async {
                                            Navigator.pop(context);
                                            await controller
                                                .deleteUserAccount();
                                            await FirebaseAuth.instance
                                                .signOut();
                                            Get.offAllNamed(
                                                Routes.LANDING_SCREEN);
                                            ShowToastDialog.toast(
                                                "Account Deleted Successfully..");
                                          },
                                          negativeClick: () =>
                                              Navigator.pop(context),
                                          img: Image.asset(
                                            "assets/animation/am_delete.gif",
                                            height: 64.h,
                                            width: 64.w,
                                          ),
                                          positiveButtonColor:
                                              AppThemeData.primary300,
                                          positiveButtonTextColor:
                                              themeChange.isDarkTheme()
                                                  ? AppThemeData.grey1000
                                                  : AppThemeData.textBlack,
                                          negativeButtonColor:
                                              themeChange.isDarkTheme()
                                                  ? AppThemeData.grey1000
                                                  : AppThemeData.grey50,
                                          negativeButtonTextColor:
                                              themeChange.isDarkTheme()
                                                  ? AppThemeData.grey100
                                                  : AppThemeData.grey900,
                                          negativeButtonBorderColor:
                                              themeChange.isDarkTheme()
                                                  ? AppThemeData.grey600
                                                  : AppThemeData.grey400,
                                        );
                                      },
                                    );
                                  },
                                ),

                                /// 🚪 LOGOUT
                                ProfileOptionTile(
                                  icon: Icons.logout_rounded,
                                  iconColor: Colors.red,
                                  title: "Logout",
                                  boxColor: Color(0xffFFC9C9),
                                  textColor: Colors.red,
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogBox(
                                            themeChange: themeChange,
                                            title: "Logout".tr,
                                            descriptions:
                                                "Logging out will require you to sign in again to access your account."
                                                    .tr,
                                            positiveString: "Log out".tr,
                                            negativeString: "Cancel".tr,
                                            positiveClick: () async {
                                              await FirebaseAuth.instance
                                                  .signOut();
                                              Constant.ownerModel = null;
                                              if (Constant.vendorModel !=
                                                  null) {
                                                Constant.vendorModel = null;
                                              }

                                              Navigator.pop(context);
                                              Get.offAll(LoginScreenView());
                                            },
                                            negativeClick: () {
                                              Navigator.pop(context);
                                            },
                                            img: Image.asset(
                                              "assets/animation/exit.gif",
                                              height: 64.h,
                                              width: 64.w,
                                            ),
                                            positiveButtonColor:
                                                AppThemeData.primary300,
                                            positiveButtonTextColor:
                                                themeChange.isDarkTheme()
                                                    ? AppThemeData.grey1000
                                                    : AppThemeData.textBlack,
                                            negativeButtonColor:
                                                themeChange.isDarkTheme()
                                                    ? AppThemeData.grey1000
                                                    : AppThemeData.grey50,
                                            negativeButtonTextColor:
                                                themeChange.isDarkTheme()
                                                    ? AppThemeData.grey100
                                                    : AppThemeData.grey900,
                                            negativeButtonBorderColor:
                                                themeChange.isDarkTheme()
                                                    ? AppThemeData.grey600
                                                    : AppThemeData.grey400,
                                          );
                                        });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

Padding labelWidget({required String name}) {
  try {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 20),
      child: TextCustom(
        title: name.tr,
        fontSize: 14,
        fontFamily: FontFamily.regular,
      ),
    );
  } catch (e) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 20),
      child: Text(
        "Label Error".tr,
        style: TextStyle(fontSize: 16, color: Colors.red),
      ),
    );
  }
}

Padding rowWidget({
  required String name,
  required String icon,
  Color? iconColor,
  Color? textColor,
}) {
  try {
    final themeChange = Provider.of<DarkThemeProvider>(Get.context!);

    return Padding(
      padding: paddingEdgeInsets(horizontal: 0, vertical: 4),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeChange.isDarkTheme()
                  ? AppThemeData.grey900
                  : AppThemeData.grey50,
            ),
            height: 46.h,
            width: 46.w,
            child: Center(
              child: SizedBox(
                height: 18.h,
                width: 18.w,
                child: SvgPicture.asset(icon, color: iconColor),
              ),
            ),
          ),
          spaceW(),
          TextCustom(
            title: name.tr,
            fontSize: 16,
            fontFamily: FontFamily.bold,
            color: textColor ??
                (themeChange.isDarkTheme()
                    ? AppThemeData.grey50
                    : AppThemeData.grey1000),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppThemeData.grey500,
            size: 15,
          )
        ],
      ),
    );
  } catch (e) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(Icons.error, color: Colors.red),
          SizedBox(width: 8),
          Text(
            "Error loading row".tr,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String imageUrl;
  final VoidCallback onEditTap;

  ProfileHeaderCard({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.onEditTap,
  });

  ProfileScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
        border: Border.all(
          color: const Color(0xFFC6D2FF),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          /// 🔹 TOP ROW
          Row(
            children: [
              Obx(
                () => NetworkImageWidget(
                  imageUrl: controller.ownerModel.value.profileImage.toString(),
                  height: 78.w,
                  width: 78.w,
                  borderRadius: 200,
                  fit: BoxFit.cover,
                  isProfile: true,
                ),
              ),
              const SizedBox(width: 16),

              /// USER INFO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF1D293D),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF62748E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF90A1B9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// 🔵 EDIT PROFILE BUTTON
          ///
          Container(
            width: double.infinity,
            child: GradientRoundShapeButton(
              titleWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Edit Profile".tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              size: Size(double.infinity, 52.h),
              gradientColors: [
                Color(0xff4F39F6),
                Color(0xff155DFC),
                Color(0xff155DFC),
              ],
              onTap: onEditTap,
              title: '',
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceGridItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color iconBgColor;
  final VoidCallback onTap;

  const ServiceGridItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.iconBgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 110,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// ICON CONTAINER
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: iconBgColor.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    height: 24,
                    width: 24,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(
                height: 6,
              ),

              /// TITLE
              Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF314158),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color textColor;
  final Color iconColor;
  final Color boxColor;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = const Color(0xFF475569),
    this.trailing,
    this.textColor = const Color(0xFF314158),
    this.boxColor = const Color(0xFFF1F5F9),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            /// LEFT ICON
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: boxColor ?? const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 22,
              ),
            ),

            const SizedBox(width: 14),

            /// TITLE
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: textColor ?? Color(0xFF314158),
                ),
              ),
            ),

            /// RIGHT ARROW
            trailing ??
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF94A3B8),
                  size: 26,
                ),
          ],
        ),
      ),
    );
  }
}

class ProfileOptionCard extends StatelessWidget {
  final List<Widget> children;

  const ProfileOptionCard({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: _addDividers(children),
      ),
    );
  }

  List<Widget> _addDividers(List<Widget> items) {
    final List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(items[i]);
      if (i != items.length - 1) {
        widgets.add(
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE5E7EB),
          ),
        );
      }
    }
    return widgets;
  }
}
