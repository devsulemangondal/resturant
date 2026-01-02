import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:restaurant/app/modules/dashboard_screen/controllers/dashboard_screen_controller.dart';
import 'package:restaurant/app/modules/my_wallet/views/my_wallet_view.dart';
import 'package:restaurant/app/modules/notification_screen/views/notification_screen_view.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        color: AppThemeData.primary300,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppThemeData.accent300,
            AppThemeData.primary300,
          ],
        ),
      ),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: AppThemeData.primaryWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Container(
                      decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppThemeData.accent300,
                        AppThemeData.primary300,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  )),
                ),
                SizedBox(
                  width: 4,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      title: "OrderDesk".tr,
                      fontSize: 16,
                      fontFamily: FontFamily.regular,
                      color: AppThemeData.primaryWhite,
                    ),
                    TextCustom(
                      title: "PROFESSIONAL".tr,
                      fontSize: 10,
                      fontFamily: FontFamily.regular,
                      color: AppThemeData.primaryWhite,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => MyWalletView());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: SvgPicture.asset(
                      "assets/icons/ic-menu.svg",
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => NotificationScreenView());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: SvgPicture.asset(
                      "assets/icons/ic-notification.svg",
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.find<DashboardScreenController>().selectedIndex.value =
                        4;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: SvgPicture.asset(
                      "assets/icons/ic-profile.svg",
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
