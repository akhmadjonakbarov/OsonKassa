// ignore_for_file: non_constant_identifier_names

import 'package:osonkassa/app/features/dashboard_views/document/models/doc_item_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class DocumentModel {
  int id;
  DateTime reg_date;
  String doc_type;
  DateTime created_at;
  DateTime updated_at;
  double type_of_items;
  double total_items_qty;
  double total_price;
  DocumentModel({
    required this.id,
    required this.reg_date,
    required this.doc_type,
    required this.created_at,
    required this.updated_at,
    required this.type_of_items,
    required this.total_items_qty,
    required this.total_price,
  });

  DocumentModel copyWith({
    int? id,
    DateTime? reg_date,
    String? doc_type,
    DateTime? created_at,
    DateTime? updated_at,
    double? type_of_items,
    double? total_items_qty,
    double? total_price,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      total_price: total_price ?? this.total_price,
      reg_date: reg_date ?? this.reg_date,
      doc_type: doc_type ?? this.doc_type,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      type_of_items: type_of_items ?? this.type_of_items,
      total_items_qty: total_items_qty ?? this.total_items_qty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'reg_date': reg_date.toString(),
      'doc_type': doc_type,
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString(),
      'type_of_items': type_of_items,
      'total_items_qty': total_items_qty,
      'total_price': total_price,
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      id: map['id'] as int,
      total_price: double.parse(map['total_price'].toString()),
      reg_date: DateTime.parse(map['reg_date']),
      doc_type: map['doc_type'] as String,
      created_at: DateTime.parse(map['created_at']),
      updated_at: DateTime.parse(map['updated_at']),
      type_of_items: double.parse(map['type_of_items'].toString()),
      total_items_qty: double.parse(map['total_items_qty'].toString()),
    );
  }

  factory DocumentModel.empty() {
    return DocumentModel(
      id: 0,
      reg_date: DateTime.now(),
      doc_type: '',
      total_price: 0.0,
      created_at: DateTime.now(),
      updated_at: DateTime.now(),
      type_of_items: 0,
      total_items_qty: 0,
    );
  }
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
