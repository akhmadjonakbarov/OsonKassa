// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:convert';

class Currency {
  final int? id;
  final double? value;
  final DateTime? createdAt;

  Currency({
    this.id,
    this.value,
    this.createdAt,
  });

  Currency copyWith({
    int? id,
    double? value,
    DateTime? createdAt,
  }) =>
      Currency(
        id: id ?? this.id,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Currency.fromRawJson(String str) => Currency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    id: json["id"],
    value: json["value"]?.toDouble(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "created_at": createdAt?.toIso8601String(),
  };
}
