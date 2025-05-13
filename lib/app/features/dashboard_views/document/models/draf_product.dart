// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:osonkassa/app/features/dashboard_views/currency/models/currency.dart';

import '../../item/models/item.dart';

class DraftProduct {
  final int id;
  final double qty;
  final double incomePrice;
  final String incomeCurrency;
  final double sellingPercentage;
  final double sellingPrice;
  final String sellingCurrency;
  final int currencyId;
  final String unit;
  final int itemId;
  final String itemName;
  DraftProduct({
    required this.id,
    required this.qty,
    required this.incomePrice,
    required this.incomeCurrency,
    required this.sellingPercentage,
    required this.sellingPrice,
    required this.sellingCurrency,
    required this.currencyId,
    required this.unit,
    required this.itemId,
    required this.itemName,
  });

  DraftProduct copyWith({
    int? id,
    double? qty,
    double? incomePrice,
    String? incomeCurrency,
    double? sellingPercentage,
    double? sellingPrice,
    String? sellingCurrency,
    int? currencyId,
    String? unit,
    int? itemId,
    String? itemName,
  }) {
    return DraftProduct(
      id: id ?? this.id,
      qty: qty ?? this.qty,
      incomePrice: incomePrice ?? this.incomePrice,
      incomeCurrency: incomeCurrency ?? this.incomeCurrency,
      sellingPercentage: sellingPercentage ?? this.sellingPercentage,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      sellingCurrency: sellingCurrency ?? this.sellingCurrency,
      currencyId: currencyId ?? this.currencyId,
      unit: unit ?? this.unit,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'qty': qty,
      'income_price': incomePrice,
      'income_currency': incomeCurrency,
      'selling_percentage': sellingPercentage,
      'selling_price': sellingPrice,
      'selling_currency': sellingCurrency,
      'currency_id': currencyId,
      'item_id': itemId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'DraftProduct(id: $id, qty: $qty, incomePrice: $incomePrice, incomeCurrency: $incomeCurrency, sellingPercentage: $sellingPercentage, sellingPrice: $sellingPrice, sellingCurrency: $sellingCurrency, currencyId: $currencyId, unit: $unit, itemId: $itemId, itemName: $itemName)';
  }
}
