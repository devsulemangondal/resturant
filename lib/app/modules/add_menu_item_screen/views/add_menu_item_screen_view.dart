// // ignore_for_file: deprecated_member_use, must_be_immutable, depend_on_referenced_packages, use_build_context_synchronously, use_super_parameters

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:restaurant/app/modules/add_menu_item_screen/controllers/add_menu_item_screen_controller.dart';
// import 'package:restaurant/app/modules/add_menu_item_screen/views/widget/addons_detail_widget.dart';
// import 'package:restaurant/app/modules/add_menu_item_screen/views/widget/item_detail_widget.dart';
// import 'package:restaurant/app/modules/add_menu_item_screen/views/widget/price_detail_widget.dart';
// import 'package:restaurant/app/modules/add_menu_item_screen/views/widget/select_tag_widget.dart';
// import 'package:restaurant/app/widget/global_widgets.dart';
// import 'package:restaurant/app/widget/text_widget.dart';
// import 'package:restaurant/constant/constant.dart';
// import 'package:restaurant/themes/app_fonts.dart';
// import 'package:restaurant/themes/app_theme_data.dart';
// import 'package:restaurant/utils/dark_theme_provider.dart';

// import 'widget/variation_detail_widget.dart';

// class AddMenuItemsScreenView extends GetView<AddMenuItemsScreenController> {
//   const AddMenuItemsScreenView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeChange = Provider.of<DarkThemeProvider>(context);
//     return GetBuilder(
//       init: AddMenuItemsScreenController(),
//       builder: (controller) {
//         return Scaffold(
//           backgroundColor: themeChange.isDarkTheme() ? AppThemeData.grey1000 : AppThemeData.grey50,
//           appBar: AppBar(
//             systemOverlayStyle: const SystemUiOverlayStyle(
//               statusBarColor: Colors.transparent,
//               statusBarIconBrightness: Brightness.dark,
//               statusBarBrightness: Brightness.light,
//             ),
//             backgroundColor: Colors.transparent,
//             surfaceTintColor: Colors.transparent,
//             automaticallyImplyLeading: false,
//             leading: InkWell(
//               onTap: () {
//                 if (controller.currentStep.value == 0) {
//                   Get.back();
//                 } else {
//                   controller.previousStep();
//                 }
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: themeChange.isDarkTheme() ? AppThemeData.grey900 : AppThemeData.grey100,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10, right: 12, top: 10, bottom: 10),
//                     child: Icon(
//                       Icons.arrow_back_ios_rounded,
//                       size: 20,
//                       color: themeChange.isDarkTheme() ? AppThemeData.grey100 : AppThemeData.grey900,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             actions: [
//               Obx(
//                 () => Row(
//                   children: [
//                     TextCustom(
//                       title: "0${controller.currentStep.value + 1}",
//                       fontFamily: FontFamily.bold,
//                       fontSize: 16,
//                       color: AppThemeData.primary300,
//                     ),
//                     const TextCustom(
//                       title: "/05",
//                       color: AppThemeData.grey500,
//                     ),
//                   ],
//                 ),
//               ),
//               spaceW(width: 16)
//             ],
//           ),
//           body: Obx(() => stepper(context)),
//         );
//       },
//     );
//   }

//   Widget stepper(BuildContext context) {
//     return controller.isLoading.value
//         ? Center(child: Constant.loader())
//         : Obx(() => IndexedStack(
//               index: controller.currentStep.value,
//               children: [ItemDetailWidget(), PriceDetailWidget(), AddonsDetailWidget(), VariationDetailWidget(), SelectTagWidget()],
//             ));
//   }
// }

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/add_menu_item_screen/controllers/add_menu_item_screen_controller.dart';
import 'package:restaurant/app/modules/add_menu_item_screen/views/widget/addons_detail_widget.dart';
import 'package:restaurant/app/modules/add_menu_item_screen/views/widget/variation_detail_widget.dart';
import 'package:restaurant/app/widget/text_field_widget.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class AddMenuItemsScreenView extends GetView<AddMenuItemsScreenController> {
  const AddMenuItemsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeChange.isDarkTheme()
          ? AppThemeData.surface1000
          : AppThemeData.surface50,
      body: GetBuilder<AddMenuItemsScreenController>(
        init: AddMenuItemsScreenController(),
        builder: (controller) {
          return Column(
            children: [
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
                                      borderRadius: BorderRadius.circular(12),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                      title: controller.selectedCategory.value
                                              .categoryName ??
                                          'Category',
                                      fontSize: 20,
                                      color: AppThemeData.primaryWhite,
                                      fontFamily: FontFamily.medium,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Add Button
                          ],
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Item Image"),
                      const SizedBox(height: 4),
                      _buildImageUpload(controller, themeChange),
                      const SizedBox(height: 16),
                      _buildLabel("Item Name *"),
                      TextFieldWidget(
                        controller: controller.itemNameController.value,
                        hintText: "e.g., Classic Burger",
                      ),
                      const SizedBox(height: 10),
                      _buildLabel("Base Price *"),
                      TextFieldWidget(
                        controller: controller.priceController.value,
                        textInputType:
                            TextInputType.numberWithOptions(decimal: true),
                        hintText: "0.00",
                      ),
                      const SizedBox(height: 16),
                      _buildLabel("Discount"),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFieldWidget(
                              controller: controller.discountController.value,
                              textInputType: TextInputType.number,
                              hintText: "0",
                              // onPress: () {},
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: themeChange.isDarkTheme()
                                    ? AppThemeData.grey900
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppThemeData.grey300),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller
                                          .selectedDiscountType.value.isNotEmpty
                                      ? controller.selectedDiscountType.value
                                      : null,
                                  hint: Text("Type"),
                                  items: controller.discountType
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    controller.selectedDiscountType.value =
                                        newValue!;
                                    controller.update();
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildLabel("Description"),
                      TextFieldWidget(
                        controller: controller.itemDescriptionController.value,
                        hintText: "Describe your item...",
                        line: 3,
                      ),
                      const SizedBox(height: 16),
                      _buildLabel("Category *"),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey900
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppThemeData.grey300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: controller.selectedCategory.value.id,
                            hint: Text("Select Category"),
                            style: TextStyle(
                                color: Color(0xff90A1B9), fontSize: 14),
                            items: controller.categoryList.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id,
                                child: Text(item.categoryName ?? ""),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              var cat = controller.categoryList
                                  .firstWhere((e) => e.id == newValue);
                              controller.selectedCategory.value = cat;
                              controller.getSubCategory(newValue!);
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildLabel("Sub Category *"),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppThemeData.grey300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: controller.selectedSubCategory.value.id,
                            hint: Text("Select Sub Category"),
                            style: TextStyle(
                                color: Color(0xff90A1B9), fontSize: 14),
                            items: controller.subCategoryList.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id,
                                child: Text(item.subCategoryName ?? ""),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              var subCat = controller.subCategoryList
                                  .firstWhere((e) => e.id == newValue);
                              controller.selectedSubCategory.value = subCat;
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildLabel("Preparation Time (min) *"),
                      TextFieldWidget(
                        controller: controller.preparationTimeController.value,
                        textInputType: TextInputType.number,
                        hintText: "e.g., 20",
                      ),
                      const SizedBox(height: 16),
                      _buildLabel("Max Quantity *"),
                      TextFieldWidget(
                        controller: controller.maxQuantityController.value,
                        textInputType: TextInputType.number,
                        hintText: "e.g., 10",
                      ),
                      const SizedBox(height: 16),
                      _buildLabel("Item Type *"),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                              child: _buildTypeCard(controller, FoodType.veg,
                                  "Vegetarian", Colors.green, themeChange)),
                          const SizedBox(width: 16),
                          Expanded(
                              child: _buildTypeCard(controller, FoodType.nonVeg,
                                  "Non-Veg", Colors.red, themeChange)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      VariantSection(),
                      const SizedBox(height: 12),
                      AddonsDetailWidget(),
                      // _buildSectionLabel("Variants (Optional)",
                      //     () => _addVariantDialog(context, controller)),
                      // if (controller.variationList.isNotEmpty)
                      //   ...controller.variationList.map((v) => ListTile(
                      //         title: Text(v.name ?? ""),
                      //         subtitle:
                      //             Text("${v.optionList?.length ?? 0} options"),
                      //         trailing: IconButton(
                      //           icon: Icon(Icons.delete, color: Colors.red),
                      //           onPressed: () {
                      //             controller.variationList.remove(v);
                      //             controller.update();
                      //           },
                      //         ),
                      //       )),
                      // const SizedBox(height: 24),
                      // _buildSectionLabel("Add-ons (Optional)",
                      //     () => _addAddonDialog(context, controller)),
                      // if (controller.addonsList.isNotEmpty)
                      //   ...controller.addonsList.map((addon) => ListTile(
                      //         title: Text(addon.name ?? ""),
                      //         subtitle: Text(Constant.amountShow(
                      //             amount: addon.price ?? "0")),
                      //         trailing: IconButton(
                      //           icon: Icon(Icons.delete, color: Colors.red),
                      //           onPressed: () {
                      //             controller.addonsList.remove(addon);
                      //             controller.update();
                      //           },
                      //         ),
                      //       )),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xffE2E8F0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                  title: "Availability",
                                  fontFamily: FontFamily.medium,
                                  fontSize: 14,
                                  color: Color(0xff1D293D),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                TextCustom(
                                  title: "Set item as available for orders",
                                  fontSize: 12,
                                  color: Color(0xff62748E),
                                ),
                              ],
                            ),
                            Obx(() => CupertinoSwitch(
                                  value: controller.itemInStock.value,
                                  activeTrackColor: Colors.green,
                                  onChanged: (val) =>
                                      controller.itemInStock.value = val,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.validate()) {
                              controller.saveData();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppThemeData.primary300,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: TextCustom(
                            title: "Save Menu Item",
                            color: Colors.white,
                            fontFamily: FontFamily.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return TextCustom(
      title: text,
      fontFamily: FontFamily.medium,
      fontSize: 14,
      color: Color(0xff314158),
    );
  }

  Widget _buildSectionLabel(String text, VoidCallback onAdd) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextCustom(
          title: text,
          fontFamily: FontFamily.medium,
          fontSize: 14,
          color: AppThemeData.grey700,
        ),
        TextButton.icon(
          onPressed: onAdd,
          icon: Icon(Icons.add, size: 18),
          label: Text("Add"),
          style: TextButton.styleFrom(foregroundColor: AppThemeData.primary300),
        )
      ],
    );
  }

  Widget _buildImageUpload(
      AddMenuItemsScreenController controller, DarkThemeProvider theme) {
    return GestureDetector(
      onTap: () async {
        String? path = await controller.pickFile();
        if (path != null) {
          controller.itemImage.value = path;
          controller.update();
        }
      },
      child: Container(
        width: double.infinity,
        height: 190,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffCAD5E2)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Obx(() {
          if (controller.itemImage.value.isNotEmpty) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Constant.hasValidUrl(controller.itemImage.value)
                    ? Image.network(controller.itemImage.value,
                        fit: BoxFit.cover, width: double.infinity)
                    : Image.file(File(controller.itemImage.value),
                        fit: BoxFit.cover, width: double.infinity));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffDBEAFE),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  "assets/icons/ic_upload.svg",
                  color: Color(0xff4F39F6),
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(height: 8),
              Text("Upload Item Image",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff45556C),
                      fontWeight: FontWeight.w400)),
              Text("PNG, JPG up to 5MB",
                  style: TextStyle(color: Color(0xff90A1B9), fontSize: 12)),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTypeCard(AddMenuItemsScreenController controller, FoodType type,
      String label, Color color, DarkThemeProvider theme) {
    return Obx(() {
      bool isSelected = controller.foodType.value == type;
      return GestureDetector(
        onTap: () => controller.foodType.value = type,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: theme.isDarkTheme() ? AppThemeData.grey900 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isSelected ? color : Color(0xffE2E8F0),
                width: isSelected ? 1.5 : 1),
          ),
          child: Column(
            children: [
              Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: color, width: 2)),
                  child: Icon(Icons.circle, color: color, size: 8)),
              SizedBox(height: 8),
              Text(label,
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff1D293D),
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      );
    });
  }
}
