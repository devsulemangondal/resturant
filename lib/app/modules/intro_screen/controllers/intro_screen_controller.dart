import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/app/models/onboarding_model.dart';
import 'package:restaurant/utils/fire_store_utils.dart';

class IntroScreenController extends GetxController {
  PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  RxList<OnboardingScreenModel> onboardingList = <OnboardingScreenModel>[
    OnboardingScreenModel(
      title: "Tasty Meal Delivered to Your Doorstep",
      description:
          "Order delicious food from your favorite restaurants and get it delivered fresh and fast, right to your door.",
      lightModeImage: "assets/images/intro-1.png",
      darkModeImage: "assets/images/intro-1.png",
    ),
    OnboardingScreenModel(
      title: "Manage Your Restaurant Easily",
      description:
          "Take control of your menu, track orders in real-time, and analyze performance with powerful management tools.",
      lightModeImage: "assets/images/intro-2.png",
      darkModeImage: "assets/images/intro-2.png",
    ),
    OnboardingScreenModel(
      title: "Track Performance & Grow Faster",
      description:
          "Monitor sales, revenue trends, and customer insights with comprehensive analytics to scale your business.",
      lightModeImage: "assets/images/intro-3.png",
      darkModeImage: "assets/images/intro-3.png",
    ),
  ].obs;

  @override
  void onInit() {
    // getOnboarding();
    super.onInit();
  }

  Future<void> getOnboarding() async {
    try {
      await FireStoreUtils.getOnboardingDataList().then((value) {
        onboardingList.value = value;
      });
    } catch (error) {
      debugPrint("Error fetching onboarding data: $error");
    }
  }
}
