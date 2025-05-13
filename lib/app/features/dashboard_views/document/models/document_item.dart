import 'package:osonkassa/app/features/dashboard_views/currency/models/currency.dart';
import 'dart:convert';

import '../../item/models/item.dart';

class DocumentItem {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? id;
  final Item? item;
  final Currency? currency;
  final String? sellingCurrency;
  final double? sellingPrice;
  final double? sellingPercentage;
  final String? incomeCurrency;
  final double? incomePrice;
  final double? qty;

  DocumentItem({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.item,
    this.currency,
    this.sellingCurrency,
    this.sellingPrice,
    this.sellingPercentage,
    this.incomeCurrency,
    this.incomePrice,
    this.qty,
  });

  DocumentItem copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    int? id,
    Item? item,
    Currency? currency,
    String? sellingCurrency,
    double? sellingPrice,
    double? sellingPercentage,
    String? incomeCurrency,
    double? incomePrice,
    double? qty,
  }) =>
      DocumentItem(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        id: id ?? this.id,
        item: item ?? this.item,
        currency: currency ?? this.currency,
        sellingCurrency: sellingCurrency ?? this.sellingCurrency,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        sellingPercentage: sellingPercentage ?? this.sellingPercentage,
        incomeCurrency: incomeCurrency ?? this.incomeCurrency,
        incomePrice: incomePrice ?? this.incomePrice,
        qty: qty ?? this.qty,
      );

  factory DocumentItem.fromRawJson(String str) =>
      DocumentItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DocumentItem.fromJson(Map<String, dynamic> json) => DocumentItem(
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        id: json["id"],
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
        sellingCurrency: json["selling_currency"],
        sellingPrice: json["selling_price"]?.toDouble(),
        sellingPercentage: json["selling_percentage"]?.toDouble(),
        incomeCurrency: json["income_currency"],
        incomePrice: json["income_price"]?.toDouble(),
        qty: json["qty"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
        "item": item?.toJson(),
        "currency": currency?.toJson(),
        "selling_currency": sellingCurrency,
        "selling_price": sellingPrice,
        "selling_percentage": sellingPercentage,
        "income_currency": incomeCurrency,
        "income_price": incomePrice,
        "qty": qty,
      };
}
