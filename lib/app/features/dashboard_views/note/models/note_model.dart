// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import '../../item/models/item.dart';

import 'dart:convert';

class Item {
  final int? id;
  final String? name;
  final String? barcode;
  final Category? category;
  final Note? unit;
  final dynamic company;
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
    Category? category,
    Note? unit,
    dynamic company,
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
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        unit: json["unit"] == null ? null : Note.fromJson(json["unit"]),
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
        "category": category?.toJson(),
        "unit": unit?.toJson(),
        "company": company,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Note {
  final int? id;
  final Item? item;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? value;

  Note({
    this.id,
    this.item,
    this.createdAt,
    this.updatedAt,
    this.value,
  });

  Note copyWith({
    int? id,
    Item? item,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? value,
  }) =>
      Note(
        id: id ?? this.id,
        item: item ?? this.item,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        value: value ?? this.value,
      );

  factory Note.fromRawJson(String str) => Note.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item": item?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "value": value,
      };
}

class Category {
  final int? id;
  final String? name;
  final int? itemsTypeCount;
  final int? itemsCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.itemsTypeCount,
    this.itemsCount,
    this.createdAt,
    this.updatedAt,
  });

  Category copyWith({
    int? id,
    String? name,
    int? itemsTypeCount,
    int? itemsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        itemsTypeCount: itemsTypeCount ?? this.itemsTypeCount,
        itemsCount: itemsCount ?? this.itemsCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        itemsTypeCount: json["items_type_count"],
        itemsCount: json["items_count"],
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
        "items_type_count": itemsTypeCount,
        "items_count": itemsCount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
