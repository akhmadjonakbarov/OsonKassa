import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../styles/text_styles.dart';
import '../../../../../../utils/formatter_functions/formatter_currency.dart';
import 'chart_data.dart';

class ShowReportOfPrice extends StatelessWidget {
  const ShowReportOfPrice({
    super.key,
    required this.screenSize,
    required this.widget,
  });

  final Size screenSize;
  final ChartData widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width * 0.35,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Savdo: ${formatUZSNumber(widget.statisticsCtl.weekly_selling_rate.value)} USD",
                  style: textStyleBlack20.copyWith(
                      fontSize: 24, color: Colors.yellow),
                ),
              ),
            ),
            Material(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Foyda: ${formatUZSNumber(widget.statisticsCtl.weekly_total_profit.value)} USD",
                  style: textStyleBlack20.copyWith(
                    fontSize: 24,
                    color: Colors.greenAccent,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
