// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';
import 'package:restaurant/utils/rotating_widget.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder(
      init: SplashScreenController(),
      builder: (GetxController controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/app-icon.jpeg",
                  height: 120,
                ),
                TextCustom(
                  title: "Zezale",
                  fontSize: 24,
                  fontFamily: FontFamily.regular,
                  color: themeChange.isDarkTheme()
                      ? AppThemeData.grey100
                      : Color(0xff1D293D),
                ),
                Image.asset(
                  "assets/images/splash-underline.png",
                  height: 3,
                ),
                spaceH(height: 12),
                TextCustom(
                    title: "Where Excellence Meets Efficiency",
                    fontSize: 14,
                    fontFamily: FontFamily.regular,
                    color: themeChange.isDarkTheme()
                        ? AppThemeData.grey100
                        : Color(0xff45556C)),
                TextCustom(
                    title: "Elevate Your Service",
                    fontSize: 12,
                    fontFamily: FontFamily.regular,
                    color: themeChange.isDarkTheme()
                        ? AppThemeData.grey100
                        : Color(0xff90A1B9)),
                spaceH(height: 47),
                RotatingWidget(
                  duration: const Duration(seconds: 15),
                  spinning: true,
                  child: Image.asset(
                    "assets/images/splash-loader.png",
                    height: 64,
                  ),
                ),
                spaceH(height: 20),
                TextCustom(
                    title: "Preparing Your Experience",
                    fontSize: 12,
                    fontFamily: FontFamily.regular,
                    color: themeChange.isDarkTheme()
                        ? AppThemeData.grey100
                        : Color(0xff62748E)),
                spaceH(height: 10),
                const LoadingDots(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          activeIndex = (_controller.value * 3).floor() % 3;
        });
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final bool isActive = index == activeIndex;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? (themeChange.isDarkTheme()
                      ? Colors.white
                      : const Color(0xff7C86FF))
                  : (themeChange.isDarkTheme()
                      ? AppThemeData.grey100.withOpacity(0.3)
                      : const Color(0xff7C86FF).withOpacity(0.3)),
            ),
          ),
        );
      }),
    );
  }
}
