// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, use_super_parameters

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/add_restaurant_screen/controllers/add_restaurant_screen_controller.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

import '../../../../../themes/screen_size.dart';

class UploadRestaurantImage extends GetView<AddRestaurantScreenController> {
  const UploadRestaurantImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return GetX(
      init: AddRestaurantScreenController(),
      builder: (controller) {
        bool areImagesUploaded = controller.coverImage.value.isNotEmpty &&
            controller.logoImage.value.isNotEmpty;
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SizedBox(
              width: Get.width,
              child: Padding(
                padding: paddingEdgeInsets(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                              title: "Cover Image".tr,
                              color: Color(0xff1D293D),
                              fontSize: 16,
                              fontFamily: FontFamily.medium,
                            ),
                            spaceH(height: 2),
                            Text(
                              "Recommended size: 1200 x 400 px",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff62748E)),
                            ),
                          ],
                        ),
                        Obx(() {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                                color: Color(0xffF0FDF4),
                                borderRadius: BorderRadius.circular(12)),
                            child: controller.coverImage.isNotEmpty
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.done_rounded,
                                        color: Color(0xff00A63E),
                                      ),
                                      Text(
                                        "Uploaded",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff00A63E),
                                        ),
                                      )
                                    ],
                                  )
                                : SizedBox(),
                          );
                        }),
                      ],
                    ),
                    spaceH(height: 10),
                    InkWell(
                      onTap: () {
                        controller.pickFile().then(
                            (value) => controller.coverImage.value = value!);
                      },
                      child: controller.coverImage.value.isEmpty
                          ? Container(
                              height: 174,
                              width: 358.w,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffA3B3FF)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                color: Color(0xffEEF2FF),
                              ),
                              child: Padding(
                                padding: paddingEdgeInsets(),
                                child: Center(
                                  child: SingleChildScrollView(
                                    physics: NeverScrollableScrollPhysics(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 64,
                                          width: 64,
                                          decoration: BoxDecoration(
                                              color: Color(0xffE0E7FF),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: SvgPicture.asset(
                                              "assets/icons/ic_upload.svg",
                                              color: AppThemeData.primary300,
                                              height: 32,
                                              width: 32,
                                            ),
                                          ),
                                        ),
                                        spaceH(height: 12),
                                        TextCustom(
                                          title: "Upload Cover Image".tr,
                                          maxLine: 1,
                                          color: Color(0xff314158),
                                          fontFamily: FontFamily.regular,
                                        ),
                                        TextCustom(
                                          title: "Tap to browse files".tr,
                                          maxLine: 1,
                                          fontSize: 12,
                                          fontFamily: FontFamily.regular,
                                          color: Color(0xff62748E),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Constant.hasValidUrl(
                                      controller.coverImage.value.toString())
                                  ? Image.network(
                                      controller.coverImage.value.toString(),
                                      height: 174.h,
                                      width: 358.w,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(controller.coverImage.value
                                          .toString()),
                                      height: 174.h,
                                      width: 358.w,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                    ),
                    spaceH(height: 10),
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: Color(0xffF1F5F9),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "• .jpg",
                            style: TextStyle(
                                color: Color(0xff45556C), fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: Color(0xffF1F5F9),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "• .jpeg",
                            style: TextStyle(
                                color: Color(0xff45556C), fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    spaceH(height: 20),
                    CenterTitleDivider(
                      title: "Restaurant Logo",
                    ),
                    spaceH(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                              title: "Restaurant Logo".tr,
                              color: Color(0xff1D293D),
                              fontSize: 16,
                              fontFamily: FontFamily.medium,
                            ),
                            spaceH(height: 2),
                            Text(
                              "Recommended size: 500 x 500 px",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff62748E)),
                            ),
                          ],
                        ),
                        Obx(() {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                                color: Color(0xffF0FDF4),
                                borderRadius: BorderRadius.circular(12)),
                            child: controller.logoImage.isNotEmpty
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.done_rounded,
                                        color: Color(0xff00A63E),
                                      ),
                                      Text(
                                        "Uploaded",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff00A63E),
                                        ),
                                      )
                                    ],
                                  )
                                : SizedBox(),
                          );
                        }),
                      ],
                    ),
                    spaceH(height: 8),
                    Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * .2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.pickFile().then((value) =>
                                    controller.logoImage.value = value!);
                              },
                              child: controller.logoImage.value.isEmpty
                                  ? Container(
                                      height: 174,
                                      width: 358.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffA3B3FF)),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        color: Color(0xffEEF2FF),
                                      ),
                                      child: Padding(
                                        padding: paddingEdgeInsets(),
                                        child: Center(
                                          child: SingleChildScrollView(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 64,
                                                  width: 64,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffE0E7FF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: SvgPicture.asset(
                                                      "assets/icons/ic_upload.svg",
                                                      color: AppThemeData
                                                          .primary300,
                                                      height: 32,
                                                      width: 32,
                                                    ),
                                                  ),
                                                ),
                                                spaceH(height: 12),
                                                TextCustom(
                                                  title:
                                                      "Upload Cover Image".tr,
                                                  maxLine: 1,
                                                  color: Color(0xff314158),
                                                  fontFamily:
                                                      FontFamily.regular,
                                                ),
                                                TextCustom(
                                                  title:
                                                      "Tap to browse files".tr,
                                                  maxLine: 1,
                                                  fontSize: 12,
                                                  fontFamily:
                                                      FontFamily.regular,
                                                  color: Color(0xff62748E),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Constant.hasValidUrl(controller
                                              .logoImage.value
                                              .toString())
                                          ? Image.network(
                                              controller.logoImage.value
                                                  .toString(),
                                              height: 174.h,
                                              width: 358.w,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              File(controller.logoImage.value
                                                  .toString()),
                                              height: 174.h,
                                              width: 358.w,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                            ),
                            spaceH(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: Color(0xffF1F5F9),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "• .jpg",
                                    style: TextStyle(
                                        color: Color(0xff45556C), fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: Color(0xffF1F5F9),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "• .jpeg",
                                    style: TextStyle(
                                        color: Color(0xff45556C), fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 110,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xffE2E8F0)))),
            padding: paddingEdgeInsets(vertical: 8),
            child: Column(
              children: [
                Spacer(),
                GradientRoundShapeButton(
                  buttonTextColor: areImagesUploaded
                      ? AppThemeData.grey50
                      : AppThemeData.grey500,
                  title: "Next".tr,
                  buttonColor: areImagesUploaded
                      ? AppThemeData.primary300
                      : AppThemeData.grey200,
                  size: Size(Get.width, 52),
                  gradientColors: !areImagesUploaded
                      ? []
                      : const [
                          Color(0xff4F39F6),
                          Color(0xff155DFC),
                          Color(0xff155DFC),
                        ],
                  onTap: () {
                    areImagesUploaded
                        ? controller.nextStep()
                        : ShowToastDialog.toast(
                            "Please upload restaurant images.".tr);
                  },
                ),
                Spacer(),
                Text(
                  "Please upload both images to continue",
                  style: TextStyle(fontSize: 12, color: Color(0xff62748E)),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CenterTitleDivider extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color dividerColor;

  const CenterTitleDivider({
    super.key,
    required this.title,
    this.textColor = const Color(0xFF667085),
    this.dividerColor = const Color(0xFFE5E7EB),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// LEFT LINE
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: 1,
          ),
        ),

        const SizedBox(width: 12),

        /// CENTER TEXT
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: textColor,
          ),
        ),

        const SizedBox(width: 12),

        /// RIGHT LINE
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
