// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CurrencyModel {
  int id;
  double value;
  String created_at;

  CurrencyModel({
    required this.id,
    required this.value,
    required this.created_at,
  });

  CurrencyModel copyWith({
    int? id,
    double? value,
    String? created_at,
  }) {
    return CurrencyModel(
      id: id ?? this.id,
      value: value ?? this.value,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'created_at': created_at,
    };
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
      id: map['id'] as int,
      value: double.parse(map['value'].toString()),
      created_at: map['created_at'] as String,
    );
  }

  factory CurrencyModel.empty() {
    return CurrencyModel(
      id: -1,
      value: 0.0,
      created_at: '',
    );
  }
}

class CurrencyTypeModel {
  int id;
  String name;
  CurrencyTypeModel({
    required this.id,
    required this.name,
  });

  CurrencyTypeModel copyWith({
    int? id,
    String? name,
  }) {
    return CurrencyTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CurrencyTypeModel.fromMap(Map<String, dynamic> map) {
    return CurrencyTypeModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrencyTypeModel.fromJson(String source) =>
      CurrencyTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CurrencyTypeModel(id: $id, name: $name)';

  factory CurrencyTypeModel.empty() {
    return CurrencyTypeModel(
      id: -1,
      name: "",
    );
  }
}
