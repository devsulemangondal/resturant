// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/views/add_restaurant_screen_view.dart';
import 'package:restaurant/app/modules/restaurant_screen/views/widget/restaurant_offer_widget.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/network_image_widget.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant_widgets/no_document_view.dart';
import 'package:restaurant/constant_widgets/no_restaurant_view.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/responsive.dart' as responsive_ui;
import 'package:restaurant/themes/screen_size.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

import '../controllers/restaurant_screen_controller.dart';

class RestaurantScreenView extends GetView<RestaurantScreenController> {
  const RestaurantScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder(
      init: RestaurantScreenController(),
      builder: (controller) {
        return Obx(() => controller.isLoading.value
            ? Constant.loader()
            : Constant.isDocumentVerificationEnable == true &&
                    controller.ownerModel.value.isVerified == false
                ? NoDocumentView(
                    themeChange: themeChange,
                    controller: controller,
                  )
                : controller.ownerModel.value.vendorId == null ||
                        controller.ownerModel.value.vendorId!.isEmpty
                    ? NoRestaurantView(
                        themeChange: themeChange,
                        controller: controller,
                      )
                    : restaurantView(context));
      },
    );
  }

  Widget restaurantView(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    int activeDays = controller.restaurantModel.value.openingHoursList
            ?.where((day) => day.isOpen == true)
            .length ??
        0;

    return Container(
      width: responsive_ui.Responsive.width(100, context),
      height: responsive_ui.Responsive.height(100, context),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: const [0.1, 0.3],
              colors: themeChange.isDarkTheme()
                  ? [const Color(0xff1C1C22), const Color(0xff1C1C22)]
                  : [const Color(0xffFDE7E7), const Color(0xffFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: themeChange.isDarkTheme()
            ? const Color(0xff1C1C22)
            : const Color(0xffFFFFFF),
        body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: ExampleAppBar(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Restaurant Name and Cuisine
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                            title: controller.restaurantModel.value.vendorName
                                .toString(),
                            fontSize: 24,
                            fontFamily: FontFamily.bold,
                            color: AppThemeData.grey1000,
                          ),
                          spaceH(height: 8),
                          Row(
                            children: [
                              TextCustom(
                                title: controller
                                    .restaurantModel.value.cuisineName
                                    .toString(),
                                fontSize: 14,
                                color: AppThemeData.grey500,
                              ),
                              spaceW(width: 12),
                              Constant.showFoodType(
                                  name: controller
                                      .restaurantModel.value.vendorType
                                      .toString())
                            ],
                          ),
                        ],
                      ),
                      spaceH(height: 24.h),
                      // Address Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey900
                              : AppThemeData.grey50,
                          border: Border.all(
                            color: Color(0xffE2E8F0),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xffDBEAFE),
                                  borderRadius: BorderRadius.circular(14)),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: Color(0xff4F39F6),
                                size: 24,
                              ),
                            ),
                            spaceW(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextCustom(
                                    title: "Restaurant Address".tr,
                                    fontSize: 14,
                                    fontFamily: FontFamily.medium,
                                    color: Color(0xff1D293D),
                                  ),
                                  spaceH(height: 4.h),
                                  TextCustom(
                                    title: controller
                                        .restaurantModel.value.address!.address
                                        .toString(),
                                    maxLine: 3,
                                    textAlign: TextAlign.start,
                                    fontSize: 14,
                                    color: Color(0xff45556C),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      spaceH(height: 16.h),
                      // Packaging Fee Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffEFF6FF),
                          border: Border.all(
                            color: Color(0xffC6D2FF),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                  title: "Packaging Fee".tr,
                                  fontSize: 14,
                                  fontFamily: FontFamily.medium,
                                  color: Color(0xff1D293D),
                                ),
                                spaceH(height: 4.h),
                                TextCustom(
                                  title: "Per order charge".tr,
                                  fontSize: 12,
                                  color: AppThemeData.grey500,
                                ),
                              ],
                            ),
                            TextCustom(
                              title: Constant.amountShow(
                                  amount: controller.restaurantModel.value
                                          .packagingFee?.price ??
                                      "0"),
                              fontSize: 16,
                              fontFamily: FontFamily.bold,
                              color: Color(0xff432DD7),
                            ),
                          ],
                        ),
                      ),
                      spaceH(height: 16.h),
                      // Opening Hours Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey900
                              : AppThemeData.grey50,
                          border: Border.all(
                            color: Color(0xffE2E8F0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule_outlined,
                                  color: Color(0xff4F39F6),
                                  size: 24,
                                ),
                                spaceW(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                      title: "Opening Hours".tr,
                                      fontSize: 14,
                                      fontFamily: FontFamily.medium,
                                      color: themeChange.isDarkTheme()
                                          ? AppThemeData.grey200
                                          : AppThemeData.grey800,
                                    ),
                                    spaceH(height: 4.h),
                                    TextCustom(
                                      title: "$activeDays days active".tr,
                                      fontSize: 12,
                                      color: AppThemeData.grey500,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to((() => AddRestaurantScreenView()),
                                    arguments: {
                                      "restaurantModel":
                                          controller.restaurantModel.value,
                                      "editPage": "Select Opening Hours"
                                    });
                              },
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color(0xff4F39F6),
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                      spaceH(height: 16.h),
                      // Restaurant Offers Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey900
                              : AppThemeData.grey50,
                          border: Border.all(
                            color: Color(0xffE2E8F0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.local_offer_outlined,
                                  color: Color(0xff4F39F6),
                                  size: 24,
                                ),
                                spaceW(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                      title: "Restaurant Offers".tr,
                                      fontSize: 14,
                                      fontFamily: FontFamily.medium,
                                      color: themeChange.isDarkTheme()
                                          ? AppThemeData.grey200
                                          : AppThemeData.grey800,
                                    ),
                                    spaceH(height: 4.h),
                                    TextCustom(
                                      title:
                                          "${controller.restaurantOfferList.length} active offers"
                                              .tr,
                                      fontSize: 12,
                                      color: AppThemeData.grey500,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.setDefaultData();
                                Get.to(() => RestaurantOfferWidget());
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff4F39F6),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      spaceH(height: 24.h),
                      // Success Message
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey900
                              : AppThemeData.grey50,
                          border: Border.all(
                            color: Color(0xffE2E8F0),
                          ),
                        ),
                        child: Center(
                          child: TextCustom(
                            title:
                                "Your restaurant profile is ready! You can edit any information from the dashboard anytime."
                                    .tr,
                            maxLine: 3,
                            textAlign: TextAlign.center,
                            fontSize: 14,
                            color: themeChange.isDarkTheme()
                                ? AppThemeData.grey300
                                : AppThemeData.grey700,
                          ),
                        ),
                      ),
                      spaceH(height: 20.h),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}

///////////////////////////////////////
class ExampleAppBar extends SliverPersistentHeaderDelegate {
  final bottomHeight = 65;
  final extraRadius = 4;

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    final themeChange = Provider.of<DarkThemeProvider>(Get.context!);

    final imageTop =
        -shrinkOffset.clamp(0.0, maxExtent - minExtent - bottomHeight);
    final double clowsingRate = (shrinkOffset == 0
            ? 0.0
            : (shrinkOffset / (maxExtent - minExtent - bottomHeight)))
        .clamp(0, 1);

    final double opacity = (shrinkOffset == minExtent
            ? 0.0
            : 1.0 -
                (shrinkOffset.clamp(minExtent, minExtent + 30.h) - minExtent) /
                    30.h)
        .clamp(0.0, 1.0);

    return GetX<RestaurantScreenController>(
      init: RestaurantScreenController(),
      builder: (controller) {
        final double logoOpacity = (1.0 - clowsingRate * 1.2).clamp(0.0, 1.0);
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: imageTop,
              left: 0,
              right: 0,
              child: SizedBox(
                height: maxExtent - bottomHeight,
                child: ColoredBox(
                  color: themeChange.isDarkTheme()
                      ? AppThemeData.grey1000
                      : AppThemeData.grey50,
                  child: Opacity(
                    opacity: opacity,
                    child: NetworkImageWidget(
                      imageUrl: controller.restaurantModel.value.coverImage
                          .toString(),
                      height: 255.h,
                      width: ScreenSize.width(100, context),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 255.h - (120.h / 2),
              left: 16.w,
              child: AnimatedOpacity(
                opacity: logoOpacity,
                duration: Duration(milliseconds: 150),
                child: Transform.scale(
                  scale: 1.0 - (clowsingRate * 0.3),
                  alignment: Alignment.center,
                  child: ClipOval(
                    child: Container(
                      width: 122.w,
                      height: 122.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        controller.restaurantModel.value.logoImage.toString(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                surfaceTintColor: themeChange.isDarkTheme()
                    ? AppThemeData.grey1000
                    : AppThemeData.grey50,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => AddRestaurantScreenView(), arguments: {
                          "restaurantModel": controller.restaurantModel.value,
                          "editPage": "Upload Restaurant Cover and Logo"
                        });
                      },
                      child: Container(
                        height: 36.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey900
                              : AppThemeData.grey100,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icons/ic_edit.svg",
                            height: 20.h,
                            width: 20.w,
                            color: themeChange.isDarkTheme()
                                ? AppThemeData.grey200
                                : AppThemeData.grey800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  double get maxExtent => 315.h;

  @override
  double get minExtent => Get.statusBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class InvertedCircleClipper extends CustomClipper<Path> {
  const InvertedCircleClipper({
    required this.offset,
    required this.radius,
  });

  final Offset offset;
  final double radius;

  @override
  Path getClip(size) {
    return Path()
      ..addOval(Rect.fromCircle(
        center: offset,
        radius: radius,
      ))
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

Padding rowTextWidget({required String name, required String value}) {
  final themeChange = Provider.of<DarkThemeProvider>(Get.context!);
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      children: [
        TextCustom(
          title: name.tr,
          fontSize: 16,
          fontFamily: FontFamily.medium,
          color: themeChange.isDarkTheme()
              ? AppThemeData.grey50
              : AppThemeData.grey1000,
        ),
        const Spacer(),
        TextCustom(
          title: value.tr,
          fontSize: 16,
          fontFamily: FontFamily.medium,
          color: themeChange.isDarkTheme()
              ? AppThemeData.grey50
              : AppThemeData.grey1000,
        ),
      ],
    ),
  );
}
