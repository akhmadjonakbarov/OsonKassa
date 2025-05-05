import 'dart:convert';

class StoreItem {
  final int? id;
  final Item? item;
  final Currency? currency;
  final String? incomeCurrency;
  final double? incomePrice;
  final double? sellingPrice;
  final String? sellingCurrency;
  final double? sellingPercentage;
  final double? qty;
  final Document? document;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  StoreItem({
    this.id,
    this.item,
    this.currency,
    this.incomeCurrency,
    this.incomePrice,
    this.sellingPrice,
    this.sellingCurrency,
    this.sellingPercentage,
    this.qty,
    this.document,
    this.createdAt,
    this.updatedAt,
  });

  StoreItem copyWith({
    int? id,
    Item? item,
    Currency? currency,
    String? incomeCurrency,
    double? incomePrice,
    double? sellingPrice,
    String? sellingCurrency,
    double? sellingPercentage,
    double? qty,
    Document? document,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      StoreItem(
        id: id ?? this.id,
        item: item ?? this.item,
        currency: currency ?? this.currency,
        incomeCurrency: incomeCurrency ?? this.incomeCurrency,
        incomePrice: incomePrice ?? this.incomePrice,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        sellingCurrency: sellingCurrency ?? this.sellingCurrency,
        sellingPercentage: sellingPercentage ?? this.sellingPercentage,
        qty: qty ?? this.qty,
        document: document ?? this.document,
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
            : Currency.fromJson(json["currency"]),
        incomeCurrency: json["income_currency"],
        incomePrice: json["income_price"]?.toDouble(),
        sellingPrice: json["selling_price"]?.toDouble(),
        sellingCurrency: json["selling_currency"],
        sellingPercentage: json["selling_percentage"]?.toDouble(),
        qty: json["qty"]?.toDouble(),
        document: json["document"] == null
            ? null
            : Document.fromJson(json["document"]),
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
        "income_currency": incomeCurrency,
        "income_price": incomePrice,
        "selling_price": sellingPrice,
        "selling_currency": sellingCurrency,
        "selling_percentage": sellingPercentage,
        "qty": qty,
        "document": document?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
  Map<String, dynamic> toSellJson() => {
        "item_id": item?.id,
        "currency_id": currency?.id,
        "income_currency": incomeCurrency,
        "income_price": incomePrice,
        "selling_price": sellingPrice,
        "selling_currency": sellingCurrency,
        "selling_percentage": sellingPercentage,
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

class Document {
  final int? id;
  final String? docType;

  Document({
    this.id,
    this.docType,
  });

  Document copyWith({
    int? id,
    String? docType,
  }) =>
      Document(
        id: id ?? this.id,
        docType: docType ?? this.docType,
      );

  factory Document.fromRawJson(String str) =>
      Document.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        docType: json["doc_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doc_type": docType,
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
