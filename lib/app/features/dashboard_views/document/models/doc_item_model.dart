// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:osonkassa/app/features/dashboard_views/currency/models/models.dart';
import 'package:osonkassa/app/features/dashboard_views/document/models/document_model.dart';
import 'package:osonkassa/app/features/dashboard_views/item/models/item.dart';

// ignore_for_file: unnecessary_this

class DocItemModel {
  int id;
  double qty;
  Item item;
  DocumentModel document;
  double income_price;
  double income_price_usd;
  double selling_price;
  double selling_percentage;
  DateTime created_at;
  DateTime updated_at;
  CurrencyModel? currency;
  CurrencyTypeModel currency_type;

  DocItemModel({
    required this.id,
    required this.qty,
    required this.item,
    required this.document,
    required this.income_price,
    required this.income_price_usd,
    required this.selling_price,
    required this.selling_percentage,
    required this.created_at,
    required this.updated_at,
    this.currency,
    required this.currency_type,
  });

  DocItemModel copyWith({
    int? id,
    double? qty,
    Item? item,
    DocumentModel? document,
    double? income_price,
    double? income_price_usd,
    double? selling_price,
    double? selling_percentage,
    bool? can_be_cheaper,
    DateTime? created_at,
    DateTime? updated_at,
    CurrencyModel? currency,
    CurrencyTypeModel? currency_type,
  }) {
    return DocItemModel(
      id: id ?? this.id,
      qty: qty ?? this.qty,
      currency_type: currency_type ?? this.currency_type,
      item: item ?? this.item,
      document: document ?? this.document,
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
      'item': item.toMap(),
      'document': document.toMap(),
      'income_price': income_price,
      'currency_type': currency_type,
      'income_price_usd': income_price_usd,
      'selling_price': selling_price,
      'selling_percentage': selling_percentage,
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString(),
      'currency':
          currency != null ? currency!.toMap() : CurrencyModel.empty().toMap(),
    };
  }

  factory DocItemModel.fromMap(Map<String, dynamic> map) {
    return DocItemModel(
      id: map['id'] as int,
      qty: double.parse(map['qty'].toString()),
      currency_type: CurrencyTypeModel.fromMap(map['currency_type']),
      item: Item.fromMap(map['item'] as Map<String, dynamic>),
      document: DocumentModel.fromMap(map['document'] as Map<String, dynamic>),
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

  factory DocItemModel.empty() {
    return DocItemModel(
      id: 0,
      qty: 0,
      currency_type: CurrencyTypeModel.empty(),
      item: Item.empty(),
      document: DocumentModel.empty(),
      income_price: 0.0,
      income_price_usd: 0.0,
      selling_price: 0.0,
      selling_percentage: 0.0,
      created_at: DateTime.now(),
      updated_at: DateTime.now(),
      currency: CurrencyModel.empty(),
    );
  }
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
      'item': item.toMap(),
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
      item: Item.fromMap(map['item'] as Map<String, dynamic>),
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
