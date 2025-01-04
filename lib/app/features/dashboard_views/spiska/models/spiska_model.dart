// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import '../../item/models/item_model.dart';

class SpiskaModel {
  int id;
  ItemModel item;
  SpiskaModel({
    required this.id,
    required this.item,
  });

  SpiskaModel copyWith({
    int? id,
    ItemModel? item,
  }) {
    return SpiskaModel(
      id: id ?? this.id,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'item': item.toMap(),
    };
  }

  factory SpiskaModel.fromMap(Map<String, dynamic> map) {
    return SpiskaModel(
      id: map['id'] as int,
      item: ItemModel.fromMap(map['item'] as Map<String, dynamic>),
    );
  }
}
