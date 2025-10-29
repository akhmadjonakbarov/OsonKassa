import 'dart:convert';

class Purchase {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? customerId;
  bool? isDebt;
  dynamic paidDate;
  List<PurchaseItem>? products;
  double? discount;

  Purchase({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.customerId,
    this.isDebt,
    this.paidDate,
    this.products,
    this.discount,
  });

  Purchase copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? customerId,
    bool? isDebt,
    dynamic paidDate,
    List<PurchaseItem>? products,
    double? discount,
  }) =>
      Purchase(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        customerId: customerId ?? this.customerId,
        isDebt: isDebt ?? this.isDebt,
        paidDate: paidDate ?? this.paidDate,
        products: products ?? this.products,
        discount: discount ?? this.discount,
      );

  factory Purchase.fromRawJson(String str) =>
      Purchase.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
        products: json["products"] == null
            ? []
            : List<PurchaseItem>.from(
                json["products"]!.map((x) => PurchaseItem.fromJson(x))),
        discount: json["discount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "customer_id": customerId,
        "is_debt": isDebt,
        "paid_date": paidDate,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "discount": discount,
      };
}

class PurchaseItem {
  String? name;
  String? itemType;
  String? barcode;
  double? incomePrice;
  double? salePrice;
  double? qty;
  String? unit;

  PurchaseItem({
    this.name,
    this.barcode,
    this.incomePrice,
    this.salePrice,
    this.qty,
    this.unit,
    this.itemType,
  });

  PurchaseItem copyWith({
    String? name,
    String? barcode,
    double? incomePrice,
    double? salePrice,
    double? qty,
    String? unit,
    String? itemType,
  }) =>
      PurchaseItem(
        name: name ?? this.name,
        barcode: barcode ?? this.barcode,
        incomePrice: incomePrice ?? this.incomePrice,
        salePrice: salePrice ?? this.salePrice,
        qty: qty ?? this.qty,
        unit: unit ?? this.unit,
        itemType: itemType ?? this.itemType,
      );

  factory PurchaseItem.fromRawJson(String str) =>
      PurchaseItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchaseItem.fromJson(Map<String, dynamic> json) => PurchaseItem(
        name: json["name"],
        barcode: json["barcode"],
        incomePrice: json["income_price"]?.toDouble(),
        salePrice: json["sale_price"]?.toDouble(),
        itemType: json["item_type"],
        qty: json["qty"]?.toDouble(),
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "barcode": barcode,
        "income_price": incomePrice,
        "sale_price": salePrice,
        "item_type": itemType,
        "qty": qty,
        "unit": unit,
      };
}
