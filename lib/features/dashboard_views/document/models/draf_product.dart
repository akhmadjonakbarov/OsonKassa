// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DraftProduct {
  final int id;
  final double qty;
  final double incomePrice;
  final double sellingPercentage;
  final double sellingPrice;
  final String? type;
  final String unit;
  final int itemId;
  final String itemName;

  DraftProduct(
      {required this.id,
      required this.qty,
      required this.incomePrice,
      required this.sellingPercentage,
      required this.sellingPrice,
      required this.unit,
      required this.itemId,
      required this.itemName,
      this.type});

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
    String? type,
  }) {
    return DraftProduct(
        id: id ?? this.id,
        qty: qty ?? this.qty,
        incomePrice: incomePrice ?? this.incomePrice,
        sellingPercentage: sellingPercentage ?? this.sellingPercentage,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        unit: unit ?? this.unit,
        itemId: itemId ?? this.itemId,
        itemName: itemName ?? this.itemName,
        type: type ?? this.type);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'qty': qty,
      'income_price': incomePrice,
      'selling_percentage': sellingPercentage,
      'selling_price': sellingPrice,
      'item_id': itemId,
      'item_type': type,
      'item_name': itemName,
      'unit': unit,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'DraftProduct(id: $id, qty: $qty, incomePrice: $incomePrice, sellingPercentage: $sellingPercentage, sellingPrice: $sellingPrice, unit: $unit, itemId: $itemId, itemName: $itemName)';
  }
}
