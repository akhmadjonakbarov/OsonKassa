import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../styles/app_colors.dart';
import '../../../../../../styles/text_styles.dart';
import '../../../../../../styles/themes.dart';
import '../../../../../../translation/translated_texts.dart';
import '../../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../../utils/media/get_screen_size.dart';
import '../../../logic/statistics_ctl.dart';

class WeeklyProfit extends StatefulWidget {
  const WeeklyProfit({super.key, required this.statisticsCtl});

  final StatisticsCtl statisticsCtl;

  @override
  State<WeeklyProfit> createState() => _WeeklyProfitState();
}

class _WeeklyProfitState extends State<WeeklyProfit> {
  int? _selectedBarIndex;

  @override
  void initState() {
    widget.statisticsCtl.getWeeklyProfits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);

    return Container(
      decoration: Decorations.decoration(
        color: AppColors.lightWhite,
        boxShadow: BoxShadow(
          color: Colors.black.withOpacity(0.4),
          offset: const Offset(0, 4),
          blurRadius: 3,
          spreadRadius: 1,
        ),
      ),
      width: screenSize.width * 0.4,
      height: screenSize.height / 5.5,
      padding: EdgeInsets.all(
        Paddings.customPadding(
          percentage: screenSize.height / 400,
        ),
      ),
      child: Row(
        children: [
          /// LEFT SIDE: Weekly Profit Texts
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TranslatedTexts.profit.weeklyProfit.tr,
                  style: TextStyles.black(
                    fontSize: screenSize.height / 50,
                  ),
                ),
                Obx(
                  () => Text(
                    "${PriceFormatter.formatPrice(widget.statisticsCtl.totalWeeklyProfit.value)} uzs",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.black(
                      fontSize: screenSize.height / 38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// RIGHT SIDE: Chart
          Expanded(
            flex: 2,
            child: Obx(
              () {
                if (widget.statisticsCtl.isWeeklyProfitLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return BarChart(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.bounceIn,
                  BarChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: widget.statisticsCtl.weeklyProfits
                        .asMap()
                        .map((index, profitData) {
                          double maxHeight = screenSize.height / 8;
                          double currentProfit = profitData.profit!;
                          double maxProfit = widget.statisticsCtl.weeklyProfits
                              .map((e) => e.profit!)
                              .reduce((a, b) => a > b ? a : b);

                          if (maxProfit == 0) maxProfit = 1;

                          double itemHeight =
                              (currentProfit / maxProfit) * maxHeight;

                          if (currentProfit > 0) {
                            return MapEntry(
                              index,
                              BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    fromY: 0,
                                    toY: itemHeight / 10,
                                    width: screenSize.width * 0.1 / 10,
                                    color: _selectedBarIndex == index
                                        ? Colors.orange
                                        : Colors.green,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return MapEntry(
                              index,
                              BarChartGroupData(
                                x: index,
                                barsSpace: 25,
                                barRods: [
                                  BarChartRodData(
                                    fromY: 0,
                                    toY: 1,
                                    width: screenSize.width * 0.1 / 10,
                                    color: Colors.red.shade100,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ],
                              ),
                            );
                          }
                        })
                        .values
                        .toList(),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipMargin: -40,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${PriceFormatter.formatPrice(widget.statisticsCtl.weeklyProfits[groupIndex].profit!)} uzs ',
                            const TextStyle(color: Colors.white),
                            children: [
                              TextSpan(
                                text: widget.statisticsCtl
                                    .weeklyProfits[groupIndex].day,
                              )
                            ],
                          );
                        },
                      ),
                      touchCallback:
                          (FlTouchEvent event, BarTouchResponse? response) {
                        if (event is FlTapUpEvent &&
                            response != null &&
                            response.spot != null) {
                          setState(() {
                            _selectedBarIndex =
                                response.spot!.touchedBarGroupIndex;
                          });
                        }
                      },
                      handleBuiltInTouches: true,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
