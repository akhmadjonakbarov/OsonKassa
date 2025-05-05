// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:osonkassa/app/features/dashboard_views/currency/models/models.dart';
import 'package:osonkassa/app/features/dashboard_views/document/models/document_model.dart';
import 'package:osonkassa/app/features/dashboard_views/item/models/item.dart';

// ignore_for_file: unnecessary_this

import 'dart:convert';
import 'dart:convert';

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

class Currency {
  final int? id;
  final double? value;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
  final int? id;
  final String? name;
  final String? barcode;
  final String? category;
  final String? unit;
  final String? company;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Item({
    this.id,
    this.name,
    this.barcode,
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
    String? category,
    String? unit,
    String? company,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Item(
        id: id ?? this.id,
        name: name ?? this.name,
        barcode: barcode ?? this.barcode,
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
        "category": category,
        "unit": unit,
        "company": company,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class DocItemModelForItemModel {
  int id;
  double qty;
  double qty_kg;
  double income_price;
  double income_price_usd;
  double selling_price;
  double selling_percentage;
  CurrencyTypeModel currency_type;
  CurrencyModel? currency;

  DocItemModelForItemModel({
    required this.id,
    required this.qty,
    required this.qty_kg,
    required this.income_price,
    required this.income_price_usd,
    required this.selling_price,
    required this.selling_percentage,
    required this.currency_type,
    this.currency,
  });

  DocItemModelForItemModel copyWith({
    int? id,
    double? qty,
    double? qty_kg,
    double? income_price,
    double? income_price_usd,
    double? selling_price,
    double? selling_percentage,
    bool? can_be_cheaper,
    CurrencyTypeModel? currency_type,
    CurrencyModel? currency,
  }) {
    return DocItemModelForItemModel(
      id: id ?? this.id,
      qty: qty ?? this.qty,
      currency_type: currency_type ?? this.currency_type,
      qty_kg: qty_kg ?? this.qty_kg,
      income_price: income_price ?? this.income_price,
      income_price_usd: income_price_usd ?? this.income_price_usd,
      selling_price: selling_price ?? this.selling_price,
      selling_percentage: selling_percentage ?? this.selling_percentage,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'qty': qty,
      'qty_kg': qty_kg,
      'income_price': income_price,
      'income_price_usd': income_price_usd,
      'selling_price': selling_price,
      'selling_percentage': selling_percentage,
      'currency': currency?.toMap(),
      'currency_type': currency_type,
    };
  }

  factory DocItemModelForItemModel.fromMap(Map<String, dynamic> map) {
    return DocItemModelForItemModel(
      id: map['id'] as int,
      currency_type: CurrencyTypeModel.fromMap(map['currency_type']),
      qty: double.parse(map['qty'].toString()),
      qty_kg: double.parse(map['qty_kg'].toString()),
      income_price: double.parse(map['income_price'].toString()),
      income_price_usd: double.parse(map['income_price_usd'].toString()),
      selling_price: double.parse(map['selling_price'].toString()),
      selling_percentage: double.parse(map['selling_percentage'].toString()),
      currency: map['currency'] != null
          ? CurrencyModel.fromMap(map['currency'] as Map<String, dynamic>)
          : null,
    );
  }

  factory DocItemModelForItemModel.empty() {
    return DocItemModelForItemModel(
      id: 0,
      qty: 0,
      qty_kg: 0,
      income_price: 0.0,
      currency_type: CurrencyTypeModel.empty(),
      income_price_usd: 0.0,
      selling_price: 0.0,
      selling_percentage: 0.0,
      currency: CurrencyModel.empty(),
    );
  }
}

class DocItemModelWithoutDocument {
  int id;
  double qty;
  double qty_kg;
  Item item;
  double income_price;
  double income_price_usd;
  double selling_price;
  double selling_percentage;
  DateTime created_at;
  DateTime updated_at;
  CurrencyModel? currency;
  CurrencyTypeModel currency_type;
  DocItemModelWithoutDocument({
    required this.id,
    required this.qty,
    required this.qty_kg,
    required this.item,
    required this.currency_type,
    required this.income_price,
    required this.income_price_usd,
    required this.selling_price,
    required this.selling_percentage,
    required this.created_at,
    required this.updated_at,
    required this.currency,
  });

  DocItemModelWithoutDocument copyWith({
    int? id,
    double? qty,
    double? qty_kg,
    Item? item,
    double? income_price,
    double? income_price_usd,
    double? selling_price,
    double? selling_percentage,
    DateTime? created_at,
    DateTime? updated_at,
    CurrencyModel? currency,
    CurrencyTypeModel? currency_type,
  }) {
    return DocItemModelWithoutDocument(
      id: id ?? this.id,
      qty: qty ?? this.qty,
      currency_type: currency_type ?? this.currency_type,
      item: item ?? this.item,
      qty_kg: qty_kg ?? this.qty_kg,
      income_price: income_price ?? this.income_price,
      income_price_usd: income_price_usd ?? this.income_price_usd,
      selling_price: selling_price ?? this.selling_price,
      selling_percentage: selling_percentage ?? this.selling_percentage,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'qty': qty,
      'qty_kg': qty_kg,
      'item': item.toJson(),
      'income_price': income_price,
      'income_price_usd': income_price_usd,
      'selling_price': selling_price,
      'selling_percentage': selling_percentage,
      'currency_type': currency_type,
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString(),
      'currency': currency!.toMap(),
    };
  }

  factory DocItemModelWithoutDocument.fromMap(Map<String, dynamic> map) {
    return DocItemModelWithoutDocument(
      id: map['id'] as int,
      currency_type: CurrencyTypeModel.fromMap(map['currency_type']),
      qty_kg: double.parse(map['qty_kg'].toString()),
      qty: double.parse(map['qty'].toString()),
      item: Item.fromJson(map['item'] as Map<String, dynamic>),
      income_price: double.parse(map['income_price'].toString()),
      income_price_usd: double.parse(map['income_price_usd'].toString()),
      selling_price: double.parse(map['selling_price'].toString()),
      selling_percentage: double.parse(map['selling_percentage'].toString()),
      created_at: DateTime.parse(map['created_at']),
      updated_at: DateTime.parse(map['updated_at']),
      currency: map['currency'] != null
          ? CurrencyModel.fromMap(map['currency'] as Map<String, dynamic>)
          : null,
    );
  }
}
