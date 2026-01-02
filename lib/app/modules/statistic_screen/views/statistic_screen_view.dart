// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/models/pie_model.dart';
import 'package:restaurant/app/modules/statistic_screen/controllers/statistic_screen_controller.dart';
import 'package:restaurant/app/widget/custom_app_bar.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticScreenView extends StatelessWidget {
  const StatisticScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder<StatisticScreenController>(
      init: StatisticScreenController(),
      builder: (controller) {
        return Container(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                // Modern Header
                CustomAppBar(),
                // Body
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      child: Obx(
                        () => controller.isLoading.value == true
                            ? Constant.loader()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Info Cards
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppThemeData.primary300
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppThemeData.primary300
                                            .withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: TextCustom(
                                      title:
                                          "Track and analyze your restaurant's order performance and trends."
                                              .tr,
                                      fontSize: 14,
                                      maxLine: 2,
                                      color: themeChange.isDarkTheme()
                                          ? AppThemeData.grey100
                                          : AppThemeData.grey700,
                                      fontFamily: FontFamily.regular,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(height: 28),
                                  // Total Revenue Section
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: AppThemeData.primaryWhite,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppThemeData.grey200,
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextCustom(
                                                  title: "Total Revenue".tr,
                                                  color: themeChange
                                                          .isDarkTheme()
                                                      ? AppThemeData.grey100
                                                      : AppThemeData.grey900,
                                                  fontFamily: FontFamily.medium,
                                                  textAlign: TextAlign.start,
                                                  fontSize: 14,
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    TextCustom(
                                                      title: controller
                                                                  .selectedTimeRevenue
                                                                  .value ==
                                                              'Weekly'
                                                          ? "${controller.weeklyRevenue.value}"
                                                          : "${controller.totalRevenue.value}",
                                                      fontSize: 24,
                                                      fontFamily:
                                                          FontFamily.bold,
                                                      color: AppThemeData
                                                          .primary300,
                                                    ),
                                                    SizedBox(width: 8),
                                                    SvgPicture.asset(
                                                      "assets/icons/ic_up_arrow.svg",
                                                      height: 12.h,
                                                      width: 10.w,
                                                      color: AppThemeData
                                                          .secondary300,
                                                    ),
                                                    SizedBox(width: 4),
                                                    TextCustom(
                                                      title:
                                                          "Selected_TimeRevenue"
                                                              .trParams({
                                                        "selectedTimeRevenue":
                                                            controller
                                                                .selectedTimeRevenue
                                                                .value
                                                      }),
                                                      fontSize: 11,
                                                      color: AppThemeData
                                                          .secondary300,
                                                      fontFamily:
                                                          FontFamily.regular,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: themeChange.isDarkTheme()
                                                    ? AppThemeData.grey800
                                                    : AppThemeData.grey50,
                                                border: Border.all(
                                                  color: themeChange
                                                          .isDarkTheme()
                                                      ? AppThemeData.grey700
                                                      : AppThemeData.grey200,
                                                  width: 1,
                                                ),
                                              ),
                                              child: PopupMenuButton<String>(
                                                color: themeChange.isDarkTheme()
                                                    ? AppThemeData.grey900
                                                    : AppThemeData.primaryWhite,
                                                padding: EdgeInsets.all(8),
                                                onSelected: (value) {
                                                  controller.selectedTimeRevenue
                                                      .value = value;
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'Weekly',
                                                    child: Text("Weekly".tr),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'Monthly',
                                                    child: Text("Monthly".tr),
                                                  ),
                                                ],
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    TextCustom(
                                                      title: controller
                                                          .selectedTimeRevenue
                                                          .value,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          FontFamily.medium,
                                                      color: themeChange
                                                              .isDarkTheme()
                                                          ? AppThemeData.grey100
                                                          : AppThemeData
                                                              .grey900,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Icon(
                                                      Icons
                                                          .arrow_drop_down_rounded,
                                                      color: AppThemeData
                                                          .primary300,
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        BarChartRevenue(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 28),
                                  // Total Orders Section
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: themeChange.isDarkTheme()
                                          ? AppThemeData.grey900
                                          : AppThemeData.primaryWhite,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: themeChange.isDarkTheme()
                                            ? AppThemeData.grey800
                                            : AppThemeData.grey200,
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextCustom(
                                                  title: "Total Orders".tr,
                                                  color: themeChange
                                                          .isDarkTheme()
                                                      ? AppThemeData.grey100
                                                      : AppThemeData.grey900,
                                                  fontFamily: FontFamily.medium,
                                                  textAlign: TextAlign.start,
                                                  fontSize: 14,
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    TextCustom(
                                                      title:
                                                          '${controller.rejectedOrderListCount.value + controller.completedOrderListCount.value + controller.cancelledOrderListCount.value}',
                                                      fontSize: 24,
                                                      fontFamily:
                                                          FontFamily.bold,
                                                      color: AppThemeData
                                                          .primary300,
                                                    ),
                                                    SizedBox(width: 8),
                                                    SvgPicture.asset(
                                                      "assets/icons/ic_up_arrow.svg",
                                                      height: 12.h,
                                                      width: 10.w,
                                                      color: AppThemeData
                                                          .secondary300,
                                                    ),
                                                    SizedBox(width: 4),
                                                    TextCustom(
                                                      title:
                                                          "Selected_TimeRevenue"
                                                              .trParams({
                                                        "selectedTimeRevenue":
                                                            controller
                                                                .selectedTimeTotalOrders
                                                                .value
                                                      }),
                                                      fontSize: 11,
                                                      color: AppThemeData
                                                          .secondary300,
                                                      fontFamily:
                                                          FontFamily.regular,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: themeChange.isDarkTheme()
                                                    ? AppThemeData.grey800
                                                    : AppThemeData.grey50,
                                                border: Border.all(
                                                  color: themeChange
                                                          .isDarkTheme()
                                                      ? AppThemeData.grey700
                                                      : AppThemeData.grey200,
                                                  width: 1,
                                                ),
                                              ),
                                              child: PopupMenuButton<String>(
                                                color: themeChange.isDarkTheme()
                                                    ? AppThemeData.grey900
                                                    : AppThemeData.primaryWhite,
                                                padding: EdgeInsets.all(8),
                                                onSelected: (value) {
                                                  controller
                                                      .selectedTimeTotalOrders
                                                      .value = value;
                                                  controller.fetchOrderStats();
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'Weekly',
                                                    child: Text("Weekly".tr),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'Monthly',
                                                    child: Text("Monthly".tr),
                                                  ),
                                                ],
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    TextCustom(
                                                      title: controller
                                                          .selectedTimeTotalOrders
                                                          .value,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          FontFamily.medium,
                                                      color: themeChange
                                                              .isDarkTheme()
                                                          ? AppThemeData.grey100
                                                          : AppThemeData
                                                              .grey900,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Icon(
                                                      Icons
                                                          .arrow_drop_down_rounded,
                                                      color: AppThemeData
                                                          .primary300,
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        controller.isLoadingChatData.value ==
                                                true
                                            ? Constant.loader()
                                            : SfCircularChart(
                                                margin: EdgeInsets.all(0),
                                                legend: Legend(isVisible: true),
                                                series: <PieSeries<PieData,
                                                    String>>[
                                                  PieSeries<PieData, String>(
                                                      explode: true,
                                                      explodeIndex: 0,
                                                      dataSource:
                                                          controller.pieData,
                                                      xValueMapper:
                                                          (PieData data, _) =>
                                                              data.xData,
                                                      yValueMapper:
                                                          (PieData data, _) =>
                                                              data.yData,
                                                      dataLabelMapper:
                                                          (PieData data, _) =>
                                                              data.text,
                                                      pointColorMapper:
                                                          (PieData data, _) =>
                                                              data.color,
                                                      dataLabelSettings:
                                                          DataLabelSettings(
                                                              isVisible: true),
                                                      groupMode:
                                                          CircularChartGroupMode
                                                              .point,
                                                      groupTo: 3),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BarChart extends StatelessWidget {
  final String selectedTimeframe;
  final List<BarChartGroupData> barGroups;

  const _BarChart({required this.selectedTimeframe, required this.barGroups});

  @override
  Widget build(BuildContext context) {
    double maxY = barGroups
        .map((group) => group.barRods[0].toY)
        .reduce((a, b) => a > b ? a : b);

    maxY = maxY + (maxY * 0.1);

    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              final style = TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );

              return SideTitleWidget(
                meta: meta,
                space: 4,
                child: Text(value.toInt().toString(), style: style),
              );
            },
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text;
    if (selectedTimeframe == 'Weekly') {
      switch (value.toInt()) {
        case 0:
          text = 'Mn';
          break;
        case 1:
          text = 'Tu';
          break;
        case 2:
          text = 'Wd';
          break;
        case 3:
          text = 'Th';
          break;
        case 4:
          text = 'Fr';
          break;
        case 5:
          text = 'Sa';
          break;
        case 6:
          text = 'Su';
          break;
        default:
          text = '';
          break;
      }
    } else {
      switch (value.toInt()) {
        case 0:
          text = 'Ja';
          break;
        case 1:
          text = 'Fe';
          break;
        case 2:
          text = 'Ma';
          break;
        case 3:
          text = 'Ap';
          break;
        case 4:
          text = 'Ma';
          break;
        case 5:
          text = 'Ju';
          break;
        case 6:
          text = 'Ju';
          break;
        case 7:
          text = 'Au';
          break;
        case 8:
          text = 'Se';
          break;
        case 9:
          text = 'Oc';
          break;
        case 10:
          text = 'No';
          break;
        case 11:
          text = 'De';
          break;
        default:
          text = '';
          break;
      }
    }

    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(text, style: style),
    );
  }
}

class BarChartSample extends StatelessWidget {
  final controller = Get.put(StatisticScreenController());

  BarChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.6,
          child: Obx(() => _BarChart(
                selectedTimeframe: controller.selectedTimeRevenue.value,
                barGroups: controller.getBarGroups(),
              )),
        ),
      ],
    );
  }
}

class BarChartRevenue extends StatelessWidget {
  final controller = Get.put(StatisticScreenController());

  BarChartRevenue({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.shouldShowChart()) {
        return Center(
          child: Text(
            "No data available for the selected timeframe.".tr,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return Column(
        children: [
          AspectRatio(
            aspectRatio: 1.6,
            child: _BarChart(
              selectedTimeframe: controller.selectedTimeRevenue.value,
              barGroups: controller.getBarGroups(),
            ),
          ),
        ],
      );
    });
  }
}
