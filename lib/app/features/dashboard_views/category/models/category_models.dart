import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class CategoryModel {
  final int id;
  final String name;
  final DateTime created_at;
  final DateTime updated_at;
  final int items_count;
  final int items_type_count;
  CategoryModel({
    required this.id,
    required this.name,
    required this.created_at,
    required this.updated_at,
    required this.items_count,
    required this.items_type_count,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    DateTime? created_at,
    DateTime? updated_at,
    int? items_count,
    int? items_type_count,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      items_count: items_count ?? this.items_count,
      items_type_count: items_type_count ?? this.items_type_count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
      'items_count': items_count,
      'items_type_count': items_type_count,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      created_at: DateTime.parse(map['created_at']),
      updated_at: DateTime.parse(map['updated_at']),
      items_count: int.parse(map['items_count'].toString()),
      items_type_count: int.parse(map['items_type_count'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CategoryModel.empty() {
    return CategoryModel(
      id: 0,
      name: '',
      created_at: DateTime.now(),
      updated_at: DateTime.now(),
      items_count: 0,
      items_type_count: 0,
    );
  }
  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, created_at: $created_at, updated_at: $updated_at, items_count: $items_count, items_type_count: $items_type_count)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.items_count == items_count &&
        other.items_type_count == items_type_count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        items_count.hashCode ^
        items_type_count.hashCode;
  }
}

class CategoryPublicModel {
  final int id;
  final String name;
  final DateTime created_at;
  final DateTime updated_at;
  CategoryPublicModel({
    required this.id,
    required this.name,
    required this.created_at,
    required this.updated_at,
  });

  CategoryPublicModel copyWith({
    int? id,
    String? name,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return CategoryPublicModel(
      id: id ?? this.id,
      name: name ?? this.name,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString(),
    };
  }

  factory CategoryPublicModel.fromMap(Map<String, dynamic> map) {
    return CategoryPublicModel(
      id: map['id'] as int,
      name: map['name'] as String,
      created_at: DateTime.parse(map['created_at']),
      updated_at: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryPublicModel.fromJson(String source) =>
      CategoryPublicModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CategoryPublicModel.empty() {
    return CategoryPublicModel(
      id: 0,
      name: '',
      created_at: DateTime.now(),
      updated_at: DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'CategoryPublicModel(id: $id, name: $name, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant CategoryPublicModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
