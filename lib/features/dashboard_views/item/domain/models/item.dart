import 'dart:convert';

class Item {
  int? id;
  String? name;
  String? barcode;
  double? salePrice;
  double? incomePrice;
  String? currencyType;
  String? category;
  String? type;
  String? unit;
  dynamic company;
  double? currencyRate;
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
    this.type,
    this.unit,
    this.company,
    this.currencyRate,
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
    String? type,
    String? unit,
    dynamic company,
    double? currencyRate,
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
        type: type ?? this.type,
        unit: unit ?? this.unit,
        company: company ?? this.company,
        currencyRate: currencyRate ?? this.currencyRate,
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
        type: json["type"],
        unit: json["unit"],
        company: json["company"],
        currencyRate: json["currency_rate"]?.toDouble(),
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
        "type": type,
        "unit": unit,
        "company": company,
        "currency_rate": currencyRate,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
