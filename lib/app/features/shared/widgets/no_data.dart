import 'package:flutter/material.dart';

import '../../../styles/container_decoration.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/media/get_screen_size.dart';
import '../../../utils/texts/display_texts.dart';

class NoData extends StatelessWidget {
  final bool hasPadding;
  const NoData({super.key, this.hasPadding = true});

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    return Container(
      width: double.infinity,
      decoration: containerDecoration,
      padding: hasPadding
          ? EdgeInsets.symmetric(vertical: screenSize.height * 0.3)
          : EdgeInsets.zero,
      alignment: Alignment.center,
      child: Text(
        DisplayTexts.no_data,
        style: textStyleBlack18.copyWith(fontSize: 25),
      ),
    );
  }
}
