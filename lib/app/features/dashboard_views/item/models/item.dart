
import 'dart:convert';

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
