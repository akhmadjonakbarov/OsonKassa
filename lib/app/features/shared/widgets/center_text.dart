import 'package:flutter/material.dart';
import 'package:osonkassa/app/utils/media/get_screen_size.dart';

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
    final screenSize = getScreenSize(context);
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: style.copyWith(fontSize: screenSize.width <= 1370 ? 14 : 16),
      ),
    );
  }
}
