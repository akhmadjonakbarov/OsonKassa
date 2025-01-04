import 'package:osonkassa/app/styles/container_decoration.dart';
import 'package:flutter/material.dart';

import '../../../styles/text_styles.dart';
import '../../../utils/media/get_screen_size.dart';

class Loading extends StatelessWidget {
  final bool hasPadding;
  const Loading({super.key, this.hasPadding = true});

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    return Container(
      decoration: containerDecoration,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Yangilanmoqda...",
            style: textStyleBlack18,
          )
        ],
      ),
    );
  }
}
