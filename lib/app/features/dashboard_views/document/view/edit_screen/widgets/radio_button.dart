import 'package:flutter/material.dart';

import '../../../../../../styles/text_styles.dart';
import '../edit_product_doc_item_screen.dart';

class CustomRadioButton extends StatefulWidget {
  final String label;
  final CurrencyType currencyType;
  final CurrencyType value;
  final Function(CurrencyType) onChanged;
  const CustomRadioButton({
    super.key,
    required this.label,
    required this.value,
    required this.currencyType,
    required this.onChanged,
  });

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.label,
          style: textStyleBlack18Bold,
        ),
        Radio<CurrencyType>(
          value: widget.value,
          groupValue: widget.currencyType,
          onChanged: (CurrencyType? value) {
            widget.onChanged(value!);
          },
        ),
      ],
    );
  }
}
