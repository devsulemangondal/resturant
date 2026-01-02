// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/models/wallet_transaction_model.dart';
import 'package:restaurant/app/models/withdraw_model.dart';
import 'package:restaurant/app/modules/add_bank/views/add_bank_view.dart';
import 'package:restaurant/app/modules/my_wallet/views/widgets/withdrawal_view.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/extension/date_time_extension.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/common_ui.dart';
import 'package:restaurant/themes/responsive.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';
import 'package:restaurant/utils/fire_store_utils.dart';

import '../controllers/my_wallet_controller.dart';
import 'widgets/add_money_view.dart';

class MyWalletView extends StatelessWidget {
  const MyWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
        init: MyWalletController(),
        builder: (controller) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: Responsive.width(100, context),
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
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                      child: Icon(Icons.arrow_back_rounded,
                                          color: Colors.white, size: 20)),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              TextCustom(
                                title: "My Wallet".tr,
                                fontSize: 20,
                                fontFamily: FontFamily.regular,
                                color: AppThemeData.primaryWhite,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.white.withOpacity(.2)),
                              color: Colors.white.withOpacity(.1),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppThemeData.accent300,
                                  AppThemeData.primary300,
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: paddingEdgeInsets(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  spaceH(height: 8),
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
                                            color: Colors.white.withOpacity(.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                              child: SvgPicture.asset(
                                            "assets/icons/ic_wallet.svg",
                                            color: Colors.white,
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      TextCustom(
                                        title: "Total Balance".tr,
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: FontFamily.medium,
                                      ),
                                    ],
                                  ),
                                  TextCustom(
                                    title: Constant.amountShow(
                                        amount: controller.ownerModel.value
                                                .walletAmount ??
                                            '0.0'),
                                    color: themeChange.isDarkTheme()
                                        ? AppThemeData.primaryBlack
                                        : AppThemeData.primaryWhite,
                                    fontSize: 30,
                                    fontFamily: FontFamily.medium,
                                  ),
                                  spaceH(height: 16),
                                  AddMoneyButton(
                                    onTap: () {
                                      Get.to(() => AddMoneyView());
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))),
                spaceH(height: 32),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Recent Transactions",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 24),
                          Obx(
                            () => controller.walletTransactionList.isEmpty
                                ? Container(
                                    height: 150,
                                    child: Center(
                                      child: Text(
                                          "No Recent Transactions Found".tr),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        controller.walletTransactionList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      WalletTransactionModel
                                          walletTransactionModel = controller
                                              .walletTransactionList[index];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                              color: Color(0xffE2E8F0)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 44.w,
                                              height: 44.h,
                                              margin: const EdgeInsets.only(
                                                  right: 16),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: (walletTransactionModel
                                                              .isCredit ??
                                                          false)
                                                      ? themeChange
                                                              .isDarkTheme()
                                                          ? AppThemeData
                                                              .success600
                                                          : AppThemeData
                                                              .success50
                                                      : themeChange
                                                              .isDarkTheme()
                                                          ? AppThemeData
                                                              .danger600
                                                          : AppThemeData
                                                              .danger50),
                                              child: Center(
                                                child: Transform.rotate(
                                                  angle: 45 *
                                                      3.141592653589793 /
                                                      180, // 45 degrees
                                                  child: (walletTransactionModel
                                                              .isCredit ??
                                                          false)
                                                      ? SvgPicture.asset(
                                                          "assets/icons/ic_arrow_down_line.svg",
                                                          color: AppThemeData
                                                              .success300,
                                                        )
                                                      : SvgPicture.asset(
                                                          "assets/icons/ic_arrow_up_line.svg",
                                                          color: AppThemeData
                                                              .danger300,
                                                        ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      width: 1,
                                                      color: themeChange
                                                              .isDarkTheme()
                                                          ? AppThemeData.grey800
                                                          : AppThemeData
                                                              .grey100,
                                                    ),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            walletTransactionModel
                                                                    .note ??
                                                                '',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  FontFamily
                                                                      .regular,
                                                              color: themeChange
                                                                      .isDarkTheme()
                                                                  ? AppThemeData
                                                                      .grey50
                                                                  : AppThemeData
                                                                      .grey900,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 12),
                                                        Text(
                                                          Constant.amountShow(
                                                              amount: walletTransactionModel
                                                                      .amount ??
                                                                  ''),
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FontFamily
                                                                    .regular,
                                                            color: (walletTransactionModel
                                                                        .isCredit ??
                                                                    false)
                                                                ? AppThemeData
                                                                    .success300
                                                                : AppThemeData
                                                                    .danger300,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                (walletTransactionModel
                                                                            .createdDate ??
                                                                        Timestamp
                                                                            .now())
                                                                    .toDate()
                                                                    .dateMonthYear(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .regular,
                                                                  color: Color(
                                                                      0xff62748E),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              Container(
                                                                height: 16,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side:
                                                                        BorderSide(
                                                                      width: 1,
                                                                      strokeAlign:
                                                                          BorderSide
                                                                              .strokeAlignCenter,
                                                                      color: themeChange.isDarkTheme()
                                                                          ? AppThemeData
                                                                              .grey800
                                                                          : AppThemeData
                                                                              .grey100,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              Text(
                                                                (walletTransactionModel
                                                                            .createdDate ??
                                                                        Timestamp
                                                                            .now())
                                                                    .toDate()
                                                                    .time(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .regular,
                                                                  color: Color(
                                                                      0xff62748E),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ]),
                  ),
                ),
                // Expanded(
                //   child: DefaultTabController(
                //     length: 2,
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           padding: const EdgeInsets.all(8),
                //           decoration: BoxDecoration(
                //               color: themeChange.isDarkTheme()
                //                   ? AppThemeData.grey900
                //                   : AppThemeData.grey50,
                //               borderRadius: BorderRadius.circular(60)),
                //           child: TabBar(
                //             dividerColor: Colors.transparent,
                //             onTap: (value) {
                //               controller.selectedTabIndex.value = value;
                //             },
                //             labelStyle: TextStyle(
                //               fontFamily: FontFamily.regular,
                //               fontSize: 14,
                //               fontWeight: FontWeight.w500,
                //             ),
                //             unselectedLabelStyle: TextStyle(
                //               fontFamily: FontFamily.regular,
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //             ),
                //             labelColor: AppThemeData.primaryWhite,
                //             unselectedLabelColor: themeChange.isDarkTheme()
                //                 ? AppThemeData.grey400
                //                 : AppThemeData.grey600,
                //             indicator: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(60),
                //                 color: AppThemeData.secondary300),
                //             indicatorSize: TabBarIndicatorSize.tab,
                //             tabs: [
                //               Tab(
                //                 text: "Transaction History".tr,
                //               ),
                //               Tab(
                //                 text: "Withdrawal History".tr,
                //               ),
                //             ],
                //           ),
                //         ),
                //         Expanded(
                //           child: TabBarView(children: [
                //              // FutureBuilder<List<WithdrawModel>?>(
                //             //     future: FireStoreUtils.getWithDrawRequest(),
                //             //     builder: (context, snapshot) {
                //             //       switch (snapshot.connectionState) {
                //             //         case ConnectionState.waiting:
                //             //           return Constant.loader();
                //             //         case ConnectionState.done:
                //             //           if (snapshot.hasError) {
                //             //             return Text(snapshot.error.toString());
                //             //           } else {
                //             //             return snapshot.data!.isEmpty
                //             //                 ? Center(
                //             //                     child: TextCustom(
                //             //                         title: "No Data View".tr),
                //             //                   )
                //             //                 : ListView.builder(
                //             //                     itemCount:
                //             //                         snapshot.data!.length,
                //             //                     shrinkWrap: true,
                //             //                     itemBuilder: (context, index) {
                //             //                       WithdrawModel
                //             //                           walletTransactionModel =
                //             //                           snapshot.data![index];
                //             //                       return Container(
                //             //                         width: 358,
                //             //                         height: 80,
                //             //                         clipBehavior:
                //             //                             Clip.antiAlias,
                //             //                         decoration:
                //             //                             const BoxDecoration(),
                //             //                         child: Row(
                //             //                           mainAxisSize:
                //             //                               MainAxisSize.min,
                //             //                           mainAxisAlignment:
                //             //                               MainAxisAlignment
                //             //                                   .start,
                //             //                           crossAxisAlignment:
                //             //                               CrossAxisAlignment
                //             //                                   .center,
                //             //                           children: [
                //             //                             Container(
                //             //                               width: 44,
                //             //                               height: 44,
                //             //                               margin:
                //             //                                   const EdgeInsets
                //             //                                       .only(
                //             //                                       right: 16),
                //             //                               decoration:
                //             //                                   ShapeDecoration(
                //             //                                 color: (walletTransactionModel
                //             //                                             .paymentStatus ==
                //             //                                         "Complete")
                //             //                                     ? themeChange
                //             //                                             .isDarkTheme()
                //             //                                         ? AppThemeData
                //             //                                             .success600
                //             //                                         : AppThemeData
                //             //                                             .success50
                //             //                                     : themeChange
                //             //                                             .isDarkTheme()
                //             //                                         ? AppThemeData
                //             //                                             .accent500
                //             //                                         : AppThemeData
                //             //                                             .accent50,
                //             //                                 shape:
                //             //                                     RoundedRectangleBorder(
                //             //                                   borderRadius:
                //             //                                       BorderRadius
                //             //                                           .circular(
                //             //                                               100),
                //             //                                 ),
                //             //                               ),
                //             //                               child: Center(
                //             //                                 child: SvgPicture
                //             //                                     .asset(
                //             //                                   "assets/icons/ic_my_wallet.svg",
                //             //                                   colorFilter: ColorFilter.mode(
                //             //                                       (walletTransactionModel
                //             //                                                   .paymentStatus ==
                //             //                                               "Complete")
                //             //                                           ? AppThemeData
                //             //                                               .success300
                //             //                                           : AppThemeData
                //             //                                               .danger300,
                //             //                                       BlendMode
                //             //                                           .srcIn),
                //             //                                 ),
                //             //                               ),
                //             //                             ),
                //             //                             Expanded(
                //             //                               child: Container(
                //             //                                 padding:
                //             //                                     const EdgeInsets
                //             //                                         .symmetric(
                //             //                                         vertical:
                //             //                                             16),
                //             //                                 decoration:
                //             //                                     BoxDecoration(
                //             //                                   border: Border(
                //             //                                     bottom:
                //             //                                         BorderSide(
                //             //                                       width: 1,
                //             //                                       color: themeChange.isDarkTheme()
                //             //                                           ? AppThemeData
                //             //                                               .grey800
                //             //                                           : AppThemeData
                //             //                                               .grey100,
                //             //                                     ),
                //             //                                   ),
                //             //                                 ),
                //             //                                 child: Column(
                //             //                                   mainAxisSize:
                //             //                                       MainAxisSize
                //             //                                           .min,
                //             //                                   mainAxisAlignment:
                //             //                                       MainAxisAlignment
                //             //                                           .center,
                //             //                                   crossAxisAlignment:
                //             //                                       CrossAxisAlignment
                //             //                                           .start,
                //             //                                   children: [
                //             //                                     Row(
                //             //                                       mainAxisSize:
                //             //                                           MainAxisSize
                //             //                                               .min,
                //             //                                       mainAxisAlignment:
                //             //                                           MainAxisAlignment
                //             //                                               .start,
                //             //                                       crossAxisAlignment:
                //             //                                           CrossAxisAlignment
                //             //                                               .center,
                //             //                                       children: [
                //             //                                         Expanded(
                //             //                                           child:
                //             //                                               Text(
                //             //                                             maxLines:
                //             //                                                 1,
                //             //                                             overflow:
                //             //                                                 TextOverflow.ellipsis,
                //             //                                             walletTransactionModel.note ??
                //             //                                                 '',
                //             //                                             style:
                //             //                                                 TextStyle(
                //             //                                               fontFamily:
                //             //                                                   FontFamily.regular,
                //             //                                               color: themeChange.isDarkTheme()
                //             //                                                   ? AppThemeData.grey50
                //             //                                                   : AppThemeData.grey900,
                //             //                                               fontSize:
                //             //                                                   16,
                //             //                                               fontWeight:
                //             //                                                   FontWeight.w400,
                //             //                                             ),
                //             //                                           ),
                //             //                                         ),
                //             //                                         const SizedBox(
                //             //                                             width:
                //             //                                                 12),
                //             //                                         Text(
                //             //                                           Constant.amountShow(
                //             //                                               amount:
                //             //                                                   walletTransactionModel.amount ?? ''),
                //             //                                           textAlign:
                //             //                                               TextAlign
                //             //                                                   .right,
                //             //                                           style:
                //             //                                               TextStyle(
                //             //                                             fontFamily:
                //             //                                                 FontFamily.regular,
                //             //                                             color: (walletTransactionModel.paymentStatus ==
                //             //                                                     "Complete")
                //             //                                                 ? AppThemeData.success300
                //             //                                                 : AppThemeData.danger300,
                //             //                                             fontSize:
                //             //                                                 16,
                //             //                                             fontWeight:
                //             //                                                 FontWeight.w600,
                //             //                                           ),
                //             //                                         ),
                //             //                                       ],
                //             //                                     ),
                //             //                                     const SizedBox(
                //             //                                         height: 2),
                //             //                                     Row(
                //             //                                       mainAxisSize:
                //             //                                           MainAxisSize
                //             //                                               .min,
                //             //                                       mainAxisAlignment:
                //             //                                           MainAxisAlignment
                //             //                                               .start,
                //             //                                       crossAxisAlignment:
                //             //                                           CrossAxisAlignment
                //             //                                               .center,
                //             //                                       children: [
                //             //                                         Expanded(
                //             //                                           child:
                //             //                                               Row(
                //             //                                             mainAxisSize:
                //             //                                                 MainAxisSize.min,
                //             //                                             mainAxisAlignment:
                //             //                                                 MainAxisAlignment.start,
                //             //                                             crossAxisAlignment:
                //             //                                                 CrossAxisAlignment.center,
                //             //                                             children: [
                //             //                                               Text(
                //             //                                                 (walletTransactionModel.createdDate ?? Timestamp.now()).toDate().dateMonthYear(),
                //             //                                                 style:
                //             //                                                     TextStyle(
                //             //                                                   fontFamily: FontFamily.regular,
                //             //                                                   color: themeChange.isDarkTheme() ? AppThemeData.grey400 : AppThemeData.grey500,
                //             //                                                   fontSize: 14,
                //             //                                                   fontWeight: FontWeight.w400,
                //             //                                                 ),
                //             //                                               ),
                //             //                                               const SizedBox(
                //             //                                                   width: 8),
                //             //                                               Container(
                //             //                                                 height:
                //             //                                                     16,
                //             //                                                 decoration:
                //             //                                                     ShapeDecoration(
                //             //                                                   shape: RoundedRectangleBorder(
                //             //                                                     side: BorderSide(
                //             //                                                       width: 1,
                //             //                                                       strokeAlign: BorderSide.strokeAlignCenter,
                //             //                                                       color: themeChange.isDarkTheme() ? AppThemeData.grey800 : AppThemeData.grey100,
                //             //                                                     ),
                //             //                                                   ),
                //             //                                                 ),
                //             //                                               ),
                //             //                                               const SizedBox(
                //             //                                                   width: 8),
                //             //                                               Text(
                //             //                                                 (walletTransactionModel.createdDate ?? Timestamp.now()).toDate().time(),
                //             //                                                 style:
                //             //                                                     TextStyle(
                //             //                                                   fontFamily: FontFamily.regular,
                //             //                                                   color: themeChange.isDarkTheme() ? AppThemeData.grey400 : AppThemeData.grey500,
                //             //                                                   fontSize: 14,
                //             //                                                   fontWeight: FontWeight.w400,
                //             //                                                 ),
                //             //                                               ),
                //             //                                             ],
                //             //                                           ),
                //             //                                         ),
                //             //                                       ],
                //             //                                     ),
                //             //                                   ],
                //             //                                 ),
                //             //                               ),
                //             //                             ),
                //             //                           ],
                //             //                         ),
                //             //                       );
                //             //                     },
                //             //                   );
                //             //           }
                //             //         default:
                //             //           return Text('Error'.tr);
                //             //       }
                //             //     })

                //           ]),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        });
  }
}

class AddMoneyButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddMoneyButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.add,
              color: Color(0xFF4F39F6),
              size: 22,
            ),
            SizedBox(width: 8),
            Text(
              "Add Money",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4F39F6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
