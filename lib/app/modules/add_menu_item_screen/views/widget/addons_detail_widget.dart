// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/models/addons_model.dart';
import 'package:restaurant/app/modules/add_menu_item_screen/controllers/add_menu_item_screen_controller.dart';
import 'package:restaurant/app/widget/text_field_widget.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';

class AddonsDetailWidget extends StatelessWidget {
  const AddonsDetailWidget({super.key});

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
                  "Add-ons (Optional)",
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
                    controller.isAddingAddon.toggle();
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.add, color: AppThemeData.primary300),
                      SizedBox(width: 6),
                      Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppThemeData.primary300,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// ADD ADD-ON CARD
            if (controller.isAddingAddon.value)
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
                            hintText: "Name (e.g., Extra Cheese)",
                            controller: controller.addonsNameController.value,
                       
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFieldWidget(
                            hintText: "Price",
                            controller: controller.addonsPriceController.value,
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
                            title: "Add Add-on",
                            size: const Size(double.infinity, 48),
                            gradientColors: const [
                              Color(0xFF4F39F6),
                              Color(0xFF155DFC),
                            ],
                            onTap: () {
                              if (controller.addonsNameController.value.text
                                      .isEmpty ||
                                  controller.addonsPriceController.value.text
                                      .isEmpty) {
                                ShowToastDialog.toast("Name & price required");
                                return;
                              }

                              controller.addonsList.add(
                                AddonsModel(
                                  name: controller
                                      .addonsNameController.value.text,
                                  price: controller
                                      .addonsPriceController.value.text,
                                  inStock: true,
                                ),
                              );

                              controller.addonsNameController.value.clear();
                              controller.addonsPriceController.value.clear();
                              controller.isAddingAddon.value = false;
                              controller.update();
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.isAddingAddon.value = false;
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

            /// ADDED ADD-ONS LIST
            if (controller.addonsList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.addonsList.length,
                  itemBuilder: (context, index) {
                    final addon = controller.addonsList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFC6D2FF)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          /// TEXT
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  addon.name ?? "",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1D293D),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  addon.price ?? "0",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// DELETE
                          GestureDetector(
                            onTap: () {
                              controller.addonsList.removeAt(index);
                              controller.update();
                            },
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE4E6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Color(0xFFEF4444),
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
      },
    );
  }
}
