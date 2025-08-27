// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'dart:convert';

class Note {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? category;
  String? unit;
  String? name;

  Note({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.unit,
    this.name,
  });

  Note copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    String? unit,
    String? name,
  }) =>
      Note(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        category: category ?? this.category,
        unit: unit ?? this.unit,
        name: name ?? this.name,
      );

  factory Note.fromRawJson(String str) => Note.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        category: json["category"],
        unit: json["unit"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category,
        "unit": unit,
        "name": name,
      };
}
