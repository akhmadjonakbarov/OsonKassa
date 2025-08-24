import 'dart:convert';

import '../../currency/models/currency.dart';
import '../../item/models/item.dart';

class StoreItem {
  int? id;
  Item? item;
  Currency? currency;
  double? currencyRateValue;
  double? salePrice;
  double? incomePrice;
  double? salePercentage;
  double? qty;
  DateTime? createdAt;
  DateTime? updatedAt;

  StoreItem({
    this.id,
    this.item,
    this.currency,
    this.salePrice,
    this.incomePrice,
    this.salePercentage,
    this.qty,
    this.createdAt,
    this.updatedAt,
    this.currencyRateValue,
  });

  StoreItem copyWith({
    int? id,
    Item? item,
    Currency? currency,
    double? currencyRateValue,
    double? salePrice,
    double? incomePrice,
    double? salePercentage,
    double? qty,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      StoreItem(
        id: id ?? this.id,
        item: item ?? this.item,
        currency: currency ?? this.currency,
        currencyRateValue: currencyRateValue ?? this.currencyRateValue,
        salePrice: salePrice ?? this.salePrice,
        incomePrice: incomePrice ?? this.incomePrice,
        salePercentage: salePercentage ?? this.salePercentage,
        qty: qty ?? this.qty,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory StoreItem.fromRawJson(String str) =>
      StoreItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreItem.fromJson(Map<String, dynamic> json) => StoreItem(
        id: json["id"],
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json['currency']),
        salePrice: json["sale_price"]?.toDouble(),
        currencyRateValue: json["currency_rate_value"]?.toDouble(),
        incomePrice: json["income_price"]?.toDouble(),
        salePercentage: json["sale_percentage"]?.toDouble(),
        qty: json["qty"]?.toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item": item?.toJson(),
        "currency": currency?.toJson(),
        "currency_rate_value": currencyRateValue,
        "sale_price": salePrice,
        "income_price": incomePrice,
        "sale_percentage": salePercentage,
        "qty": qty,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  Map<String, dynamic> toSellJson() => {
        "item_id": item?.id,
        "qty": qty,
      };
}
