import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/logic/order_controller.dart';
import 'package:osonkassa/design_system/themes/responsive_font_size.dart';
import 'package:osonkassa/design_system/themes/text_styles.dart';

import '../../../../../styles/text_styles.dart';
import '../../../../../utils/formatter_functions/formatter_currency.dart';

class TotalCalculate extends StatelessWidget {
  final BoxConstraints constraints;

  TotalCalculate({
    super.key,
    required this.constraints,
  });

  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final selectedOrder = orderController.selectedOrder.value;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${'total_price'.tr}:",
                    style: context.titleMedium.copyWith(
                      fontSize: context.rfs(15, min: 13, max: 19),
                    ),
                  ),
                  Text(
                    PriceFormatter.formatPrice(selectedOrder!.totalPrice!),
                    style: textStyleBlack18Bold.copyWith(fontSize: 20),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  orderController.editTotalDiscount();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${'discount'.tr}:",
                      style: context.titleMedium.copyWith(
                        fontSize: context.rfs(15, min: 13, max: 19),
                      ),
                    ),
                    Text(
                      PriceFormatter.formatPrice(selectedOrder.discount!),
                      style: textStyleBlack18Bold.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
              if (selectedOrder.discountPrice! > 0)
                InkWell(
                  onTap: () {
                    orderController.editTotalDiscount();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${'discount_price'.tr}:",
                        style: context.titleMedium.copyWith(
                          fontSize: context.rfs(15, min: 13, max: 19),
                        ),
                      ),
                      Text(
                        PriceFormatter.formatPrice(
                            selectedOrder.discountPrice!),
                        style: textStyleBlack18Bold.copyWith(fontSize: 20),
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
