import 'package:flutter/material.dart';

import '../../../../../styles/app_colors.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../styles/themes.dart';

class ProfitCardInfo extends StatelessWidget {
  const ProfitCardInfo(
      {super.key, required this.screenSize, this.isProfit = false});

  final Size screenSize;
  final bool isProfit;

  @override
  Widget build(BuildContext context) {
    Color colorBg =
        isProfit ? AppColors.lightGreen : Colors.redAccent.withOpacity(0.3);
    Color colorText = isProfit ? AppColors.green : Colors.red;
    return Container(
      margin: EdgeInsets.only(
          right: Paddings.padding8 * screenSize.width * 0.01 / 4),
      padding: const EdgeInsets.symmetric(
        vertical: Paddings.padding8,
        horizontal: Paddings.padding24,
      ),
      width: screenSize.width * 0.11,
      height: screenSize.height / 5,
      decoration: Decorations.decoration(
        border: Border.all(color: Colors.grey),
        boxShadow: BoxShadow(
          color: Colors.black.withOpacity(0.4), // Shadow color with opacity
          offset: const Offset(0, 4), // Horizontal and vertical offset
          blurRadius: 3, // How much the shadow should blur
          spreadRadius: 1, // How much the shadow should spread
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: Decorations.decoration(
                color: isProfit
                    ? AppColors.lightGreen
                    : Colors.redAccent.withOpacity(0.3),
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadiuses.borderRadius16 / 3),
            padding: const EdgeInsets.all(Paddings.padding8),
            child: Icon(
              Icons.payment,
              color: colorText,
              size: screenSize.height / 35,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Profits",
                style: TextStyles.black(fontSize: screenSize.height / 50),
              ),
              Text(
                "Last week",
                style: TextStyles.black(
                    fontSize: screenSize.height / 65,
                    opacity: 0.6,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "1.25k",
                style: TextStyles.black(
                    fontSize: screenSize.height / 61,
                    opacity: 0.9,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          PercentageDisplay(
            colorBg: colorBg,
            colorText: colorText,
            text: "125%",
          ),
        ],
      ),
    );
  }
}

class PercentageDisplay extends StatelessWidget {
  final Color colorBg;
  final Color colorText;
  final String text;
  final double? borderRadius;

  const PercentageDisplay({
    Key? key,
    required this.colorBg,
    required this.colorText,
    required this.text,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: Decorations.decoration(
        color: colorBg,
        border: Border.all(color: Colors.transparent),
        borderRadius: borderRadius ?? BorderRadiuses.borderRadius16 / 3,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Paddings.padding8,
        vertical: Paddings.padding8 / 3,
      ),
      child: Text(
        text,
        style: TextStyles.style(
          fontSize: screenSize.height / 68,
          color: colorText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
