import 'dart:convert';

class PaymentHistory {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? amount;
  String? note;

  PaymentHistory({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.amount,
    this.note,
  });

  PaymentHistory copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? amount,
    String? note,
  }) =>
      PaymentHistory(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        amount: amount ?? this.amount,
        note: note ?? this.note,
      );

  factory PaymentHistory.fromRawJson(String str) =>
      PaymentHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        amount: json["amount"]?.toDouble(),
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "amount": amount,
        "note": note,
      };
}
