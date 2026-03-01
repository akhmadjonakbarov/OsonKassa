import 'package:flutter/material.dart';
import '../../../../styles/app_colors.dart';
import '../../../../styles/themes.dart';
import 'widgets/chart/daily_sale_chart.dart';
import 'widgets/chart/weekly_profit.dart';

import '../logic/statistics_ctl.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key, required this.statisticsCtl});

  final StatisticsCtl statisticsCtl;

  @override
  Widget build(BuildContext context) {
    statisticsCtl.loadAllStatistics();

    return ListView(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RefreshIndicator(
            onRefresh: statisticsCtl.loadAllStatistics,
            child: WeeklyProfit(statisticsCtl: statisticsCtl)),
        const SizedBox(height: 16),
        Container(
          decoration: Decorations.decoration(
            color: AppColors.lightWhite,
            boxShadow: BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, 4),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ),
          child: DailySaleChart(
            statisticsCtl: statisticsCtl,
          ),
        ),
      ],
    );
  }
}
