// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UnitModel {
  int id;
  String value;
  UnitModel({
    required this.id,
    required this.value,
  });

  UnitModel copyWith({
    int? id,
    String? value,
  }) {
    return UnitModel(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
    };
  }

  factory UnitModel.fromMap(Map<String, dynamic> map) {
    return UnitModel(
      id: map['id'] as int,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UnitModel.fromJson(String source) =>
      UnitModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UnitModel(id: $id, value: $value)';

  factory UnitModel.empty() {
    return UnitModel(id: 0, value: '');
  }
}
