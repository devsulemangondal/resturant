// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/home/views/in_prepare_order_widget.dart';
import 'package:restaurant/app/modules/home/views/new_order_widget.dart';
import 'package:restaurant/app/modules/my_wallet/views/my_wallet_view.dart';
import 'package:restaurant/app/modules/notification_screen/views/notification_screen_view.dart';
import 'package:restaurant/app/widget/custom_app_bar.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/responsive.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Container(
          width: Responsive.width(100, context),
          height: Responsive.height(100, context),
          decoration: BoxDecoration(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                CustomAppBar(),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: controller.isLoading.value == true
                      ? Constant.loader()
                      : Constant.ownerModel!.isVerified != true
                          ? Container(
                              height: 68.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppThemeData.secondary50),
                              child: TextCustom(
                                title:
                                    "Your restaurant account is not verified. Please contact the admin for approval."
                                        .tr,
                                maxLine: 3,
                                fontFamily: FontFamily.mediumItalic,
                                textAlign: TextAlign.left,
                                color: AppThemeData.secondary300,
                              ),
                            )
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextCustom(
                                        title: "RESTAURANT STATUS".tr,
                                        color: Color(0xff62748E),
                                        fontSize: 12),
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  height: 75,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffE2E8F0)),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 36,
                                            width: 36,
                                            decoration: BoxDecoration(
                                              color: controller.restaurantStatus
                                                          .value ==
                                                      false
                                                  ? Color(0xff90A1B9)
                                                  : AppThemeData.primary300,
                                              gradient: controller
                                                          .restaurantStatus
                                                          .value ==
                                                      false
                                                  ? null
                                                  : LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        AppThemeData.accent300,
                                                        AppThemeData.primary300,
                                                      ],
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.all(14),
                                            child: Container(
                                                decoration: BoxDecoration(
                                              color: AppThemeData.primaryWhite,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            )),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextCustom(
                                                title: "Active".tr,
                                                fontSize: 16,
                                                fontFamily: FontFamily.regular,
                                                color: Color(0xff1D293D),
                                              ),
                                              TextCustom(
                                                title: "Accepting orders".tr,
                                                fontSize: 10,
                                                fontFamily: FontFamily.regular,
                                                color: Color(0xff62748E),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Switch(
                                            value: controller
                                                .restaurantStatus.value,
                                            onChanged: (value) {
                                              if (Constant.ownerModel!
                                                          .vendorId !=
                                                      null &&
                                                  Constant.ownerModel!.vendorId!
                                                      .isNotEmpty) {
                                                controller.restaurantStatus
                                                    .value = value;
                                                controller.isOnlineRestaurant();
                                              } else {
                                                ShowToastDialog.toast(
                                                    "First Add your restaurant to change Status."
                                                        .tr);
                                              }
                                            },
                                            activeTrackColor:
                                                AppThemeData.primary300,
                                            activeColor:
                                                themeChange.isDarkTheme()
                                                    ? AppThemeData.grey1000
                                                    : AppThemeData.grey100,
                                            inactiveTrackColor:
                                                Color(0xffCAD5E2),
                                            inactiveThumbColor: Colors.white,
                                            trackOutlineColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (states) {
                                              if (!states.contains(
                                                  MaterialState.selected)) {
                                                return themeChange.isDarkTheme()
                                                    ? AppThemeData.grey500
                                                    : AppThemeData.primaryWhite;
                                              }
                                              return AppThemeData.primary300;
                                            }),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                ),
                spaceH(height: 18.h),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.all(4),
                          decoration: BoxDecoration(
                              color: Color(0xffF1F5F9),
                              borderRadius: BorderRadius.circular(14)),
                          child: TabBar(
                            controller: controller.tabController,
                            isScrollable: false,
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.bold,
                                color: Colors.white),
                            unselectedLabelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.medium,
                                color: Color(0xff45556C)),
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppThemeData.accent300,
                                  AppThemeData.primary300,
                                ],
                              ),
                              color: AppThemeData.primary300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: AppThemeData.primary300,
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.inbox_outlined, size: 20),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "New orders".tr,
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.local_fire_department_outlined,
                                        size: 20),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "In Prepare".tr,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: [
                              NewOrderWidget(),
                              InPrepareOrderWidget()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
