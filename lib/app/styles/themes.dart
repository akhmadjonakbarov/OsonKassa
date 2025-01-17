import 'package:flutter/material.dart';

import 'app_colors.dart';

class BorderRadiuses {
  static const double borderRadius4 = 4;
  static const double borderRadius8 = 8;
  static const double borderRadius12 = 12;
  static const double borderRadius16 = 16;
  static const double borderRadius24 = 24;
  static const double borderRadius32 = 32;
  static const double borderRadius40 = 40;
  static const double borderRadius48 = 48;
}

class Paddings {
  static const double padding8 = 8;
  static const double padding12 = 12;
  static const double padding14 = 14;
  static const double padding16 = 16;
  static const double padding24 = 24;
  static const double padding32 = 32;

  static double customPadding(
      {double padding = padding8, required double percentage}) {
    return padding * percentage;
  }
}

class Decorations {
  static BoxDecoration decoration({
    Color color = AppColors.lightWhite,
    double borderRadius = BorderRadiuses.borderRadius16,
    BoxShadow? boxShadow,
    Border? border,
    Gradient? gradient,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: boxShadow != null ? [boxShadow] : [],
      border: border ?? Border.all(color: Colors.grey),
      gradient: gradient,
    );
  }
}

class BoxShadows {
  static const opacity = 0.4;
  static const BoxShadow shadow1 = BoxShadow(
    color: Colors.black,
    offset: Offset(0, 2),
    blurRadius: 4,
  );
  static BoxShadow custom = BoxShadow(
    color: Colors.black.withOpacity(opacity),
    offset: const Offset(0, 4),
    blurRadius: 3,
    spreadRadius: 1,
  );
}
