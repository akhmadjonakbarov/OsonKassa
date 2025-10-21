import 'package:flutter/cupertino.dart';

import '../../../../../../styles/text_styles.dart';
import '../../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../../utils/texts/display_texts.dart';

class ShowPriceQtyOfProduct extends StatefulWidget {
  final double priceValue;
  final String incomeCurrency;
  final double quantity;

  const ShowPriceQtyOfProduct(
      {super.key,
      required this.priceValue,
      required this.quantity,
      required this.incomeCurrency});

  @override
  State<ShowPriceQtyOfProduct> createState() => _ShowPriceQtyOfProductState();
}

class _ShowPriceQtyOfProductState extends State<ShowPriceQtyOfProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "${DisplayTexts.price_of_a_product}: ${PriceFormatter.formatPrice(widget.priceValue)} ${widget.incomeCurrency.toUpperCase()}",
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
