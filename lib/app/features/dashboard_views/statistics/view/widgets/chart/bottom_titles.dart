import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/formatter_functions/formatter_date.dart';
import '../../../models/daily_sales_rate.dart';

class BottomTitles extends StatefulWidget {
  const BottomTitles({
    super.key,
    required this.value,
    required this.meta,
    required this.statistics,
  });
  final double value;
  final TitleMeta meta;
  final List<DailySaleRate> statistics;

  @override
  State<BottomTitles> createState() => _BottomTitlesState();
}

class _BottomTitlesState extends State<BottomTitles> {
  @override
  Widget build(BuildContext context) {
    int index = widget.value.toInt();
    if (index < 0 || index >= widget.statistics.length) return Container();

    // Extract the date from the list
    String date = formatDate(widget.statistics[index].date.toString());
    return SideTitleWidget(
      meta: widget.meta,
      space: 10,
      child: Text(
        date, // Display the day part of the date
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
