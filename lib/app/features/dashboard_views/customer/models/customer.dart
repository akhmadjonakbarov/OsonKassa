import 'dart:convert';

class Customer {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullName;
  String? phoneNumber;
  String? phoneNumber2;
  String? address;
  double? debtCost;

  Customer({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.phoneNumber,
    this.phoneNumber2,
    this.address,
    this.debtCost,
  });

  Customer copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? fullName,
    String? phoneNumber,
    String? phoneNumber2,
    String? address,
    double? debtCost,
  }) =>
      Customer(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
        address: address ?? this.address,
        debtCost: debtCost ?? this.debtCost,
      );

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        phoneNumber2: json["phone_number2"],
        address: json["address"],
        debtCost: json["debt_cost"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "full_name": fullName,
        "phone_number": phoneNumber,
        "phone_number2": phoneNumber2,
        "address": address,
        "debt_cost": debtCost,
      };
}
