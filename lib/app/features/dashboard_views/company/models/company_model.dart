// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CompanyModel {
  int id;
  String name;
  CompanyModel({
    required this.id,
    required this.name,
  });

  CompanyModel copyWith({
    int? id,
    String? name,
  }) {
    return CompanyModel(
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

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CompanyModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant CompanyModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory CompanyModel.empty() {
    return CompanyModel(id: 0, name: '');
  }
}
