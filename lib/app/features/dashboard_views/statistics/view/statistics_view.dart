import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/chart/weekly_profit.dart';
import '../../../../translation/translated_texts.dart';

import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../logic/statistics_ctl.dart';
import 'widgets/chart/bottom_titles.dart';
import 'widgets/profit_card_info.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key, required this.statisticsCtl});

  final StatisticsCtl statisticsCtl;

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        RefreshIndicator(
            onRefresh: statisticsCtl.loadAllStatistics,
            child: Row(
              children: [
                Expanded(child: ProfitCardInfo(screenSize: screenSize)),
                Expanded(
                  child: ProfitCardInfo(screenSize: screenSize, isProfit: true),
                ),
                Expanded(
                  child: WeeklyProfit(statisticsCtl: statisticsCtl),
                ),
              ],
            )),
        const SizedBox(height: 16),
        // ChartDataExample(statisticsCtl: statisticsCtl),
      ],
    );
  }
}

class ChartDataExample extends StatelessWidget {
  final StatisticsCtl statisticsCtl;

  const ChartDataExample({
    super.key,
    required this.statisticsCtl,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Obx(
        () {
          if (statisticsCtl.isChartReady.value) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        TranslatedTexts.statistics.weeklySalesStatistics.tr,
                        style: const TextStyle(fontSize: 22),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        maxY: 20000,
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) =>
                                  BottomTitles(
                                value: value,
                                meta: meta,
                                statistics: statisticsCtl.dailySalesRates,
                              ),
                              reservedSize: 35,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 80,
                              interval: 1,
                              getTitlesWidget: leftTitles,
                            ),
                          ),
                        ),
                        barGroups: statisticsCtl.barGroups,
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: true),
                        barTouchData: BarTouchData(
                          enabled: true, // Enable touch interaction
                          touchTooltipData: BarTouchTooltipData(
                            tooltipPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 50,
                            ),
                            // Reduce padding for better fit
                            tooltipMargin: 8,
                            // Adjust margin for better positioning
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                "",
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 1, // Customize font size and weight
                                ),
                                children: [
                                  if (rodIndex == 0)
                                    TextSpan(
                                      text:
                                          'Savdo: \n ${PriceFomatter.formatPrice(
                                        statisticsCtl
                                            .dailySalesRates[groupIndex].sales!,
                                      )}',
                                      // Display price
                                      style: const TextStyle(
                                        color: Colors.yellow,
                                        // Custom color for the price
                                        fontSize: 20,
                                        // Adjust font size for price
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  else
                                    TextSpan(
                                      text:
                                          'Foyda: \n ${formatUZSNumber(statisticsCtl.dailySalesRates[groupIndex].profit!, isAddWord: false)}',
                                      // Display profit
                                      style: const TextStyle(
                                        color: Colors.greenAccent,
                                        // Custom color for profit
                                        fontSize: 20,

                                        // Adjust font size for profit
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    Map<double, String> leftTitlesMap = {};

    for (var i = 0; i <= 20; i++) {
      leftTitlesMap[i.toDouble() * 1000] = '${i}K UZS';
    }

    String? text = leftTitlesMap[value];

    // Display text only if it's a mapped value; otherwise, return an empty container
    if (text == null) {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8, // Add some spacing for better readability
      child: Text(text, style: style),
    );
  }
}
