import 'package:flutter/cupertino.dart';

import '../../../styles/app_colors.dart';
import '../../../styles/themes.dart';
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

class CustomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;

  const CustomContainer(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(Paddings.padding8),
      this.margin,
      this.height,
      this.width,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration ??
          Decorations.decoration(
              color: AppColors.lightWhite, boxShadow: BoxShadows.custom),
      child: child,
    );
  }
}
