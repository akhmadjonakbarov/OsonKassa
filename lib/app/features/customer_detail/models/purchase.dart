import 'dart:convert';

class Purchase {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? customerId;
  bool? isDebt;
  dynamic paidDate;
  PurchaseDocument? purchaseDocument;
  double? discount;

  Purchase({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.customerId,
    this.isDebt,
    this.paidDate,
    this.purchaseDocument,
    this.discount,
  });

  Purchase copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? customerId,
    bool? isDebt,
    dynamic paidDate,
    PurchaseDocument? purchaseDocument,
    double? discount,
  }) =>
      Purchase(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        customerId: customerId ?? this.customerId,
        isDebt: isDebt ?? this.isDebt,
        paidDate: paidDate ?? this.paidDate,
        purchaseDocument: purchaseDocument ?? this.purchaseDocument,
        discount: discount ?? this.discount,
      );

  factory Purchase.fromRawJson(String str) =>
      Purchase.fromJson(json.decode(str));

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customerId: json["customer_id"],
        isDebt: json["is_debt"],
        paidDate: json["paid_date"],
        purchaseDocument: json["document"] == null
            ? null
            : PurchaseDocument.fromJson(json["document"]),
        discount: json["discount"]?.toDouble(),
      );
}

class PurchaseDocument {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Product>? products;

  PurchaseDocument({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  PurchaseDocument copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Product>? products,
  }) =>
      PurchaseDocument(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        products: products ?? this.products,
      );

  factory PurchaseDocument.fromRawJson(String str) =>
      PurchaseDocument.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchaseDocument.fromJson(Map<String, dynamic> json) =>
      PurchaseDocument(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        products: json["document_items"] == null
            ? []
            : List<Product>.from(
                json["document_items"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PurchaseItem? purchaseItem;
  final double? qty;
  final double? incomePrice;
  final double? salePrice;
  final double? salePercentage;
  final double? currencyRateValue;

  Product({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.purchaseItem,
    this.qty,
    this.incomePrice,
    this.salePrice,
    this.salePercentage,
    this.currencyRateValue,
  });

  Product copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    PurchaseItem? purchaseItem,
    double? qty,
    double? incomePrice,
    double? salePrice,
    double? salePercentage,
    double? currencyRateValue,
  }) =>
      Product(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        purchaseItem: purchaseItem ?? this.purchaseItem,
        qty: qty ?? this.qty,
        incomePrice: incomePrice ?? this.incomePrice,
        salePrice: salePrice ?? this.salePrice,
        salePercentage: salePercentage ?? this.salePercentage,
        currencyRateValue: currencyRateValue ?? this.currencyRateValue,
      );

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        purchaseItem:
            json["item"] == null ? null : PurchaseItem.fromJson(json["item"]),
        qty: json["qty"]?.toDouble(),
        incomePrice: json["income_price"]?.toDouble(),
        salePrice: json["sale_price"]?.toDouble(),
        salePercentage: json["sale_percentage"]?.toDouble(),
        currencyRateValue: json["currency_rate_value"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "purchase_item": purchaseItem?.toJson(),
        "qty": qty,
        "income_price": incomePrice,
        "sale_price": salePrice,
        "sale_percentage": salePercentage,
        "currency_rate_value": currencyRateValue,
      };
}

class PurchaseItem {
  final int? id;
  final String? name;
  final double? incomePrice;
  final double? salePrice;
  final String? barcode;
  final String? currencyType;
  final String? category;
  final String? unit;
  final dynamic itemType;

  PurchaseItem({
    this.id,
    this.name,
    this.incomePrice,
    this.salePrice,
    this.barcode,
    this.currencyType,
    this.category,
    this.unit,
    this.itemType,
  });

  PurchaseItem copyWith({
    int? id,
    String? name,
    double? incomePrice,
    double? salePrice,
    String? barcode,
    String? currencyType,
    String? category,
    String? unit,
    dynamic itemType,
  }) =>
      PurchaseItem(
        id: id ?? this.id,
        name: name ?? this.name,
        incomePrice: incomePrice ?? this.incomePrice,
        salePrice: salePrice ?? this.salePrice,
        barcode: barcode ?? this.barcode,
        currencyType: currencyType ?? this.currencyType,
        category: category ?? this.category,
        unit: unit ?? this.unit,
        itemType: itemType ?? this.itemType,
      );

  factory PurchaseItem.fromRawJson(String str) =>
      PurchaseItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchaseItem.fromJson(Map<String, dynamic> json) => PurchaseItem(
        id: json["id"],
        name: json["name"],
        incomePrice: json["income_price"]?.toDouble(),
        salePrice: json["sale_price"]?.toDouble(),
        barcode: json["barcode"],
        currencyType: json["currency_type"],
        category: json["category"],
        unit: json["unit"],
        itemType: json["item_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "income_price": incomePrice,
        "sale_price": salePrice,
        "barcode": barcode,
        "currency_type": currencyType,
        "category": category,
        "unit": unit,
        "item_type": itemType,
      };
}
