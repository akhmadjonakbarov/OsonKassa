import 'package:flutter/cupertino.dart';

import '../../../utils/media/paddings.dart';

class AppContainer extends StatelessWidget {
  final BoxDecoration decoration;
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const AppContainer({
    super.key,
    this.decoration = const BoxDecoration(),
    required this.child,
    this.width,
    this.height,
    this.padding = paddingSH16,
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width ?? double.infinity,
      height: height,
      decoration: decoration,
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: child,
        ),
      ),
    );
  }
}
