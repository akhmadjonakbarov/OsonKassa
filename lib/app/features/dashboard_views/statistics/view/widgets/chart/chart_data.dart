import '../../../../../shared/export_commons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../styles/chart_colors.dart';
import '../../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../../utils/media/get_screen_size.dart';
import '../../../../../../utils/texts/display_texts.dart';
import '../../../logic/statistics_ctl.dart';

import 'bottom_titles.dart';
import 'show_report_of_price.dart';

class ChartData extends StatefulWidget {
  final StatisticsCtl statisticsCtl;

  const ChartData({
    super.key,
    required this.statisticsCtl,
  });

  @override
  State<ChartData> createState() => _ChartDataState();
}

class _ChartDataState extends State<ChartData> {
  final Color leftBarColor = ChartColors.contentColorYellow;

  final Color rightBarColor = ChartColors.contentColorGreen;

  final Color avgColor = ChartColors.contentColorOrange.avg(
    ChartColors.contentColorRed,
  );

  @override
  void initState() {
    widget.statisticsCtl.fetchWeeklyPriceStatistics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = getScreenSize(context);

    return Obx(() {
      if (widget.statisticsCtl.isLoadingList.value) {
        return const Loading();
      } else {
        List<BarChartGroupData> barGroups = [];
        if (widget.statisticsCtl.list.isNotEmpty) {
          for (int i = 0; i < widget.statisticsCtl.list.length; i++) {
            final barGroup = makeGroupData(
              i,
              widget.statisticsCtl.list[i].price, // Scaling the price
              widget.statisticsCtl.list[i].profit, // Scaling the price
            );

            barGroups.add(barGroup);
          }
        }
        return AspectRatio(
          aspectRatio: 1.8,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      DisplayTexts.weekly_rate_of_selling,
                      style: TextStyle(fontSize: 22),
                    ),
                    ShowReportOfPrice(
                      screenSize: screenSize,
                      widget: widget,
                    ),
                    IconButton(
                      onPressed: () {
                        widget.statisticsCtl.fetchWeeklyPriceStatistics();
                      },
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
                      maxY: 10000,
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) =>
                                BottomTitles(
                              value: value,
                              meta: meta,
                              statistics: widget.statisticsCtl.list,
                            ),
                            reservedSize: 35,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 60,
                            interval: 1,
                            getTitlesWidget: leftTitles,
                          ),
                        ),
                      ),
                      barGroups: barGroups,
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
                                        'Savdo: \n ${formatUZSNumber(widget.statisticsCtl.list[groupIndex].price, isAddWord: false)}',
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
                                        'Foyda: \n ${formatUZSNumber(widget.statisticsCtl.list[groupIndex].profit, isAddWord: false)}',
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
          ),
        );
      }
    });
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    // Use a map for specific y-axis labels at regular intervals, up to 10,000 USD
    Map<double, String> leftTitlesMap = {
      0: '0 USD',
      1000: '1K USD',
      2000: '2K USD',
      3000: '3K USD',
      4000: '4K USD',
      5000: '5K USD',
      6000: '6K USD',
      7000: '7K USD',
      8000: '8K USD',
      9000: '9K USD',
      10000: '10K USD',
    };

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

  // Updated makeGroupData function to include both price and profit
  BarChartGroupData makeGroupData(int x, double price, double profit) {
    return BarChartGroupData(
      barsSpace: 10,
      x: x,
      barRods: [
        BarChartRodData(
          toY: price,
          color: leftBarColor, // For price
          width: 10,
        ),
        BarChartRodData(
          toY: profit,
          color: rightBarColor, // For profit
          width: 10,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
