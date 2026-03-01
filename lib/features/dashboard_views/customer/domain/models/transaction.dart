import 'dart:convert';

class Transaction {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? amount;

  Transaction({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.amount,
  });

  Transaction copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? amount,
  }) =>
      Transaction(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        amount: amount ?? this.amount,
      );

  factory Transaction.fromRawJson(String str) =>
      Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        amount: json["amount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "amount": amount,
      };
}
