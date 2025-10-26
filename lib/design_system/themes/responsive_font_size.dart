import 'package:flutter/material.dart';

extension ResponsiveFontSize on BuildContext {
  double rfs(double base, {double min = 12, double max = 28}) {
    final w = MediaQuery.sizeOf(this).width;
    final scaled = base * (w / 1366.0);
    return scaled.clamp(min, max).toDouble();
  }
}
