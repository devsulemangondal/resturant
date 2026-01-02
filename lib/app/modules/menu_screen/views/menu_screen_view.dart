// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/models/category_model.dart';
import 'package:restaurant/app/modules/add_menu_item_screen/views/add_menu_item_screen_view.dart';
import 'package:restaurant/app/modules/menu_screen/controllers/menu_screen_controller.dart';
import 'package:restaurant/app/modules/menu_screen/views/category_detail_view.dart';
import 'package:restaurant/app/widget/network_image_widget.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/constant_widgets/no_menu_items_view.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/responsive.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class MenuScreenView extends StatelessWidget {
  const MenuScreenView({super.key});

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
              backgroundColor: Colors.transparent,
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
                            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                      title: "Menu Management",
                                      fontSize: 20,
                                      color: AppThemeData.primaryWhite,
                                      fontFamily: FontFamily.medium,
                                      textAlign: TextAlign.start,
                                    ),
                                    TextCustom(
                                      title: "Manage your restaurant menu".tr,
                                      fontSize: 14,
                                      color: AppThemeData.primaryWhite,
                                      fontFamily: FontFamily.regular,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
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
                  controller.isLoading.value
                      ? Constant.loader()
                      : controller.categoryList.isEmpty
                          ? Expanded(
                              child: NoMenuItemsView(themeChange: themeChange))
                          : Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Info Box
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Color(0xffEFF6FF),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Color(0xffC6D2FF),
                                            width: 1,
                                          ),
                                        ),
                                        child: TextCustom(
                                          title:
                                              "Organize your menu into categories and add items with pricing, variants, and add-ons."
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
                                      // Categories Title
                                      TextCustom(
                                        title:
                                            "Categories (${controller.categoryList.where((cat) => cat.id != 'all').length})",
                                        fontSize: 16,
                                        fontFamily: FontFamily.bold,
                                        color: themeChange.isDarkTheme()
                                            ? AppThemeData.grey100
                                            : AppThemeData.grey900,
                                      ),
                                      SizedBox(height: 16),
                                      // Categories List
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: controller.categoryList
                                            .where((cat) => cat.id != 'all')
                                            .length,
                                        itemBuilder: (context, index) {
                                          List<CategoryModel>
                                              filteredCategories = controller
                                                  .categoryList
                                                  .where(
                                                      (cat) => cat.id != 'all')
                                                  .toList();
                                          CategoryModel category =
                                              filteredCategories[index];
                                          int itemCount =
                                              controller.categoryProductCount[
                                                      category.id] ??
                                                  0;

                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 16),
                                            child: GestureDetector(
                                              onTap: () {
                                                // Navigate to category detail
                                                controller.selectedCategory
                                                    .value = category;
                                                controller.getSubCategory(
                                                    category.id.toString());

                                                controller.categoryProductList
                                                        .value =
                                                    controller.allProductList
                                                        .where((p) =>
                                                            p.categoryId ==
                                                            category.id)
                                                        .toList();
                                                Get.to(CategoryDetailView());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color:
                                                      themeChange.isDarkTheme()
                                                          ? AppThemeData.grey900
                                                          : AppThemeData
                                                              .primaryWhite,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: themeChange
                                                            .isDarkTheme()
                                                        ? AppThemeData.grey800
                                                        : AppThemeData.grey200,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    // Category Image
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        height: 80,
                                                        width: 80,
                                                        color: themeChange
                                                                .isDarkTheme()
                                                            ? AppThemeData
                                                                .grey800
                                                            : AppThemeData
                                                                .grey100,
                                                        child: category.image !=
                                                                    null &&
                                                                category.image!
                                                                    .isNotEmpty
                                                            ? NetworkImageWidget(
                                                                imageUrl: category
                                                                        .image ??
                                                                    '',
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .image_outlined,
                                                                color:
                                                                    AppThemeData
                                                                        .grey500,
                                                              ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 16),
                                                    // Category Info
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextCustom(
                                                            title: category
                                                                    .categoryName
                                                                    ?.toString() ??
                                                                "Unknown",
                                                            fontSize: 16,
                                                            fontFamily:
                                                                FontFamily.bold,
                                                            color: themeChange
                                                                    .isDarkTheme()
                                                                ? AppThemeData
                                                                    .grey100
                                                                : AppThemeData
                                                                    .grey900,
                                                          ),
                                                          SizedBox(height: 8),
                                                          TextCustom(
                                                            title:
                                                                "$itemCount items",
                                                            fontSize: 14,
                                                            fontFamily:
                                                                FontFamily
                                                                    .regular,
                                                            color: themeChange
                                                                    .isDarkTheme()
                                                                ? AppThemeData
                                                                    .grey400
                                                                : AppThemeData
                                                                    .grey600,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Arrow Icon
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size: 16,
                                                      color: AppThemeData
                                                          .primary300,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 20),
                                    ],
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
