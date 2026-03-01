import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../styles/text_styles.dart';
import '../../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../shared/widgets/header_title.dart';

class HeaderCurrency extends StatelessWidget {
  const HeaderCurrency({
    super.key,
    required this.currencyValue,
    required this.constraints,
  });

  final double currencyValue;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: constraints.maxWidth * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeaderTitle(title: "add new document".tr),
              if (currencyValue > 0)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    "1\$ = ${formatUZSNumber(currencyValue)}",
                    style: textStyleWhite18W800.copyWith(
                        fontSize: 22, color: Colors.white),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
