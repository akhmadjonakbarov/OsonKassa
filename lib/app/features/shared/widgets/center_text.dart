import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const CenterText({
    super.key,
    required this.text,
    this.style = const TextStyle(fontSize: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}
