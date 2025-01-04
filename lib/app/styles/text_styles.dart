import 'package:flutter/material.dart';

import 'colors.dart';

TextStyle textStyleBlack14 = TextStyle(
    color: textColorBlack.withOpacity(0.7),
    fontSize: 14,
    fontWeight: FontWeight.w400);
TextStyle textStyleBlack15 = TextStyle(
    color: textColorBlack.withOpacity(0.7),
    fontSize: 15,
    fontWeight: FontWeight.bold);

TextStyle textStyleGrey14 = TextStyle(color: textColorGrey, fontSize: 14);

// font size 18
TextStyle textStyleBlack18 = TextStyle(
  color: textColorBlack,
  fontSize: 18,
  fontWeight: FontWeight.w400,
);
TextStyle textStyleWhite18 =
    TextStyle(color: textColorWhite, fontSize: 18, fontWeight: FontWeight.w400);
TextStyle textStyleBlack18Bold =
    TextStyle(color: textColorBlack, fontSize: 18, fontWeight: FontWeight.bold);
TextStyle textStyleWhite18W800 =
    TextStyle(color: textColorBlack, fontSize: 18, fontWeight: FontWeight.w800);

// font size 22
TextStyle textStyleWhite20 = TextStyle(color: textColorWhite, fontSize: 20);
TextStyle textStyleBlack20 = TextStyle(color: textColorBlack, fontSize: 20);

// font size 28
TextStyle textStyleBlack28 = TextStyle(color: textColorBlack, fontSize: 28);
TextStyle textStyleWhite28 = const TextStyle(color: Colors.white, fontSize: 28);

class TextStyles {
  static TextStyle style(
      {FontWeight fontWeight = FontWeight.w400,
      double opacity = 1.0,
      Color? color,
      double fontSize = 25}) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle black(
      {FontWeight fontWeight = FontWeight.w400,
      double opacity = 1.0,
      double fontSize = 25}) {
    return TextStyle(
      color: Colors.black.withOpacity(opacity),
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle white(double fontSize,
      {FontWeight fontWeight = FontWeight.w400}) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle grey(double fontSize,
      {FontWeight fontWeight = FontWeight.w400}) {
    return TextStyle(
      color: Colors.grey,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
