import '../../../../../utils/media/get_screen_size.dart';
import 'package:flutter/material.dart';

import '../../../../../styles/text_styles.dart';

class CardButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Function() onClick;

  const CardButton({
    super.key,
    required this.label,
    required this.onClick,
    this.backgroundColor = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    return Material(
      color: backgroundColor, // Background color
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        // This is important for the ripple effect to follow the shape
        onTap: onClick,
        child: Container(
          alignment: Alignment.center, // To center the text
          child: Text(
            label,
            style: screenSize.width <= 1370
                ? textStyleWhite18.copyWith(fontWeight: FontWeight.w600)
                : textStyleBlack28.copyWith(
                    color: Colors.white, // Text color
                    fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
