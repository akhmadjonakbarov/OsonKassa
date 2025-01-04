import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

BarChartGroupData barChartItem(
    {required int index,
    required double value,
    required LinearGradient gradient}) {
  return BarChartGroupData(
    x: index,
    barRods: [
      BarChartRodData(
        width: 85,
        toY: value,
        gradient: gradient,
      )
    ],
    showingTooltipIndicators: [0],
  );
}
