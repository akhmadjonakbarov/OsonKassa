// ignore_for_file: non_constant_identifier_names

import 'package:osonkassa/app/features/dashboard_views/document/models/document_item.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Document {
  final int? id;
  final String? docType;
  final double? typeOfItems;
  final double? countOfItems;
  final Map<String, double>? price;
  final DateTime? createdAt;

  Document({
    this.id,
    this.docType,
    this.typeOfItems,
    this.countOfItems,
    this.price,
    this.createdAt,
  });

  Document copyWith({
    int? id,
    String? docType,
    double? typeOfItems,
    double? countOfItems,
    Map<String, double>? price,
    DateTime? createdAt,
  }) =>
      Document(
        id: id ?? this.id,
        docType: docType ?? this.docType,
        typeOfItems: typeOfItems ?? this.typeOfItems,
        countOfItems: countOfItems ?? this.countOfItems,
        price: price ?? this.price,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Document.fromRawJson(String str) =>
      Document.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        docType: json["doc_type"],
        typeOfItems: json["type_of_items"]?.toDouble(),
        countOfItems: json["count_of_items"]?.toDouble(),
        price: Map.from(json["price"]!)
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doc_type": docType,
        "type_of_items": typeOfItems,
        "count_of_items": countOfItems,
        "price":
            Map.from(price!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "created_at": createdAt?.toIso8601String(),
      };
}
