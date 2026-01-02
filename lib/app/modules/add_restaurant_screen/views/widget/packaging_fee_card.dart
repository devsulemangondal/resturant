import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/widget/text_field_widget.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class PackagingFeeCard extends StatelessWidget {
  final bool isEnabled;
  final ValueChanged<bool> onToggle;
  final TextEditingController priceController;

  const PackagingFeeCard({
    super.key,
    required this.isEnabled,
    required this.onToggle,
    required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeChange.isDarkTheme() ? AppThemeData.grey900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 HEADER ROW
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E7FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: Color(0xFF4F39F6),
                ),
              ),
              const SizedBox(width: 12),

              /// TITLE + SUBTITLE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      title: "Packaging Fee".tr,
                      fontSize: 16,
                      fontFamily: FontFamily.medium,
                      color: themeChange.isDarkTheme()
                          ? AppThemeData.grey100
                          : AppThemeData.grey900,
                    ),
                    const SizedBox(height: 2),
                    TextCustom(
                      title: "Charge for packaging materials".tr,
                      fontSize: 13,
                      fontFamily: FontFamily.regular,
                      color: AppThemeData.grey500,
                    ),
                  ],
                ),
              ),

              /// SWITCH
              CupertinoSwitch(
                activeTrackColor: AppThemeData.primary300,
                value: isEnabled,
                onChanged: onToggle,
              ),
            ],
          ),

          /// 🔽 EXPANDED SECTION
          if (isEnabled) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 4),
            TextFieldWidget(
              isRequired: false,
              title: "Enter Packaging Fee",
              hintText: "0.00",
              controller: priceController,
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              
            ),
            const SizedBox(height: 6),
            TextCustom(
              title: "Amount charged per order for packaging".tr,
              fontSize: 12,
              fontFamily: FontFamily.regular,
              color: AppThemeData.grey500,
            ),
          ],
        ],
      ),
    );
  }
}
