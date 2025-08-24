// ignore_for_file: non_constant_identifier_names

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:convert';

class Document {
  int? id;
  String? docType;
  double? typeOfItems;
  double? countOfItems;
  double? price;
  double? discount;
  DateTime? createdAt;

  Document({
    this.id,
    this.docType,
    this.typeOfItems,
    this.countOfItems,
    this.price,
    this.discount,
    this.createdAt,
  });

  Document copyWith({
    int? id,
    String? docType,
    double? typeOfItems,
    double? countOfItems,
    double? price,
    double? discount,
    DateTime? createdAt,
  }) =>
      Document(
        id: id ?? this.id,
        docType: docType ?? this.docType,
        typeOfItems: typeOfItems ?? this.typeOfItems,
        countOfItems: countOfItems ?? this.countOfItems,
        price: price ?? this.price,
        discount: discount ?? this.discount,
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
        price: json["price"]?.toDouble(),
        discount: json["discount"]?.toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doc_type": docType,
        "type_of_items": typeOfItems,
        "count_of_items": countOfItems,
        "price": price,
        "discount": discount,
        "created_at": createdAt?.toIso8601String(),
      };
}
