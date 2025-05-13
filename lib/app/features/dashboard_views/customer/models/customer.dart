import 'dart:convert';

class Customer {
  final String? fullName;
  final String? phoneNumber;
  final String? phoneNumber2;
  final String? address;
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Customer({
    this.fullName,
    this.phoneNumber,
    this.phoneNumber2,
    this.address,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Customer copyWith({
    String? fullName,
    String? phoneNumber,
    String? phoneNumber2,
    String? address,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Customer(
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
        address: address ?? this.address,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Customer.fromRawJson(String str) => Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    fullName: json["full_name"],
    phoneNumber: json["phone_number"],
    phoneNumber2: json["phone_number2"],
    address: json["address"],
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "phone_number": phoneNumber,
    "phone_number2": phoneNumber2,
    "address": address,
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
