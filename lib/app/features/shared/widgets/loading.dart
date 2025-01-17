import '../../../styles/container_decoration.dart';
import 'package:flutter/material.dart';

import '../../../styles/text_styles.dart';

class Loading extends StatelessWidget {
  final bool hasPadding;
  const Loading({super.key, this.hasPadding = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerDecoration,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
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
