import 'package:osonkassa/app/features/dashboard_views/currency/models/currency.dart';
import 'dart:convert';

import '../../item/models/item.dart';
import 'dart:convert';

import 'dart:convert';
import 'dart:convert';

class DocumentItem {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  Item? item;
  Currency? currency;
  double? salePrice;
  double? incomePrice;
  double? qty;

  DocumentItem({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.item,
    this.currency,
    this.salePrice,
    this.incomePrice,
    this.qty,
  });

  DocumentItem copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Item? item,
    Currency? currency,
    double? salePrice,
    double? incomePrice,
    double? qty,
  }) =>
      DocumentItem(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        item: item ?? this.item,
        currency: currency ?? this.currency,
        salePrice: salePrice ?? this.salePrice,
        incomePrice: incomePrice ?? this.incomePrice,
        qty: qty ?? this.qty,
      );

  factory DocumentItem.fromRawJson(String str) =>
      DocumentItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DocumentItem.fromJson(Map<String, dynamic> json) => DocumentItem(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
        salePrice: json["sale_price"]?.toDouble(),
        incomePrice: json["income_price"]?.toDouble(),
        qty: json["qty"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "item": item?.toJson(),
        "currency": currency?.toJson(),
        "sale_price": salePrice,
        "income_price": incomePrice,
        "qty": qty,
      };
}

class Currency {
  int? id;
  double? value;
  DateTime? createdAt;
  DateTime? updatedAt;

  Currency({
    this.id,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  Currency copyWith({
    int? id,
    double? value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Currency(
        id: id ?? this.id,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Currency.fromRawJson(String str) =>
      Currency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        value: json["value"]?.toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Item {
  int? id;
  String? name;
  String? barcode;
  double? salePrice;
  double? incomePrice;
  String? currencyType;
  String? category;
  String? unit;
  dynamic company;
  DateTime? createdAt;
  DateTime? updatedAt;

  Item({
    this.id,
    this.name,
    this.barcode,
    this.salePrice,
    this.incomePrice,
    this.currencyType,
    this.category,
    this.unit,
    this.company,
    this.createdAt,
    this.updatedAt,
  });

  Item copyWith({
    int? id,
    String? name,
    String? barcode,
    double? salePrice,
    double? incomePrice,
    String? currencyType,
    String? category,
    String? unit,
    dynamic company,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Item(
        id: id ?? this.id,
        name: name ?? this.name,
        barcode: barcode ?? this.barcode,
        salePrice: salePrice ?? this.salePrice,
        incomePrice: incomePrice ?? this.incomePrice,
        currencyType: currencyType ?? this.currencyType,
        category: category ?? this.category,
        unit: unit ?? this.unit,
        company: company ?? this.company,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        barcode: json["barcode"],
        salePrice: json["sale_price"]?.toDouble(),
        incomePrice: json["income_price"]?.toDouble(),
        currencyType: json["currency_type"],
        category: json["category"],
        unit: json["unit"],
        company: json["company"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "barcode": barcode,
        "sale_price": salePrice,
        "income_price": incomePrice,
        "currency_type": currencyType,
        "category": category,
        "unit": unit,
        "company": company,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  Map<String, dynamic> toMapForCreate({
    required String name,
    required String barcode,
    required double salePrice,
    required double incomePrice,
    required String currencyType,
    required int categoryid,
    required int unitId,
  }) {
    return {
      'name': name,
      'barcode': barcode,
      'sale_price': salePrice,
      'income_price': incomePrice,
      'currency_type': currencyType,
      'category_id': categoryid,
      'unit_id': unitId,
    };
  }
}
