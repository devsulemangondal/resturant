import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/common_ui.dart';
import 'package:restaurant/themes/responsive.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/statement_controller.dart';

class StatementView extends StatelessWidget {
  const StatementView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder(
        init: StatementController(),
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
                              SizedBox(width: 12),
                            ],
                          ),
                          SizedBox(height: 16),
                          TextCustom(
                            title: "Statement Download".tr,
                            fontSize: 28,
                            maxLine: 2,
                            color: AppThemeData.primaryWhite,
                            fontFamily: FontFamily.bold,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 8),
                          TextCustom(
                            title:
                                "Download your order statements with ease".tr,
                            fontSize: 14,
                            maxLine: 2,
                            color: AppThemeData.primaryWhite.withOpacity(0.9),
                            fontFamily: FontFamily.regular,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Body Section
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/animation/gif_statement.gif",
                              height: 120,
                              width: 120,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: TextCustom(
                              title: "Download Order Statement".tr,
                              fontSize: 18,
                              fontFamily: FontFamily.medium,
                              color: themeChange.isDarkTheme()
                                  ? AppThemeData.grey100
                                  : AppThemeData.grey900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextCustom(
                              title:
                                  "Select your preferred time period, choose a date range and download your order statement"
                                      .tr,
                              textAlign: TextAlign.center,
                              maxLine: 3,
                              fontSize: 14,
                              color: themeChange.isDarkTheme()
                                  ? AppThemeData.grey400
                                  : AppThemeData.grey600,
                              fontFamily: FontFamily.regular,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: themeChange.isDarkTheme()
                                  ? AppThemeData.grey900
                                  : AppThemeData.primaryWhite,
                              border: Border.all(
                                color: themeChange.isDarkTheme()
                                    ? AppThemeData.grey800
                                    : AppThemeData.grey200,
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                  title: "Select Time Period".tr,
                                  fontSize: 16,
                                  fontFamily: FontFamily.medium,
                                  color: themeChange.isDarkTheme()
                                      ? AppThemeData.grey100
                                      : AppThemeData.grey900,
                                ),
                                const SizedBox(height: 12),
                                Obx(() {
                                  return DropdownButtonFormField(
                                    borderRadius: BorderRadius.circular(12),
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: themeChange.isDarkTheme()
                                          ? AppThemeData.grey100
                                          : AppThemeData.grey900,
                                      fontSize: 16,
                                    ),
                                    onChanged: (String? statusType) {
                                      final now = DateTime.now();
                                      controller.selectedDateOption.value =
                                          statusType ?? "All";

                                      switch (statusType) {
                                        case 'Last Month':
                                          controller.selectedDateRangeForPdf
                                              .value = DateTimeRange(
                                            start: now.subtract(
                                                const Duration(days: 30)),
                                            end: DateTime(now.year, now.month,
                                                now.day, 23, 59, 0, 0),
                                          );
                                          break;
                                        case 'Last 6 Months':
                                          controller.selectedDateRangeForPdf
                                              .value = DateTimeRange(
                                            start: DateTime(now.year,
                                                now.month - 6, now.day),
                                            end: DateTime(now.year, now.month,
                                                now.day, 23, 59, 0, 0),
                                          );
                                          break;
                                        case 'Last Year':
                                          controller.selectedDateRangeForPdf
                                              .value = DateTimeRange(
                                            start: DateTime(now.year - 1,
                                                now.month, now.day),
                                            end: DateTime(now.year, now.month,
                                                now.day, 23, 59, 0, 0),
                                          );
                                          break;
                                        case 'Custom':
                                          controller.isCustomVisible.value =
                                              true;
                                          break;
                                        case 'All':
                                        default:
                                          controller.selectedDateRangeForPdf
                                              .value = DateTimeRange(
                                            start: DateTime(now.year, 1, 1),
                                            end: DateTime(now.year, now.month,
                                                now.day, 23, 59, 0, 0),
                                          );
                                          break;
                                      }

                                      controller.isCustomVisible.value =
                                          statusType == 'Custom';
                                    },
                                    initialValue:
                                        controller.selectedDateOption.value,
                                    items: controller.dateOption
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: TextCustom(
                                          title: value,
                                          fontSize: 16,
                                        ),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: themeChange.isDarkTheme()
                                          ? AppThemeData.grey800
                                          : AppThemeData.grey50,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 14),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: themeChange.isDarkTheme()
                                              ? AppThemeData.grey700
                                              : AppThemeData.grey200,
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: themeChange.isDarkTheme()
                                              ? AppThemeData.grey700
                                              : AppThemeData.grey200,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: AppThemeData.primary300,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                const SizedBox(height: 24),
                                Obx(
                                  () => Visibility(
                                    visible: controller.isCustomVisible.value,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                          title: "Select Start Date to End Date"
                                              .tr,
                                          fontSize: 14,
                                          fontFamily: FontFamily.medium,
                                          color: themeChange.isDarkTheme()
                                              ? AppThemeData.grey100
                                              : AppThemeData.grey900,
                                        ),
                                        const SizedBox(height: 12),
                                        GestureDetector(
                                          onTap: () {
                                            showDateRangePickerForPdf(
                                                context, controller);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 14),
                                            decoration: BoxDecoration(
                                              color: themeChange.isDarkTheme()
                                                  ? AppThemeData.grey800
                                                  : AppThemeData.grey50,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: themeChange.isDarkTheme()
                                                    ? AppThemeData.grey700
                                                    : AppThemeData.grey200,
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Obx(
                                                  () => TextCustom(
                                                    title: controller
                                                                    .selectedDateRangeForPdf
                                                                    .value
                                                                    .start ==
                                                                DateTime(
                                                                    DateTime.now()
                                                                        .year,
                                                                    DateTime
                                                                        .january,
                                                                    1) &&
                                                            controller
                                                                    .selectedDateRangeForPdf
                                                                    .value
                                                                    .end ==
                                                                DateTime(
                                                                    DateTime.now()
                                                                        .year,
                                                                    DateTime.now()
                                                                        .month,
                                                                    DateTime.now()
                                                                        .day,
                                                                    23,
                                                                    59,
                                                                    0,
                                                                    0)
                                                        ? "Select Date".tr
                                                        : "${DateFormat('dd/MM/yyyy').format(controller.selectedDateRangeForPdf.value.start)} to ${DateFormat('dd/MM/yyyy').format(controller.selectedDateRangeForPdf.value.end)}",
                                                    fontSize: 14,
                                                    fontFamily:
                                                        FontFamily.regular,
                                                    color: themeChange
                                                            .isDarkTheme()
                                                        ? AppThemeData.grey100
                                                        : AppThemeData.grey900,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.calendar_month_outlined,
                                                  color:
                                                      AppThemeData.primary300,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                      ],
                                    ),
                                  ),
                                ),
                                RoundShapeButton(
                                    size: Size(double.infinity, 54),
                                    title: "Download".tr,
                                    buttonColor: AppThemeData.primary300,
                                    buttonTextColor: AppThemeData.primaryWhite,
                                    onTap: () {
                                      controller.dataGetForPdf();
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> showDateRangePickerForPdf(
      BuildContext context, StatementController controller) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Ride Booking Date".tr),
          content: SizedBox(
            height: 300,
            width: 300,
            child: SfDateRangePicker(
              initialDisplayDate: DateTime.now(),
              maxDate: DateTime.now(),
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged:
                  (DateRangePickerSelectionChangedArgs args) async {
                if (args.value is PickerDateRange) {
                  controller.startDateForPdf =
                      (args.value as PickerDateRange).startDate;
                  controller.endDateForPdf =
                      (args.value as PickerDateRange).endDate;
                }
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                controller.selectedDateRangeForPdf.value = DateTimeRange(
                  start: DateTime(DateTime.now().year, DateTime.january, 1),
                  end: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day, 23, 59, 0, 0),
                );
                Navigator.of(context).pop();
              },
              child: Text("clear".tr),
            ),
            TextButton(
              onPressed: () {
                if (controller.startDateForPdf != null &&
                    controller.endDateForPdf != null) {
                  controller.selectedDateRangeForPdf.value = DateTimeRange(
                    start: controller.startDateForPdf!,
                    end: DateTime(
                        controller.endDateForPdf!.year,
                        controller.endDateForPdf!.month,
                        controller.endDateForPdf!.day,
                        23,
                        59,
                        0,
                        0),
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text("OK".tr),
            ),
          ],
        );
      },
    );
  }
}
