import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:restaurant/app/modules/my_wallet/views/my_wallet_view.dart';
import 'package:restaurant/app/modules/notification_screen/views/notification_screen_view.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';

class ProfileCustomAppBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  const ProfileCustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (showBackButton)
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff5952f8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Icon(Icons.arrow_back_rounded,
                          color: Colors.white, size: 20)),
                ),
              ),
            if (showBackButton)
              SizedBox(
                width: 16,
              ),
            TextCustom(
              title: title.tr,
              fontSize: 20,
              fontFamily: FontFamily.regular,
              color: AppThemeData.primaryWhite,
            ),
          ],
        ),
      )),
    );
  }
}
