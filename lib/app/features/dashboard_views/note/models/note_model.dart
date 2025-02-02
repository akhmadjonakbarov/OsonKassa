// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import '../../item/models/item.dart';

class NoteModel {
  int id;
  Item item;
  NoteModel({
    required this.id,
    required this.item,
  });

  NoteModel copyWith({
    int? id,
    Item? item,
  }) {
    return NoteModel(
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

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      item: Item.fromMap(map['item'] as Map<String, dynamic>),
    );
  }
}
