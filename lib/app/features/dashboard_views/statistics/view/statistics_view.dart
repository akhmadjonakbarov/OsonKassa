import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:osonkassa/app/features/dashboard_views/statistics/view/widgets/chart/bottom_titles.dart';
import 'package:osonkassa/app/features/dashboard_views/statistics/view/widgets/profit_card_info.dart';
import 'package:osonkassa/app/styles/app_colors.dart';
import 'package:osonkassa/app/styles/text_styles.dart';
import 'package:osonkassa/app/styles/themes.dart';
import 'package:osonkassa/app/utils/media/get_screen_size.dart';

import '../../../../styles/chart_colors.dart';
import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/texts/display_texts.dart';

import '../logic/statistics_ctl.dart';
import '../models/daily_total_selling_price.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key, required this.staticticsCtl});

  final StatisticsCtl staticticsCtl;

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  @override
  void initState() {
    super.initState();
  }

  void fetchData() {
    widget.staticticsCtl.fetchStatistics();
  }

  bool isLoading = true;

  void loadingChanged() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  final ScrollController _scrollController = ScrollController();
  List<DailyTotalSellingPrice> dailyTotalSellingPrices = [
    DailyTotalSellingPrice(
      date: DateTime(2025, 1, 1), // Example date: January 1, 2025
      price: 150.0,
      profit: 50.0,
    ),
    DailyTotalSellingPrice(
      date: DateTime(2025, 1, 2), // Example date: January 2, 2025
      price: 200.0,
      profit: 70.0,
    ),
    DailyTotalSellingPrice(
      date: DateTime(2025, 1, 3), // Example date: January 3, 2025
      price: 180.0,
      profit: 60.0,
    ),
    DailyTotalSellingPrice(
      date: DateTime(2025, 1, 4), // Example date: January 4, 2025
      price: 220.0,
      profit: 80.0,
    ),
    DailyTotalSellingPrice(
      date: DateTime(2025, 1, 5), // Example date: January 5, 2025
      price: 170.0,
      profit: 55.0,
    ),
    DailyTotalSellingPrice(
      date: DateTime(2025, 1, 6), // Example date: January 6, 2025
      price: 210.0,
      profit: 75.0,
    ),
    DailyTotalSellingPrice(
      date: DateTime(2025, 1, 7), // Example date: January 7, 2025
      price: 190.0,
      profit: 65.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    loadingChanged();
    final screenSize = getScreenSize(context);
    return ListView(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  right: Paddings.padding8 * screenSize.width * 0.01 / 4),
              width: screenSize.width * 0.1,
              height: screenSize.height / 5,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius:
                    BorderRadius.circular(BorderRadiuses.borderRadius16),
              ),
            ),
            ProfitCardInfo(screenSize: screenSize),
            ProfitCardInfo(
              screenSize: screenSize,
              isProfit: true,
            ),
            Container(
              decoration: Decorations.decoration(
                color: AppColors.lightWhite,
                boxShadow: BoxShadow(
                  color: Colors.black
                      .withOpacity(0.4), // Shadow color with opacity
                  offset: const Offset(0, 4), // Horizontal and vertical offset
                  blurRadius: 3, // How much the shadow should blur
                  spreadRadius: 1, // How much the shadow should spread
                ),
              ),
              width: screenSize.width * 0.3,
              height: screenSize.height / 5,
              padding: EdgeInsets.all(
                Paddings.customPadding(
                  percentage: screenSize.height / 400,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Profits",
                            style: TextStyles.black(
                                fontSize: screenSize.height / 50),
                          ),
                          Text(
                            "Last week",
                            style: TextStyles.black(
                                fontSize: screenSize.height / 65,
                                opacity: 0.6,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$4.546",
                            style: TextStyles.black(
                                fontSize: screenSize.height / 35,
                                fontWeight: FontWeight.w600),
                          ),
                          const PercentageDisplay(
                            colorBg: AppColors.lightGreen,
                            colorText: AppColors.green,
                            text: "+15.2%",
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: screenSize.height / 5,
                    // Overall height of the ListView
                    width: screenSize.width * 0.18,
                    // Width of the ListView
                    child: ListView.separated(
                      controller: _scrollController,
                      separatorBuilder: (context, index) => SizedBox(
                        width: screenSize.width * 0.1 / 25,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: Paddings.padding8),
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        // Dynamically adjust the height based on screen size or any other condition
                        double minHeight = 30.0; // Minimum height
                        double maxHeight =
                            screenSize.height / 4; // Maximum height
                        double itemHeight = minHeight +
                            Random()
                                .nextInt((maxHeight - minHeight).toInt())
                                .toDouble();

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    width: screenSize.width * 0.1 / 12,
                                    height: maxHeight,
                                    decoration: Decorations.decoration(
                                        color: AppColors.lightGreen),
                                  ),
                                  Container(
                                    width: screenSize.width * 0.1 / 12,
                                    height: itemHeight,
                                    decoration: Decorations.decoration(
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                            const Text("Index")
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        if (isLoading)
          Container(
            margin: EdgeInsets.symmetric(
              vertical: Paddings.customPadding(
                percentage: screenSize.height / 350,
              ),
            ),
            height: screenSize.height * 0.6,
            decoration: Decorations.decoration(
              boxShadow: BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: const Offset(0, 4),
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        else
          Container(
            margin: EdgeInsets.symmetric(
              vertical: Paddings.customPadding(
                percentage: screenSize.height / 350,
              ),
            ),
            height: screenSize.height * 0.65,
            decoration: Decorations.decoration(
              boxShadow: BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: const Offset(0, 4),
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ),
            child: ChartDataExample(reports: dailyTotalSellingPrices),
          )
      ],
    );
  }
}

class ChartDataExample extends StatefulWidget {
  final List<DailyTotalSellingPrice> reports;

  const ChartDataExample({
    super.key,
    required this.reports,
  });

  @override
  State<ChartDataExample> createState() => _ChartDataExampleState();
}

class _ChartDataExampleState extends State<ChartDataExample> {
  final Color leftBarColor = ChartColors.contentColorYellow;

  final Color rightBarColor = ChartColors.contentColorGreen;

  final Color avgColor = ChartColors.contentColorOrange.avg(
    ChartColors.contentColorRed,
  );

  @override
  Widget build(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    List<BarChartGroupData> barGroups = [];
    if (widget.reports.isNotEmpty) {
      for (int i = 0; i < widget.reports.length; i++) {
        final barGroup = makeGroupData(
          i,
          widget.reports[i].price, // Scaling the price
          widget.reports[i].profit, // Scaling the price
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
                // ShowReportOfPrice(
                //   screenSize: screenSize,
                //   widget: widget,
                // ),
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
                  maxY: 10000,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) =>
                            BottomTitles(
                          value: value,
                          meta: meta,
                          statistics: widget.reports,
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
                                    'Savdo: \n ${formatUZSNumber(widget.reports[groupIndex].price, isAddWord: false)}',
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
                                    'Foyda: \n ${formatUZSNumber(widget.reports[groupIndex].profit, isAddWord: false)}',
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
