import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final Function()? onClick;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;

  const PrimaryButton({
    super.key,
    this.backgroundColor,
    this.onClick,
    this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Material(
        borderRadius: borderRadius,
        color: backgroundColor,
        child: InkWell(
          onTap: onClick,
          borderRadius: borderRadius,
          child: Center(child: child),
        ),
      ),
    );
  }
}
