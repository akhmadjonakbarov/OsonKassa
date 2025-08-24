// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Unit {
  int id;
  String value;
  Unit({
    required this.id,
    required this.value,
  });

  Unit copyWith({
    int? id,
    String? value,
  }) {
    return Unit(
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

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id'] as int,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) =>
      Unit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UnitModel(id: $id, value: $value)';

  factory Unit.empty() {
    return Unit(id: 0, value: '');
  }
}
