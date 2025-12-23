// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, strict_top_level_inference

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';
import 'package:restaurant/utils/validate_mobile.dart';

class TextFieldWidget extends StatelessWidget {
  final String? title;
  final String hintText;
  final validator;
  final String? icon;
  bool? obscureText = false;
  Color? color;
  final int? line;
  final TextEditingController controller;
  final Function() onPress;
  final Widget? prefix;
  final Widget? suffix;
  final bool? enable;
  final bool? enabled;
  final bool? readOnly;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  TextFieldWidget(
      {super.key,
      this.textInputType,
      this.validator,
      this.enable,
      this.icon,
      this.prefix,
      this.suffix,
      this.obscureText,
      this.title,
      required this.hintText,
      required this.controller,
      required this.onPress,
      this.enabled,
      this.readOnly,
      this.color,
      this.line,
      this.onChanged,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: validator ??
                (value) => value != null && value.isNotEmpty
                    ? null
                    : "This field required".tr,
            keyboardType: textInputType ?? TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            controller: controller,
            textAlign: TextAlign.start,
            enabled: enabled,
            obscureText: obscureText ?? false,
            readOnly: readOnly ?? false,
            maxLines: line ?? 1,
            textAlignVertical: TextAlignVertical.top,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            style: TextStyle(
                color: themeChange.isDarkTheme()
                    ? AppThemeData.grey200
                    : AppThemeData.grey800,
                fontFamily: FontFamily.regular,
                fontSize: 14),
            decoration: prefix != null
                ? InputDecoration(
                    errorStyle: const TextStyle(fontFamily: FontFamily.regular),
                    isDense: true,
                    filled: true,
                    enabled: enable ?? true,
                    fillColor: themeChange.isDarkTheme()
                        ? AppThemeData.grey900
                        : AppThemeData.grey50,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    prefix: Padding(
                      padding: EdgeInsets.only(
                        right: 12,
                      ),
                      child: prefix!,
                    ),
                    suffixIcon: Padding(
                        padding: EdgeInsets.all(suffix != null ? 12 : 0),
                        child: suffix),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey600
                              : AppThemeData.grey400,
                          width: 1),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey600
                              : AppThemeData.grey400,
                          width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey600
                              : AppThemeData.grey400,
                          width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppThemeData.danger300, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey600
                              : AppThemeData.grey400,
                          width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppThemeData.primary300, width: 1),
                    ),
                    hintText: hintText.tr,
                    labelText: title?.tr,
                    labelStyle: TextStyle(
                        fontSize: 14,
                        color: themeChange.isDarkTheme()
                            ? AppThemeData.grey200
                            : AppThemeData.grey800,
                        fontFamily: FontFamily.regular),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: themeChange.isDarkTheme()
                            ? AppThemeData.grey400
                            : AppThemeData.grey600,
                        fontFamily: FontFamily.regular))
                : InputDecoration(
                    errorStyle: const TextStyle(fontFamily: FontFamily.regular),
                    isDense: true,
                    filled: true,
                    enabled: enable ?? true,
                    fillColor: themeChange.isDarkTheme()
                        ? AppThemeData.grey900
                        : AppThemeData.grey50,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    suffixIcon: Padding(
                        padding: EdgeInsets.all(suffix != null ? 12 : 0),
                        child: suffix),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey600
                              : AppThemeData.grey400,
                          width: 1),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey600
                              : AppThemeData.grey400,
                          width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey600
                              : AppThemeData.grey400,
                          width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppThemeData.danger300, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey600
                              : AppThemeData.grey400,
                          width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: AppThemeData.primary300, width: 1),
                    ),
                    hintText: hintText.tr,
                    labelText: title!.tr,
                    labelStyle: TextStyle(
                        fontSize: 14,
                        color: themeChange.isDarkTheme()
                            ? AppThemeData.grey200
                            : AppThemeData.grey800,
                        fontFamily: FontFamily.regular),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: themeChange.isDarkTheme()
                            ? AppThemeData.grey400
                            : AppThemeData.grey600,
                        fontFamily: FontFamily.regular)),
          ),
        ],
      ),
    );
  }
}

class MobileNumberTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  String countryCode;
  final Function(String) onCountryChanged;
  final bool enabled;
  final bool readOnly;
  final String? Function(String?)? validator;

  MobileNumberTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.countryCode,
    required this.onCountryChanged,
    this.enabled = true,
    this.readOnly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔤 LABEL
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: FontFamily.medium,
            color: Color(0xFF62748E),
          ),
        ),
        const SizedBox(height: 4),

        /// 📞 COUNTRY + PHONE
        Row(
          children: [
            /// 🌍 COUNTRY CODE BOX
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE5E7EB)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CountryCodePicker(
                showFlag: true,
                initialSelection: countryCode,
                onChanged: (value) {
                  countryCode = value.dialCode ?? '';
                  onCountryChanged(countryCode);
                },
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: FontFamily.regular,
                  color: Color(0xFF45556C),
                ),
                dialogTextStyle: const TextStyle(
                  fontFamily: FontFamily.regular,
                ),
                searchStyle: const TextStyle(
                  fontFamily: FontFamily.regular,
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// 📱 PHONE NUMBER BOX
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: controller,
                  enabled: enabled,
                  readOnly: readOnly,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: validator ??
                      (value) => validateMobile(value, countryCode),
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: FontFamily.regular,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Enter phone number",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF90A1B9),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixTap;
  final int maxLines;
  final bool enabled;
  final Color? fillColor;
  final Color? borderColor;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onSuffixTap,
    this.maxLines = 1,
    this.enabled = true,
    this.fillColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔤 LABEL
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: FontFamily.medium,
            color: Color(0xFF62748E), // grey
          ),
        ),

        const SizedBox(height: 4),

        /// 🧾 TEXT FIELD CONTAINER
        Container(
          decoration: BoxDecoration(
            color: fillColor ?? Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: borderColor ?? const Color(0xFFE5E7EB),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            maxLines: maxLines,
            enabled: enabled,
            validator: validator,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: FontFamily.regular,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFF90A1B9),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                      onTap: onSuffixTap,
                      child: suffixIcon,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
