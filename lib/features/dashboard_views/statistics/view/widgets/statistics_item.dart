// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../styles/text_styles.dart';

class StatisticsItem extends StatelessWidget {
  final String icon;
  final String text;
  final TextStyle? style;
  final String subText;
  final Color backgroundColor;
  final Function() onClick;

  const StatisticsItem({
    super.key,
    required this.icon,
    required this.text,
    required this.subText,
    required this.backgroundColor,
    required this.onClick,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Ink(
      child: InkWell(
        onTap: onClick,
        child: Row(
          children: [
            CircleAvatar(
              maxRadius: screenSize.height * 0.035,
              backgroundColor: backgroundColor,
              child: SvgPicture.asset(
                icon,
                height: screenSize.height * 0.04,
                width: screenSize.width * 0.045,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: style ??
                      textStyleBlack18.copyWith(
                        fontSize: 20,
                      ),
                ),
                Text(
                  subText,
                  style: textStyleBlack14.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
