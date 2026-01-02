// // ignore_for_file: deprecated_member_use, depend_on_referenced_packages

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:restaurant/app/models/category_model.dart';
// import 'package:restaurant/app/models/product_model.dart';
// import 'package:restaurant/app/modules/add_menu_item_screen/views/add_menu_item_screen_view.dart';
// import 'package:restaurant/app/modules/menu_screen/controllers/menu_screen_controller.dart';
// import 'package:restaurant/app/modules/menu_screen/views/search_menu_items.dart';
// import 'package:restaurant/app/modules/my_wallet/views/my_wallet_view.dart';
// import 'package:restaurant/app/modules/notification_screen/views/notification_screen_view.dart';
// import 'package:restaurant/app/widget/global_widgets.dart';
// import 'package:restaurant/app/widget/network_image_widget.dart';
// import 'package:restaurant/app/widget/search_field.dart';
// import 'package:restaurant/app/widget/text_widget.dart';
// import 'package:restaurant/constant/constant.dart';
// import 'package:restaurant/constant/show_toast_dialogue.dart';
// import 'package:restaurant/constant_widgets/custom_dialog_box.dart';
// import 'package:restaurant/constant_widgets/no_menu_items_view.dart';
// import 'package:restaurant/themes/app_fonts.dart';
// import 'package:restaurant/themes/app_theme_data.dart';
// import 'package:restaurant/themes/responsive.dart';
// import 'package:restaurant/utils/dark_theme_provider.dart';

// class CategoryDetailView extends StatelessWidget {
//   const CategoryDetailView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeChange = Provider.of<DarkThemeProvider>(context);
//     return GetBuilder<MenuScreenController>(
//         init: MenuScreenController(),
//         builder: (controller) {
//           return Obx(
//             () => Container(
//               width: Responsive.width(100, context),
//               height: Responsive.height(100, context),
//               child: Scaffold(
//                 backgroundColor: Colors.transparent,
//                 body: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             AppThemeData.accent300,
//                             AppThemeData.primary300,
//                           ],
//                         ),
//                       ),
//                       child: SafeArea(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 24, vertical: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       TextCustom(
//                                         title: "Menu Management",
//                                         fontSize: 20,
//                                         color: AppThemeData.primaryWhite,
//                                         fontFamily: FontFamily.medium,
//                                         textAlign: TextAlign.start,
//                                       ),
//                                       TextCustom(
//                                         title: "Manage your restaurant menu".tr,
//                                         fontSize: 14,
//                                         color: AppThemeData.primaryWhite,
//                                         fontFamily: FontFamily.regular,
//                                         textAlign: TextAlign.start,
//                                       ),
//                                     ],
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       if (Constant.ownerModel!.vendorId !=
//                                               null &&
//                                           Constant.ownerModel!.vendorId!
//                                               .isNotEmpty) {
//                                         Get.to(() => AddMenuItemsScreenView());
//                                       } else {
//                                         ShowToastDialog.toast(
//                                             "First Add your restaurant to change Option."
//                                                 .tr);
//                                       }
//                                     },
//                                     child: Container(
//                                       width: 40,
//                                       height: 40,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(.1),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: Center(
//                                         child: Icon(
//                                           Icons.add,
//                                           color: Colors.white,
//                                           size: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 16),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     controller.isLoading.value
//                         ? Constant.loader()
//                         : controller.productList.isEmpty
//                             ? NoMenuItemsView(
//                                 themeChange: themeChange,
//                               )
//                             : Obx(
//                                 () => SingleChildScrollView(
//                                   child: Padding(
//                                     padding: paddingEdgeInsets(),
//                                     child: Column(
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.all(16),
//                                           decoration: BoxDecoration(
//                                             color: Color(0xffEFF6FF),
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             border: Border.all(
//                                               color: Color(0xffC6D2FF),
//                                               width: 1,
//                                             ),
//                                           ),
//                                           child: TextCustom(
//                                             title:
//                                                 "Organize your menu into categories and add items with pricing, variants, and add-ons."
//                                                     .tr,
//                                             fontSize: 14,
//                                             maxLine: 3,
//                                             color: themeChange.isDarkTheme()
//                                                 ? AppThemeData.grey100
//                                                 : AppThemeData.grey700,
//                                             fontFamily: FontFamily.regular,
//                                             textAlign: TextAlign.start,
//                                           ),
//                                         ),
//                                         spaceH(height: 16),
//                                         SizedBox(
//                                           height: 38.h,
//                                           child: ListView.builder(
//                                             scrollDirection: Axis.horizontal,
//                                             physics:
//                                                 AlwaysScrollableScrollPhysics(),
//                                             itemCount:
//                                                 controller.categoryList.length,
//                                             itemBuilder: (context, index) {
//                                               CategoryModel categoryModel =
//                                                   controller
//                                                       .categoryList[index];

//                                               int productCount = categoryModel.id ==
//                                                       'all'
//                                                   ? controller
//                                                       .allProductList.length
//                                                   : controller.categoryProductCount[
//                                                           categoryModel.id] ??
//                                                       0;
//                                               return GestureDetector(
//                                                 onTap: () {
//                                                   controller.selectedCategory
//                                                       .value = categoryModel;
//                                                   controller
//                                                       .isSubCategoryLoading
//                                                       .value = true;

//                                                   if (categoryModel.id ==
//                                                       'all') {
//                                                     controller
//                                                             .productList.value =
//                                                         controller
//                                                             .allProductList;
//                                                     controller
//                                                         .isSubCategoryLoading
//                                                         .value = false;
//                                                   } else {
//                                                     controller.getSubCategory(
//                                                         categoryModel.id
//                                                             .toString());
//                                                   }
//                                                 },
//                                                 child: Obx(
//                                                   () => Container(
//                                                     margin: EdgeInsets.only(
//                                                         right: 8),
//                                                     decoration: BoxDecoration(
//                                                         color: controller
//                                                                     .selectedCategory
//                                                                     .value ==
//                                                                 controller
//                                                                         .categoryList[
//                                                                     index]
//                                                             ? AppThemeData
//                                                                 .secondary300
//                                                             : themeChange
//                                                                     .isDarkTheme()
//                                                                 ? AppThemeData
//                                                                     .grey800
//                                                                 : AppThemeData
//                                                                     .grey200,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(30)),
//                                                     padding: paddingEdgeInsets(
//                                                         horizontal: 16,
//                                                         vertical: 8),
//                                                     child: Center(
//                                                       child: TextCustom(
//                                                         title:
//                                                             "${controller.categoryList[index].categoryName.toString()} ($productCount)",
//                                                         color: controller
//                                                                     .selectedCategory
//                                                                     .value ==
//                                                                 controller
//                                                                         .categoryList[
//                                                                     index]
//                                                             ? AppThemeData
//                                                                 .grey50
//                                                             : themeChange
//                                                                     .isDarkTheme()
//                                                                 ? AppThemeData
//                                                                     .grey400
//                                                                 : AppThemeData
//                                                                     .grey600,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                         spaceH(height: 16),
//                                         Obx(() {
//                                           if (controller
//                                                   .selectedCategory.value.id ==
//                                               'all') {
//                                             return controller
//                                                     .productList.isEmpty
//                                                 ? Center(
//                                                     child: TextCustom(
//                                                         title:
//                                                             "No Available Products"
//                                                                 .tr))
//                                                 : ListView.builder(
//                                                     shrinkWrap: true,
//                                                     itemCount: controller
//                                                         .productList.length,
//                                                     physics:
//                                                         NeverScrollableScrollPhysics(),
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       ProductModel product =
//                                                           controller
//                                                                   .productList[
//                                                               index];
//                                                       return Padding(
//                                                         padding:
//                                                             paddingEdgeInsets(
//                                                                 horizontal: 0,
//                                                                 vertical: 8),
//                                                         child: FittedBox(
//                                                           child: Row(
//                                                             children: [
//                                                               Stack(
//                                                                 children: [
//                                                                   NetworkImageWidget(
//                                                                     imageUrl: product
//                                                                         .productImage
//                                                                         .toString(),
//                                                                     width:
//                                                                         140.w,
//                                                                     height:
//                                                                         162.h,
//                                                                     borderRadius:
//                                                                         10,
//                                                                     fit: BoxFit
//                                                                         .cover,
//                                                                   ),
//                                                                   Container(
//                                                                     margin: paddingEdgeInsets(
//                                                                         horizontal:
//                                                                             8,
//                                                                         vertical:
//                                                                             8),
//                                                                     padding: paddingEdgeInsets(
//                                                                         horizontal:
//                                                                             8,
//                                                                         vertical:
//                                                                             4),
//                                                                     decoration: BoxDecoration(
//                                                                         color: themeChange.isDarkTheme()
//                                                                             ? AppThemeData.grey900.withOpacity(
//                                                                                 0.8)
//                                                                             : AppThemeData.grey100.withOpacity(
//                                                                                 0.8),
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(5)),
//                                                                     child:
//                                                                         TextCustom(
//                                                                       title: product
//                                                                           .itemTag
//                                                                           .toString(),
//                                                                       color: AppThemeData
//                                                                           .getRandomColor(),
//                                                                       fontSize:
//                                                                           12,
//                                                                       fontFamily:
//                                                                           FontFamily
//                                                                               .bold,
//                                                                     ),
//                                                                   )
//                                                                 ],
//                                                               ),
//                                                               spaceW(width: 12),
//                                                               Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   SizedBox(
//                                                                     width:
//                                                                         206.w,
//                                                                     child: Row(
//                                                                       children: [
//                                                                         Constant.showFoodType(
//                                                                             name:
//                                                                                 product.foodType.toString()),
//                                                                         Spacer(),
//                                                                         GestureDetector(
//                                                                           onTap:
//                                                                               () {
//                                                                             Get.to(() => AddMenuItemsScreenView(), arguments: {
//                                                                               'productModelId': product.id
//                                                                             });
//                                                                           },
//                                                                           child:
//                                                                               SvgPicture.asset(
//                                                                             "assets/icons/ic_edit_2.svg",
//                                                                             color:
//                                                                                 AppThemeData.secondary300,
//                                                                           ),
//                                                                         ),
//                                                                         spaceW(
//                                                                             width:
//                                                                                 12),
//                                                                         GestureDetector(
//                                                                           onTap:
//                                                                               () {
//                                                                             showDialog(
//                                                                                 context: context,
//                                                                                 builder: (BuildContext context) {
//                                                                                   return CustomDialogBox(
//                                                                                     img: Image.asset(
//                                                                                       "assets/animation/am_delete.gif",
//                                                                                       height: 64.h,
//                                                                                       width: 64.w,
//                                                                                     ),
//                                                                                     themeChange: themeChange,
//                                                                                     title: "Delete Item".tr,
//                                                                                     descriptions: "Are you sure you want to delete this item from the menu?".tr,
//                                                                                     positiveString: "Yes".tr,
//                                                                                     negativeString: "No".tr,
//                                                                                     positiveClick: () async {
//                                                                                       controller.removeItem(product.id.toString());
//                                                                                     },
//                                                                                     negativeClick: () {
//                                                                                       Navigator.pop(context);
//                                                                                     },
//                                                                                     positiveButtonColor: AppThemeData.danger300,
//                                                                                     negativeButtonColor: themeChange.isDarkTheme() ? AppThemeData.grey1000 : AppThemeData.grey50,
//                                                                                     positiveButtonTextColor: themeChange.isDarkTheme() ? AppThemeData.grey1000 : AppThemeData.grey50,
//                                                                                     negativeButtonTextColor: themeChange.isDarkTheme() ? AppThemeData.grey100 : AppThemeData.grey900,
//                                                                                     negativeButtonBorderColor: themeChange.isDarkTheme() ? AppThemeData.grey600 : AppThemeData.grey400,
//                                                                                   );
//                                                                                 });
//                                                                           },
//                                                                           child:
//                                                                               SvgPicture.asset(
//                                                                             "assets/icons/ic_delete.svg",
//                                                                             color:
//                                                                                 AppThemeData.danger300,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   TextCustom(
//                                                                     title: product
//                                                                         .productName
//                                                                         .toString(),
//                                                                     fontSize:
//                                                                         16,
//                                                                     fontFamily:
//                                                                         FontFamily
//                                                                             .medium,
//                                                                     color: themeChange.isDarkTheme()
//                                                                         ? AppThemeData
//                                                                             .grey50
//                                                                         : AppThemeData
//                                                                             .grey1000,
//                                                                   ),
//                                                                   TextCustom(
//                                                                     title: Constant.amountShow(
//                                                                         amount: product
//                                                                             .price
//                                                                             .toString()),
//                                                                     fontSize:
//                                                                         16,
//                                                                     fontFamily:
//                                                                         FontFamily
//                                                                             .bold,
//                                                                     color: themeChange.isDarkTheme()
//                                                                         ? AppThemeData
//                                                                             .grey50
//                                                                         : AppThemeData
//                                                                             .grey1000,
//                                                                   ),
//                                                                   SizedBox(
//                                                                     width:
//                                                                         206.w,
//                                                                     child:
//                                                                         TextCustom(
//                                                                       title: product
//                                                                           .description
//                                                                           .toString(),
//                                                                       maxLine:
//                                                                           1,
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .start,
//                                                                       textOverflow:
//                                                                           TextOverflow
//                                                                               .ellipsis,
//                                                                       color: themeChange.isDarkTheme()
//                                                                           ? AppThemeData
//                                                                               .grey400
//                                                                           : AppThemeData
//                                                                               .grey600,
//                                                                     ),
//                                                                   ),
//                                                                   spaceH(
//                                                                       height:
//                                                                           8),
//                                                                   SizedBox(
//                                                                     height:
//                                                                         24.h,
//                                                                     width:
//                                                                         150.w,
//                                                                     child: Row(
//                                                                       mainAxisSize:
//                                                                           MainAxisSize
//                                                                               .min,
//                                                                       children: [
//                                                                         Expanded(
//                                                                           child:
//                                                                               TextCustom(
//                                                                             title:
//                                                                                 "In Stock".tr,
//                                                                             fontSize:
//                                                                                 16,
//                                                                             color: themeChange.isDarkTheme()
//                                                                                 ? AppThemeData.grey300
//                                                                                 : AppThemeData.grey700,
//                                                                           ),
//                                                                         ),
//                                                                         spaceW(
//                                                                             width:
//                                                                                 8),
//                                                                         Expanded(
//                                                                           child:
//                                                                               SizedBox(
//                                                                             height:
//                                                                                 26.h,
//                                                                             child:
//                                                                                 FittedBox(
//                                                                               child: CupertinoSwitch(
//                                                                                 activeTrackColor: AppThemeData.primary300,
//                                                                                 value: product.inStock!,
//                                                                                 onChanged: (value) {
//                                                                                   product.inStock = value;
//                                                                                   controller.productList[index].inStock = value;
//                                                                                   controller.update();
//                                                                                   controller.updateProduct(product);
//                                                                                 },
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   )
//                                                                 ],
//                                                               )
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       );
//                                                     },
//                                                   );
//                                           } else {
//                                             return controller
//                                                     .isSubCategoryLoading.value
//                                                 ? Constant.loader()
//                                                 : controller
//                                                         .subCategoryList.isEmpty
//                                                     ? Center(
//                                                         child: Container(
//                                                             margin:
//                                                                 EdgeInsets.only(
//                                                                     top: 50),
//                                                             child: TextCustom(
//                                                                 title:
//                                                                     "No Available Menu Items"
//                                                                         .tr)))
//                                                     : ListView.builder(
//                                                         shrinkWrap: true,
//                                                         itemCount: controller
//                                                             .subCategoryList
//                                                             .length,
//                                                         scrollDirection:
//                                                             Axis.vertical,
//                                                         physics:
//                                                             NeverScrollableScrollPhysics(),
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           final subCategory =
//                                                               controller
//                                                                       .subCategoryList[
//                                                                   index];
//                                                           final products = controller
//                                                               .allProductList
//                                                               .where((product) =>
//                                                                   product
//                                                                       .subCategoryId ==
//                                                                   subCategory
//                                                                       .id)
//                                                               .toList();
//                                                           return ListTileTheme(
//                                                             minLeadingWidth: 20,
//                                                             child: Theme(
//                                                               data: ThemeData()
//                                                                   .copyWith(
//                                                                       dividerColor:
//                                                                           Colors
//                                                                               .transparent),
//                                                               child:
//                                                                   ExpansionTile(
//                                                                 initiallyExpanded: controller
//                                                                             .isOpen
//                                                                             .length >
//                                                                         index &&
//                                                                     controller
//                                                                             .isOpen[
//                                                                         index],
//                                                                 onExpansionChanged:
//                                                                     (value) {
//                                                                   if (index <
//                                                                       controller
//                                                                           .isOpen
//                                                                           .length) {
//                                                                     controller.isOpen[
//                                                                             index] =
//                                                                         value;
//                                                                   } else {
//                                                                     controller
//                                                                         .selectedSubCategory
//                                                                         .value = controller
//                                                                             .subCategoryList[
//                                                                         index];
//                                                                     controller
//                                                                         .filterProductList();
//                                                                   }
//                                                                 },
//                                                                 tilePadding:
//                                                                     paddingEdgeInsets(
//                                                                         horizontal:
//                                                                             0,
//                                                                         vertical:
//                                                                             0),
//                                                                 minTileHeight:
//                                                                     8,
//                                                                 title: Align(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .centerLeft,
//                                                                   child:
//                                                                       TextCustom(
//                                                                     title: subCategory
//                                                                             .subCategoryName!
//                                                                             .capitalizeFirst ??
//                                                                         '',
//                                                                     fontSize:
//                                                                         16,
//                                                                     fontFamily:
//                                                                         FontFamily
//                                                                             .medium,
//                                                                   ),
//                                                                 ),
//                                                                 children: [
//                                                                   ListView
//                                                                       .builder(
//                                                                     itemCount:
//                                                                         products
//                                                                             .length,
//                                                                     shrinkWrap:
//                                                                         true,
//                                                                     physics:
//                                                                         NeverScrollableScrollPhysics(),
//                                                                     scrollDirection:
//                                                                         Axis.vertical,
//                                                                     itemBuilder:
//                                                                         (context,
//                                                                             productIndex) {
//                                                                       ProductModel
//                                                                           product =
//                                                                           products[
//                                                                               productIndex];
//                                                                       if (product
//                                                                               .subCategoryId ==
//                                                                           controller
//                                                                               .subCategoryList[index]
//                                                                               .id) {
//                                                                         return Padding(
//                                                                           padding: paddingEdgeInsets(
//                                                                               horizontal: 0,
//                                                                               vertical: 8),
//                                                                           child:
//                                                                               FittedBox(
//                                                                             child:
//                                                                                 Row(
//                                                                               children: [
//                                                                                 Stack(
//                                                                                   children: [
//                                                                                     NetworkImageWidget(
//                                                                                       imageUrl: product.productImage.toString(),
//                                                                                       width: 140.w,
//                                                                                       height: 162.h,
//                                                                                       borderRadius: 10,
//                                                                                       fit: BoxFit.cover,
//                                                                                     ),
//                                                                                     Container(
//                                                                                       margin: paddingEdgeInsets(horizontal: 8, vertical: 8),
//                                                                                       padding: paddingEdgeInsets(horizontal: 8, vertical: 4),
//                                                                                       decoration: BoxDecoration(color: themeChange.isDarkTheme() ? AppThemeData.grey900.withOpacity(0.8) : AppThemeData.grey100.withOpacity(0.8), borderRadius: BorderRadius.circular(5)),
//                                                                                       child: TextCustom(
//                                                                                         title: product.itemTag.toString(),
//                                                                                         color: AppThemeData.getRandomColor(),
//                                                                                         fontSize: 12,
//                                                                                         fontFamily: FontFamily.bold,
//                                                                                       ),
//                                                                                     )
//                                                                                   ],
//                                                                                 ),
//                                                                                 spaceW(width: 12),
//                                                                                 Column(
//                                                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                   children: [
//                                                                                     SizedBox(
//                                                                                       width: 206.w,
//                                                                                       child: Row(
//                                                                                         children: [
//                                                                                           Constant.showFoodType(name: product.foodType.toString()),
//                                                                                           Spacer(),
//                                                                                           GestureDetector(
//                                                                                             onTap: () {
//                                                                                               Get.to(() => AddMenuItemsScreenView(), arguments: {
//                                                                                                 'productModelId': product.id
//                                                                                               });
//                                                                                             },
//                                                                                             child: SvgPicture.asset(
//                                                                                               "assets/icons/ic_edit_2.svg",
//                                                                                               color: AppThemeData.secondary300,
//                                                                                             ),
//                                                                                           ),
//                                                                                           spaceW(width: 12),
//                                                                                           GestureDetector(
//                                                                                             onTap: () {
//                                                                                               showDialog(
//                                                                                                   context: context,
//                                                                                                   builder: (BuildContext context) {
//                                                                                                     return CustomDialogBox(
//                                                                                                       img: Image.asset(
//                                                                                                         "assets/animation/am_delete.gif",
//                                                                                                         height: 64.h,
//                                                                                                         width: 64.w,
//                                                                                                       ),
//                                                                                                       themeChange: themeChange,
//                                                                                                       title: "Delete Item".tr,
//                                                                                                       descriptions: "Are you sure you want to delete this item from the menu?".tr,
//                                                                                                       positiveString: "Yes".tr,
//                                                                                                       negativeString: "No".tr,
//                                                                                                       positiveClick: () async {
//                                                                                                         controller.removeItem(product.id.toString());
//                                                                                                       },
//                                                                                                       negativeClick: () {
//                                                                                                         Navigator.pop(context);
//                                                                                                       },
//                                                                                                       positiveButtonColor: AppThemeData.danger300,
//                                                                                                       negativeButtonColor: themeChange.isDarkTheme() ? AppThemeData.grey1000 : AppThemeData.grey50,
//                                                                                                       positiveButtonTextColor: themeChange.isDarkTheme() ? AppThemeData.grey1000 : AppThemeData.grey50,
//                                                                                                       negativeButtonTextColor: themeChange.isDarkTheme() ? AppThemeData.grey100 : AppThemeData.grey900,
//                                                                                                       negativeButtonBorderColor: themeChange.isDarkTheme() ? AppThemeData.grey600 : AppThemeData.grey400,
//                                                                                                     );
//                                                                                                   });
//                                                                                             },
//                                                                                             child: SvgPicture.asset(
//                                                                                               "assets/icons/ic_delete.svg",
//                                                                                               color: AppThemeData.danger300,
//                                                                                             ),
//                                                                                           ),
//                                                                                         ],
//                                                                                       ),
//                                                                                     ),
//                                                                                     TextCustom(
//                                                                                       title: product.productName.toString(),
//                                                                                       fontSize: 16,
//                                                                                       fontFamily: FontFamily.medium,
//                                                                                       color: themeChange.isDarkTheme() ? AppThemeData.grey50 : AppThemeData.grey1000,
//                                                                                     ),
//                                                                                     TextCustom(
//                                                                                       title: Constant.amountShow(amount: product.price.toString()),
//                                                                                       fontSize: 16,
//                                                                                       fontFamily: FontFamily.bold,
//                                                                                       color: themeChange.isDarkTheme() ? AppThemeData.grey50 : AppThemeData.grey1000,
//                                                                                     ),
//                                                                                     SizedBox(
//                                                                                       width: 206.w,
//                                                                                       child: TextCustom(
//                                                                                         title: product.description.toString(),
//                                                                                         maxLine: 1,
//                                                                                         textAlign: TextAlign.start,
//                                                                                         textOverflow: TextOverflow.ellipsis,
//                                                                                         color: themeChange.isDarkTheme() ? AppThemeData.grey400 : AppThemeData.grey600,
//                                                                                       ),
//                                                                                     ),
//                                                                                     spaceH(height: 8),
//                                                                                     SizedBox(
//                                                                                       height: 24.h,
//                                                                                       width: 150.w,
//                                                                                       child: Row(
//                                                                                         mainAxisSize: MainAxisSize.min,
//                                                                                         children: [
//                                                                                           Expanded(
//                                                                                             child: TextCustom(
//                                                                                               title: "In Stock".tr,
//                                                                                               fontSize: 16,
//                                                                                               color: themeChange.isDarkTheme() ? AppThemeData.grey300 : AppThemeData.grey700,
//                                                                                             ),
//                                                                                           ),
//                                                                                           spaceW(width: 8),
//                                                                                           Expanded(
//                                                                                             child: SizedBox(
//                                                                                               height: 26.h,
//                                                                                               child: FittedBox(
//                                                                                                 child: CupertinoSwitch(
//                                                                                                   activeTrackColor: AppThemeData.primary300,
//                                                                                                   value: product.inStock!,
//                                                                                                   onChanged: (value) {
//                                                                                                     product.inStock = value;
//                                                                                                     controller.filteredProductList[productIndex].inStock = value;
//                                                                                                     controller.update();
//                                                                                                     controller.updateProduct(product);
//                                                                                                   },
//                                                                                                 ),
//                                                                                               ),
//                                                                                             ),
//                                                                                           ),
//                                                                                         ],
//                                                                                       ),
//                                                                                     )
//                                                                                   ],
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                         );
//                                                                       }
//                                                                       return Container();
//                                                                     },
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           );
//                                                         },
//                                                       );
//                                           }
//                                         })
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                   ],
//                 ),
//                 floatingActionButton: FloatingActionButton(
//                   onPressed: () {
//                     if (Constant.ownerModel!.vendorId != null &&
//                         Constant.ownerModel!.vendorId!.isNotEmpty) {
//                       Get.to(() => AddMenuItemsScreenView());
//                     } else {
//                       ShowToastDialog.toast(
//                           "First Add your restaurant to change Option.".tr);
//                     }
//                   },
//                   child: Icon(Icons.add),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }

// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/models/product_model.dart';
import 'package:restaurant/app/modules/add_menu_item_screen/views/add_menu_item_screen_view.dart';
import 'package:restaurant/app/modules/menu_screen/controllers/menu_screen_controller.dart';
import 'package:restaurant/app/widget/network_image_widget.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/constant_widgets/no_menu_items_view.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/responsive.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class CategoryDetailView extends StatelessWidget {
  const CategoryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder<MenuScreenController>(
      init: MenuScreenController(),
      builder: (controller) {
        return Obx(
          () => Container(
            width: Responsive.width(100, context),
            height: Responsive.height(100, context),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  // Header
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
                            EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Back Button and Category Info
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
                                          color: Colors.white.withOpacity(.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_back_ios_rounded,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                          title: controller.selectedCategory
                                                  .value.categoryName ??
                                              'Category',
                                          fontSize: 20,
                                          color: AppThemeData.primaryWhite,
                                          fontFamily: FontFamily.medium,
                                          textAlign: TextAlign.start,
                                        ),
                                        TextCustom(
                                          title:
                                              "${controller.categoryProductList.length} items",
                                          fontSize: 12,
                                          color: AppThemeData.primaryWhite,
                                          fontFamily: FontFamily.regular,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Add Button
                                InkWell(
                                  onTap: () {
                                    if (Constant.ownerModel!.vendorId != null &&
                                        Constant
                                            .ownerModel!.vendorId!.isNotEmpty) {
                                      Get.to(() => AddMenuItemsScreenView());
                                    } else {
                                      ShowToastDialog.toast(
                                          "First Add your restaurant to change Option."
                                              .tr);
                                    }
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
                  // Body
                  controller.categoryProductList.isEmpty
                      ? Expanded(
                          child: NoMenuItemsView(themeChange: themeChange))
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 24),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    controller.categoryProductList.length,
                                itemBuilder: (context, index) {
                                  ProductModel product =
                                      controller.categoryProductList[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 16),
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppThemeData.primaryWhite,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xffE2E8F0),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          // Product Image
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              color: AppThemeData.grey100,
                                              child: product.productImage !=
                                                          null &&
                                                      product.productImage!
                                                          .isNotEmpty
                                                  ? NetworkImageWidget(
                                                      imageUrl:
                                                          product.productImage!,
                                                    )
                                                  : Icon(
                                                      Icons.image_outlined,
                                                      color:
                                                          AppThemeData.grey400,
                                                    ),
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          // Product Info
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Product Name with Status Indicator
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 16,
                                                      height: 16,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        border: Border.all(
                                                          color:
                                                              Color(0xffEF4444),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Container(
                                                          width: 8,
                                                          height: 8,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xffEF4444),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    TextCustom(
                                                      title:
                                                          product.productName ??
                                                              '',
                                                      fontSize: 14,
                                                      fontFamily:
                                                          FontFamily.medium,
                                                      color: Color(0xff1D293D),
                                                      maxLine: 1,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 4),
                                                // Product Description
                                                if (product.description !=
                                                        null &&
                                                    product.description!
                                                        .isNotEmpty)
                                                  TextCustom(
                                                    title:
                                                        product.description ??
                                                            "",
                                                    fontSize: 12,
                                                    fontFamily:
                                                        FontFamily.regular,
                                                    color: Color(0xff62748E),
                                                    maxLine: 2,
                                                  ),
                                                SizedBox(height: 8),
                                                // Price and Add-ons/Variants
                                                Row(
                                                  children: [
                                                    TextCustom(
                                                      title:
                                                          "\$${product.price ?? '0.00'}",
                                                      fontSize: 14,
                                                      fontFamily:
                                                          FontFamily.medium,
                                                      color: Color(0xff432DD7),
                                                    ),
                                                    SizedBox(width: 12),
                                                    if (product.variationList !=
                                                            null &&
                                                        product.variationList!
                                                            .isNotEmpty)
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 1,
                                                                horizontal: 4),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffEEF2FF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: TextCustom(
                                                          title: "Variants",
                                                          fontSize: 12,
                                                          fontFamily:
                                                              FontFamily.medium,
                                                          color:
                                                              Color(0xff432DD7),
                                                          // decoration:
                                                          //     TextDecoration
                                                          //         .underline,
                                                        ),
                                                      ),
                                                    if (product.variationList !=
                                                            null &&
                                                        product.variationList!
                                                            .isNotEmpty &&
                                                        product.addonsList !=
                                                            null &&
                                                        product.addonsList!
                                                            .isNotEmpty)
                                                      TextCustom(
                                                        title: "   ",
                                                        fontSize: 12,
                                                      ),
                                                    if (product.addonsList !=
                                                            null &&
                                                        product.addonsList!
                                                            .isNotEmpty)
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 1,
                                                                horizontal: 4),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffEFF6FF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: TextCustom(
                                                          title: "Add-ons",
                                                          fontSize: 12,
                                                          fontFamily:
                                                              FontFamily.medium,
                                                          color:
                                                              Color(0xff1447E6),
                                                          // decoration:
                                                          //     TextDecoration
                                                          //         .underline,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                // Edit and Status Toggle
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Get.to(
                                                            () =>
                                                                AddMenuItemsScreenView(),
                                                            arguments: {
                                                              'productModelId':
                                                                  product.id
                                                            });
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3,
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffF1F5F9),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.edit,
                                                              size: 16,
                                                              color:
                                                                  AppThemeData
                                                                      .grey500,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            TextCustom(
                                                              title: "Edit",
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .medium,
                                                              color: Color(
                                                                  0xff314158),
                                                              // decoration:
                                                              //     TextDecoration
                                                              //         .underline,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 12),
                                                    // Status Toggle
                                                    SizedBox(
                                                      height: 24,
                                                      width: 44,
                                                      child: CupertinoSwitch(
                                                        value: product.status ==
                                                            true,
                                                        onChanged: (value) {
                                                          product.status =
                                                              value;
                                                          controller
                                                              .categoryProductList[
                                                                  index]
                                                              .status = value;
                                                          controller.update();
                                                          controller
                                                              .updateProduct(
                                                                  product);
                                                        },
                                                        inactiveTrackColor:
                                                            Color(0xffCAD5E2),
                                                        activeColor:
                                                            Color(0xff00C950),
                                                        inactiveThumbColor:
                                                            Colors.white,
                                                        // activeThumbColor:
                                                        //     Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    TextCustom(
                                                      title:
                                                          product.status == true
                                                              ? "Available"
                                                              : "Unavailable",
                                                      fontSize: 12,
                                                      fontFamily:
                                                          FontFamily.medium,
                                                      color: product.status ==
                                                              true
                                                          ? Color(0xff62748E)
                                                          : Color(0xff62748E),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
