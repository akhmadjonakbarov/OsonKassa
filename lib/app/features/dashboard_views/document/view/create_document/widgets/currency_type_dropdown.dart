import 'package:flutter/material.dart';

import '../../../../../../core/enums/currency_type.dart';
import '../../../../../../styles/text_styles.dart';

class CurrencyTypeDropdown extends StatefulWidget {
  final CurrencyType incomeCurrency;
  final CurrencyType sellingCurrency;
  final Function(CurrencyType sellingCurrency) onSelectSellingCurrency;
  final Function(CurrencyType incomeCurrency) onSelectIncomeCurrency;

  const CurrencyTypeDropdown(
      {super.key,
      required this.incomeCurrency,
      required this.sellingCurrency,
      required this.onSelectSellingCurrency,
      required this.onSelectIncomeCurrency});

  @override
  State<CurrencyTypeDropdown> createState() => _CurrencyTypeDropdownState();
}

class _CurrencyTypeDropdownState extends State<CurrencyTypeDropdown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Kiruvchi Valyuta',
                  style:
                      textStyleBlack18.copyWith(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  value:
                      widget.incomeCurrency == CurrencyType.usd ? 'USD' : 'UZS',
                  items: ['USD', 'UZS'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: textStyleBlack18),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      final incomeCurrency = newValue == 'USD'
                          ? CurrencyType.usd
                          : CurrencyType.uzs;
                      widget.onSelectIncomeCurrency(incomeCurrency);
                    });
                  },
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  underline: SizedBox(), // Remove the default underline
                ),
              ),
            ],
          ),
        ),

        // Selling Currency Dropdown with styling
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Chiquvchi Valyuta',
                  style:
                      textStyleBlack18.copyWith(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  value: widget.sellingCurrency == CurrencyType.usd
                      ? 'USD'
                      : 'UZS',
                  items: ['USD', 'UZS'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: textStyleBlack18),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      final sellingCurrency = newValue == 'USD'
                          ? CurrencyType.usd
                          : CurrencyType.uzs;
                      widget.onSelectSellingCurrency(sellingCurrency);
                    });
                  },
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  underline: SizedBox(), // Remove the default underline
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
