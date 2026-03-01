import 'package:flutter/cupertino.dart';

class ButtonSizeManager {
  static double width(BuildContext context, {double width = 0.07}) {
    return MediaQuery.sizeOf(context).width * width;
  }

  static double height(BuildContext context, {double height = 0.1 / 2}) {
    return MediaQuery.of(context).size.height * height;
  }
}
