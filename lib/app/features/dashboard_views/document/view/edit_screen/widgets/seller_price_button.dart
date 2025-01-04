import 'package:flutter/material.dart';

import '../../../../../../styles/text_styles.dart';

class SellerPriceButton extends StatelessWidget {
  final Function() onClick;
  final String label;

  const SellerPriceButton(
      {super.key, required this.label, required this.onClick});

  @override
  Widget build(BuildContext context) {
    Color color;
    if (label.startsWith("5")) {
      color = const Color.fromARGB(255, 78, 127, 43);
    } else if (label.contains("10")) {
      color = Colors.green;
    } else if (label.contains("15")) {
      color = const Color.fromARGB(255, 207, 73, 10);
    } else {
      color = Colors.red;
    }

    return TextButton(
      style: TextButton.styleFrom(backgroundColor: color),
      onPressed: onClick,
      child: Text(
        label,
        style: textStyleBlack14.copyWith(color: Colors.white),
      ),
    );
  }
}
