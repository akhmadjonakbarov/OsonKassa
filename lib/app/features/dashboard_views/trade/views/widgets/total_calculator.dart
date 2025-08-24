import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../styles/text_styles.dart';
import '../../../../../utils/formatter_functions/formatter_currency.dart';
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
              : constraints.maxHeight * 0.18,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${'total_products'.tr}:",
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
                    "${'total_price'.tr}:",
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
              InkWell(
                onTap: () {
                  tradeCtl.editTotalDiscount();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${'discount'.tr}:",
                      style: textStyleBlack18Bold.copyWith(color: Colors.white),
                    ),
                    Text(
                      PriceFomatter.formatPrice(tradeCtl.discount.value),
                      style: textStyleBlack18Bold.copyWith(
                          color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              if (tradeCtl.discount.value > 0)
                InkWell(
                  onTap: () {
                    tradeCtl.editTotalDiscount();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${'discount_price'.tr}:",
                        style:
                            textStyleBlack18Bold.copyWith(color: Colors.white),
                      ),
                      Text(
                        PriceFomatter.formatPrice(tradeCtl.discountPrice.value),
                        style: textStyleBlack18Bold.copyWith(
                            color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
