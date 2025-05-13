import '../../dashboard_views/document/models/document_item.dart';
import 'dart:convert';

class Purchase {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? id;
  final int? customerId;
  final bool? isDebt;
  final dynamic paidDate;
  final List<DocumentItem>? products;

  Purchase({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.customerId,
    this.isDebt,
    this.paidDate,
    this.products,
  });

  Purchase copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    int? id,
    int? customerId,
    bool? isDebt,
    dynamic paidDate,
    List<DocumentItem>? products,
  }) =>
      Purchase(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        isDebt: isDebt ?? this.isDebt,
        paidDate: paidDate ?? this.paidDate,
        products: products ?? this.products,
      );

  factory Purchase.fromRawJson(String str) => Purchase.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    id: json["id"],
    customerId: json["customer_id"],
    isDebt: json["is_debt"],
    paidDate: json["paid_date"],
    products: json["products"] == null ? [] : List<DocumentItem>.from(json["products"]!.map((x) => DocumentItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "id": id,
    "customer_id": customerId,
    "is_debt": isDebt,
    "paid_date": paidDate,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

