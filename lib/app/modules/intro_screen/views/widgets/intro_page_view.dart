import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/intro_screen/controllers/intro_screen_controller.dart';
import 'package:restaurant/app/routes/app_pages.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';
import 'package:restaurant/utils/preferences.dart';

class IntroScreenPage extends StatelessWidget {
  final String title;
  final String body;
  final String image;
  final String imageDarkMode;
  final Color textColor;
  final int i;

  const IntroScreenPage(
      {super.key,
      required this.title,
      required this.body,
      required this.image,
      required this.imageDarkMode,
      required this.textColor,
      required this.i});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return SafeArea(
      child: GetX(
          init: IntroScreenController(),
          builder: (controller) {
            int index = controller.currentPage.value;
            return Column(
              children: [
                const SizedBox(height: 16),

                /// 🔵 TOP INDICATOR
                IntroPageIndicator(i: i),

                const Spacer(),

                /// 🖼 IMAGE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Image.asset(
                    themeChange.isDarkTheme() ? imageDarkMode : image,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.42,
                  ),
                ),

                const Spacer(),

                /// 📝 TITLE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      height: 1.3,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                /// 📄 DESCRIPTION
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Text(
                    body,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.6,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                /// 🔘 BUTTONS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      /// Skip
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Preferences.setBoolean(
                                Preferences.isFinishOnBoardingKey, true);
                            Get.offAllNamed(Routes.LANDING_SCREEN);
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'Skip',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      /// Next / Get Started
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (index == controller.onboardingList.length - 1) {
                              Preferences.setBoolean(
                                  Preferences.isFinishOnBoardingKey, true);
                              Get.offAllNamed(Routes.LANDING_SCREEN);
                            } else {
                              index = index + 1;
                              controller.pageController.jumpToPage(index);
                            }
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff4F39F6),
                                  Color(0xff155DFC),
                                  Color(0xff155DFC),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff4F39F6),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                index == 2 ? "Get Started" : 'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            );
          }),
    );
  }
}

class IntroPageIndicator extends StatelessWidget {
  int i;
  IntroPageIndicator({super.key, required this.i});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: i == index ? 30 : 6,
          height: 6,
          decoration: BoxDecoration(
            gradient: i == index
                ? LinearGradient(
                    colors: [
                      Color(0xff4F39F6),
                      Color(0xff155DFC),
                      Color(0xff155DFC),
                    ],
                  )
                : null,
            color: i == index ? const Color(0xff4A63FF) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
