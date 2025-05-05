import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../styles/text_styles.dart';
import '../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../utils/texts/display_texts.dart';
import '../../logic/trade_ctl.dart';

class TotalCalculate extends StatelessWidget {
  final TradeCtl tradeCtl;
  final BoxConstraints constraints;

  const TotalCalculate({
    super.key,
    required this.tradeCtl,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          height: MediaQuery.sizeOf(context).width <= 1370
              ? constraints.maxHeight * 0.20
              : constraints.maxHeight * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${DisplayTexts.total_of_products}: ',
                    style: textStyleBlack18Bold.copyWith(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatUZSNumber(tradeCtl.totalSelledProductCount.value),
                        style: textStyleBlack18Bold.copyWith(
                            color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${DisplayTexts.total_of_sum}:',
                    style: textStyleBlack18Bold.copyWith(color: Colors.white),
                  ),
                  Text(
                    PriceFomatter.formatPrice(
                        tradeCtl.totalSelledProductPrice.value),
                    style: textStyleBlack18Bold.copyWith(
                        color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
