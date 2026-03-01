import 'dart:convert';

class Type_ {
  final String? name;
  final DateTime? updatedAt;
  final int? id;
  final DateTime? createdAt;

  Type_({
    this.name,
    this.updatedAt,
    this.id,
    this.createdAt,
  });

  Type_ copyWith({
    String? name,
    DateTime? updatedAt,
    int? id,
    DateTime? createdAt,
  }) =>
      Type_(
        name: name ?? this.name,
        updatedAt: updatedAt ?? this.updatedAt,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Type_.fromRawJson(String str) => Type_.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Type_.fromJson(Map<String, dynamic> json) => Type_(
    name: json["name"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "updated_at": updatedAt?.toIso8601String(),
    "id": id,
    "created_at": createdAt?.toIso8601String(),
  };
}
