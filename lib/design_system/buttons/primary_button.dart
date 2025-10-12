import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final Function()? onClick;
  final BorderRadius? borderRadius;

  const PrimaryButton({
    super.key,
    this.backgroundColor,
    this.onClick,
    this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        borderRadius: borderRadius,
        color: backgroundColor,
        child: InkWell(
          onTap: onClick,
          borderRadius: borderRadius,
          child: child,
        ),
      ),
    );
  }
}
