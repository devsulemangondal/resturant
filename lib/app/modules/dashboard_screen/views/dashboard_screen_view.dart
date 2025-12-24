// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/dashboard_screen/controllers/dashboard_screen_controller.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class DashboardScreenView extends GetView<DashboardScreenController> {
  const DashboardScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder<DashboardScreenController>(
      init: DashboardScreenController(),
      builder: (controller) {
        return Scaffold(
          body: Obx(() => controller.pageList[controller.selectedIndex.value]),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color(0xffE2E8F0),
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomBarItem(
                      index: 0,
                      selectedIndex: controller.selectedIndex.value,
                      label: "Home".tr,
                      iconPath: "assets/icons/ic_home.svg",
                      onTap: () => controller.selectedIndex.value = 0,
                    ),
                    BottomBarItem(
                      index: 1,
                      selectedIndex: controller.selectedIndex.value,
                      label: "Statistic".tr,
                      iconPath: "assets/icons/ic_statistic.svg",
                      onTap: () => controller.selectedIndex.value = 1,
                    ),
                    BottomBarItem(
                      index: 2,
                      selectedIndex: controller.selectedIndex.value,
                      label: "Restaurant".tr,
                      iconPath: "assets/icons/ic_restaurant.svg",
                      onTap: () => controller.selectedIndex.value = 2,
                    ),
                    BottomBarItem(
                      index: 3,
                      selectedIndex: controller.selectedIndex.value,
                      label: "Menu".tr,
                      iconPath: "assets/icons/ic_menu.svg",
                      onTap: () => controller.selectedIndex.value = 3,
                    ),
                    BottomBarItem(
                      index: 4,
                      selectedIndex: controller.selectedIndex.value,
                      label: "Profile".tr,
                      iconPath: "assets/icons/ic_profile.svg",
                      onTap: () => controller.selectedIndex.value = 4,
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class BottomBarItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String label;
  final String iconPath;
  final VoidCallback onTap;

  const BottomBarItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.label,
    required this.iconPath,
    required this.onTap,
  });

  bool get isSelected => index == selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      colors: [
                        AppThemeData.accent300,
                        AppThemeData.primary300,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              iconPath,
              width: 20,
              height: 20,
              color:
                  isSelected ? AppThemeData.primaryWhite : AppThemeData.grey500,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label.tr,
          style: TextStyle(
            fontSize: 12,
            fontFamily: FontFamily.regular,
            color: isSelected ? const Color(0xff1D293D) : AppThemeData.grey500,
          ),
        ),
      ],
    );
  }
}
