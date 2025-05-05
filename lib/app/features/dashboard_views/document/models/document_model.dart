// ignore_for_file: non_constant_identifier_names

import 'package:osonkassa/app/features/dashboard_views/document/models/doc_item_model.dart';

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

class DocumentModelWithItems {
  int id;
  DateTime reg_date;
  String doc_type;
  DateTime created_at;
  DateTime updated_at;
  List<DocItemModelWithoutDocument> doc_items;
  double total_price;
  DocumentModelWithItems({
    required this.id,
    required this.reg_date,
    required this.doc_type,
    required this.created_at,
    required this.updated_at,
    required this.doc_items,
    required this.total_price,
  });

  DocumentModelWithItems copyWith({
    int? id,
    DateTime? reg_date,
    String? doc_type,
    DateTime? created_at,
    DateTime? updated_at,
    List<DocItemModelWithoutDocument>? doc_items,
    double? total_price,
  }) {
    return DocumentModelWithItems(
      id: id ?? this.id,
      reg_date: reg_date ?? this.reg_date,
      doc_type: doc_type ?? this.doc_type,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      doc_items: doc_items ?? this.doc_items,
      total_price: total_price ?? this.total_price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reg_date': reg_date.millisecondsSinceEpoch,
      'doc_type': doc_type,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
      'doc_items': doc_items.map((x) => x.toMap()).toList(),
      'total_price': total_price,
    };
  }

  factory DocumentModelWithItems.fromMap(Map<String, dynamic> map) {
    return DocumentModelWithItems(
      id: map['id'] as int,
      reg_date: DateTime.parse(map['reg_date']),
      doc_type: map['doc_type'] as String,
      created_at: DateTime.parse(map['created_at']),
      updated_at: DateTime.parse(map['updated_at']),
      doc_items: List<DocItemModelWithoutDocument>.from(
        (map['doc_items'] as List).map<DocItemModelWithoutDocument>(
          (x) => DocItemModelWithoutDocument.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total_price: double.parse(map['total_price'].toString()),
    );
  }
}
