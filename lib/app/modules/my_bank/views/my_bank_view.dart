// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/models/bank_detail_model.dart';
import 'package:restaurant/app/modules/add_bank/views/add_bank_view.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant_widgets/container_custom.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/common_ui.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';
import '../controllers/my_bank_controller.dart';

class MyBankView extends GetView<MyBankController> {
  const MyBankView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder<MyBankController>(
      init: MyBankController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: themeChange.isDarkTheme()
                ? AppThemeData.darkBackground
                : AppThemeData.grey50,
            body: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
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
                                        child: Icon(
                                          Icons.arrow_back_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  TextCustom(
                                    title: "My Bank".tr,
                                    fontSize: 20,
                                    maxLine: 2,
                                    color: AppThemeData.primaryWhite,
                                    fontFamily: FontFamily.medium,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => AddBankView());
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                // Body Section
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xffEFF6FF),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Color(0xffC6D2FF),
                                width: 1,
                              ),
                            ),
                            child: TextCustom(
                              title:
                                  "Link your bank accounts to receive payments and withdraw funds seamlessly."
                                      .tr,
                              fontSize: 14,
                              maxLine: 3,
                              color: themeChange.isDarkTheme()
                                  ? AppThemeData.grey100
                                  : AppThemeData.grey700,
                              fontFamily: FontFamily.regular,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(height: 24),
                          Obx(
                            () => controller.bankDetailsList.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 40),
                                      child: TextCustom(
                                        title: "No banks added yet".tr,
                                        fontSize: 16,
                                        color: themeChange.isDarkTheme()
                                            ? AppThemeData.grey400
                                            : AppThemeData.grey600,
                                        fontFamily: FontFamily.regular,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        controller.bankDetailsList.length,
                                    itemBuilder: (context, index) {
                                      BankDetailsModel bankDetailsModel =
                                          controller.bankDetailsList[index];
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 16),
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: AppThemeData.primaryWhite,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Color(0xffE2E8F0),
                                              width: 1,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0xffE0E7FF),
                                                    ),
                                                    height: 48,
                                                    width: 48,
                                                    child: Center(
                                                      child: SizedBox(
                                                        height: 24,
                                                        width: 24,
                                                        child: SvgPicture.asset(
                                                          "assets/icons/ic-bank.svg",
                                                          color: AppThemeData
                                                              .primary300,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            TextCustom(
                                                              title:
                                                                  bankDetailsModel
                                                                      .bankName
                                                                      .toString(),
                                                              color: Color(
                                                                  0xff1D293D),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .medium,
                                                            ),
                                                            if (index == 0)
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 8,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical: 4,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppThemeData
                                                                        .primary300,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      6,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      TextCustom(
                                                                    title:
                                                                        "Primary"
                                                                            .tr,
                                                                    fontSize:
                                                                        10,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .medium,
                                                                    color: AppThemeData
                                                                        .primaryWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 4),
                                                        TextCustom(
                                                          title:
                                                              bankDetailsModel
                                                                  .holderName
                                                                  .toString(),
                                                          color:
                                                              Color(0xff62748E),
                                                          fontSize: 12,
                                                          fontFamily: FontFamily
                                                              .regular,
                                                        ),
                                                        SizedBox(height: 2),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/icons/ic-accountno.svg",
                                                              height: 12,
                                                              width: 12,
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            TextCustom(
                                                              title:
                                                                  "**** ${bankDetailsModel.accountNumber.toString().substring(max(0, bankDetailsModel.accountNumber.toString().length - 4))}",
                                                              color: themeChange
                                                                      .isDarkTheme()
                                                                  ? AppThemeData
                                                                      .grey500
                                                                  : AppThemeData
                                                                      .grey600,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .regular,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: PopupMenuButton(
                                                      itemBuilder:
                                                          (BuildContext bc) {
                                                        return [
                                                          PopupMenuItem<String>(
                                                            height: 30,
                                                            value: "Edit".tr,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Edit".tr,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .regular,
                                                                    color: themeChange.isDarkTheme()
                                                                        ? AppThemeData
                                                                            .primaryWhite
                                                                        : AppThemeData
                                                                            .primaryBlack,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          PopupMenuItem<String>(
                                                            height: 30,
                                                            value: "Delete".tr,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Delete".tr,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .regular,
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ];
                                                      },
                                                      onSelected: (value) {
                                                        if (value == "Edit") {
                                                          controller.editingId
                                                                  .value =
                                                              bankDetailsModel
                                                                  .id
                                                                  .toString();
                                                          controller
                                                                  .bankHolderNameController
                                                                  .text =
                                                              bankDetailsModel
                                                                  .holderName
                                                                  .toString();
                                                          controller
                                                                  .bankAccountNumberController
                                                                  .text =
                                                              bankDetailsModel
                                                                  .accountNumber
                                                                  .toString();
                                                          controller
                                                                  .swiftCodeController
                                                                  .text =
                                                              bankDetailsModel
                                                                  .swiftCode
                                                                  .toString();
                                                          controller
                                                                  .ifscCodeController
                                                                  .text =
                                                              bankDetailsModel
                                                                  .ifscCode
                                                                  .toString();
                                                          controller
                                                                  .bankNameController
                                                                  .text =
                                                              bankDetailsModel
                                                                  .bankName
                                                                  .toString();
                                                          controller
                                                                  .bankBranchCityController
                                                                  .text =
                                                              bankDetailsModel
                                                                  .branchCity
                                                                  .toString();
                                                          controller
                                                                  .bankBranchCountryController
                                                                  .text =
                                                              bankDetailsModel
                                                                  .branchCountry
                                                                  .toString();
                                                          Get.to(() =>
                                                              AddBankView());
                                                        } else {
                                                          controller
                                                              .deleteBankDetails(
                                                                  controller
                                                                          .bankDetailsList[
                                                                      index]);
                                                        }
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 4,
                                                          vertical: 4,
                                                        ),
                                                        child: Icon(
                                                          Icons.more_vert,
                                                          color: themeChange
                                                                  .isDarkTheme()
                                                              ? AppThemeData
                                                                  .grey400
                                                              : AppThemeData
                                                                  .grey600,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
