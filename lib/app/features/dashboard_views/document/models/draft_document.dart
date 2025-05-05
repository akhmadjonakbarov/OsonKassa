// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:osonkassa/app/features/dashboard_views/document/models/draf_product.dart';

class DraftDocument {
  final String docType;
  final List<DraftProduct> products;
  DraftDocument({
    required this.docType,
    required this.products,
  });

  DraftDocument copyWith({
    String? docType,
    List<DraftProduct>? products,
  }) {
    return DraftDocument(
      docType: docType ?? this.docType,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doc_type': docType,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'DraftDocument(docType: $docType, products: $products)';
}
