import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../translation/translated_texts.dart';
import '../../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../logic/statistics_ctl.dart';
import 'bottom_titles.dart';

class DailySaleChart extends StatelessWidget {
  final StatisticsCtl statisticsCtl;

  const DailySaleChart({
    super.key,
    required this.statisticsCtl,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.3,
      child: Obx(
        () {
          if (statisticsCtl.isChartReady.value) {
            return AnimatedContainer(
              duration: Durations.medium1,
              curve: Curves.bounceIn,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              TranslatedTexts.statistics.salesStatistics.tr,
                              style: const TextStyle(fontSize: 22),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  DateFormat("dd-MM-yyyy")
                                      .format(DateTime.now()),
                                  style: const TextStyle(fontSize: 22),
                                ))
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            statisticsCtl.prepareChart();
                          },
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          borderData: FlBorderData(
                            show: true,
                          ),
                          maxY: 20000,
                          backgroundColor: Colors.black,
                          titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) =>
                                          BottomTitles(
                                    value: value,
                                    meta: meta,
                                    statistics: statisticsCtl.dailySalesRates,
                                  ),
                                  reservedSize: 45,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 65,
                                  interval: 5000,
                                  getTitlesWidget: (value, meta) {
                                    if (value % 1000 != 0) return Container();
                                    return Text(
                                      '${value ~/ 1000}K UZS',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              rightTitles: const AxisTitles()),
                          barGroups: statisticsCtl.barGroups,
                          barTouchData: chartItem(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  BarTouchData chartItem() {
    return BarTouchData(
      allowTouchBarBackDraw: true,
      handleBuiltInTouches: true,
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
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
                  text: 'Savdo: \n ${PriceFomatter.formatPrice(
                    statisticsCtl.dailySalesRates[groupIndex].sales!,
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
    );
  }
}
