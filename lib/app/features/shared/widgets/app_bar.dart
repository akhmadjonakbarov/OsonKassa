import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/colors.dart';
import '../../../styles/text_styles.dart';

class TopBar extends StatelessWidget {
  final String text;
  const TopBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Material(
              color: primary,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                borderRadius: BorderRadius.circular(10),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.05,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(10),
              ),
              width: constraints.maxWidth * 0.9,
              child: Text(
                text,
                style: textStyleBlack18Bold.copyWith(
                    fontWeight: FontWeight.w800, fontSize: 25),
              ),
            ),
          ],
        );
      },
    );
  }
}
