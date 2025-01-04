import 'package:flutter/cupertino.dart';

import '../../../../../../styles/text_styles.dart';
import '../../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../../utils/texts/display_texts.dart';

class ShowPriceQtyOfProduct extends StatefulWidget {
  final bool isUSD;
  final double priceValue;
  final double quantity;

  const ShowPriceQtyOfProduct({
    super.key,
    required this.isUSD,
    required this.priceValue,
    required this.quantity,
  });

  @override
  State<ShowPriceQtyOfProduct> createState() => _ShowPriceQtyOfProductState();
}

class _ShowPriceQtyOfProductState extends State<ShowPriceQtyOfProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "${DisplayTexts.price_of_a_product}: ${formatPriceAtUZS(widget.priceValue, isUSD: widget.isUSD)}",
            style: textStyleBlack14.copyWith(fontSize: 16),
          ),
          Text(
            "${DisplayTexts.qty_of_product}: ${widget.quantity}",
            style: textStyleBlack14.copyWith(fontSize: 16),
          )
        ],
      ),
    );
  }
}
