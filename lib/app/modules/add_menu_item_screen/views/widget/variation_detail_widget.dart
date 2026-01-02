// ignore_for_file: deprecated_member_use, must_be_immutable, depend_on_referenced_packages, use_build_context_synchronously, invalid_use_of_protected_member, use_super_parameters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/models/variation_model.dart';
import 'package:restaurant/app/modules/add_menu_item_screen/controllers/add_menu_item_screen_controller.dart';
import 'package:restaurant/app/widget/text_field_widget.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class VariantSection extends StatelessWidget {
  const VariantSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return GetX<AddMenuItemsScreenController>(
        init: AddMenuItemsScreenController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Variants (Optional)",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: FontFamily.medium,
                      color: themeChange.isDarkTheme()
                          ? AppThemeData.grey100
                          : AppThemeData.grey900,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.isAddingVariant.toggle();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.add, color: AppThemeData.primary300),
                        const SizedBox(width: 6),
                        Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppThemeData.primary300,
                            fontFamily: FontFamily.medium,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// ADDED VARIANTS LIST

              /// ADD VARIANT CARD
              if (controller.isAddingVariant.value)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFC6D2FF)),
                  ),
                  child: Column(
                    children: [
                      /// INPUTS
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              hintText: "Name (e.g., Small)",
                              controller:
                                  controller.variationNameController.value,
                          
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFieldWidget(
                              hintText: "Price",
                              controller:
                                  controller.optionPriceController.first,
                              textInputType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                  
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// ACTION BUTTONS
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: GradientRoundShapeButton(
                              title: "Add Variant",
                              size: const Size(double.infinity, 48),
                              gradientColors: const [
                                Color(0xFF4F39F6),
                                Color(0xFF155DFC),
                              ],
                              onTap: () {
                                if (controller.variationNameController.value
                                    .text.isEmpty) {
                                  ShowToastDialog.toast(
                                      "Variant name required");
                                  return;
                                }

                                controller.variationList.add(
                                  VariationModel(
                                    name: controller
                                        .variationNameController.value.text,
                                    inStock: true,
                                    optionList: controller
                                        .setOptionListFromController(),
                                  ),
                                );

                                controller.variationNameController.value
                                    .clear();
                                controller.optionPriceController.first.clear();
                                controller.isAddingVariant.value = false;
                                controller.update();
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.isAddingVariant.value = false;
                              },
                              child: Container(
                                height: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE2E8F0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF334155),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              if (controller.variationList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.variationList.length,
                    itemBuilder: (context, index) {
                      final variation = controller.variationList[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: themeChange.isDarkTheme()
                              ? AppThemeData.grey900
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// HEADER ROW
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    variation.name ?? "",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: FontFamily.medium,
                                      color: themeChange.isDarkTheme()
                                          ? AppThemeData.grey100
                                          : AppThemeData.grey900,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.variationList.removeAt(index);
                                    controller.update();
                                  },
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: AppThemeData.danger300,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            /// OPTIONS
                            ...variation.optionList!.map(
                              (opt) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      opt.price ?? "",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
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
            ],
          );
        });
  }
}
