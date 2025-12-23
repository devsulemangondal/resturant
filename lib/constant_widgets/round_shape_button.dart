import 'package:flutter/material.dart';
import 'package:restaurant/themes/app_fonts.dart';

class RoundShapeButton extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onTap;
  final Size size;
  final double? textSize;
  final Widget? titleWidget;

  const RoundShapeButton({
    super.key,
    required this.title,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onTap,
    this.textSize,
    this.titleWidget,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all<Size>(size),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
          elevation: WidgetStateProperty.all<double>(0),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              // side: BorderSide(color: buttonColor),
            ),
          ),
        ),
        onPressed: onTap,
        child: titleWidget ??
            Text(title,
                style: TextStyle(
                  fontFamily: FontFamily.medium,
                  fontSize: textSize ?? 16,
                  fontWeight: FontWeight.w600,
                  color: buttonTextColor,
                )));
  }
}




class GradientRoundShapeButton extends StatelessWidget {
  final String title;
  final List<Color> gradientColors;
  final VoidCallback onTap;
  final Size size;
  final double? textSize;
  final Widget? titleWidget;
  final double borderRadius;

  const GradientRoundShapeButton({
    super.key,
    required this.title,
    required this.gradientColors,
    required this.onTap,
    required this.size,
    this.textSize,
    this.titleWidget,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: titleWidget ??
            Text(
              title,
              style: TextStyle(
                fontFamily: FontFamily.medium,
                fontSize: textSize ?? 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
      ),
    );
  }
}
