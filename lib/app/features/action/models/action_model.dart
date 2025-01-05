// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ActionModel {
  final int id;
  final String name;
  final bool status;
  final String fixedName;
  final DateTime createdAt;
  final DateTime updatedAt;
  ActionModel({
    required this.id,
    required this.name,
    required this.status,
    required this.fixedName,
    required this.createdAt,
    required this.updatedAt,
  });

  ActionModel copyWith({
    int? id,
    String? name,
    bool? status,
    String? fixedName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ActionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      fixedName: fixedName ?? this.fixedName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'fixed_name': fixedName,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  factory ActionModel.fromMap(Map<String, dynamic> map) {
    return ActionModel(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as bool,
      fixedName: map['fixed_name'] as String,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionModel.fromJson(String source) =>
      ActionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ActionModel(id: $id, name: $name, status: $status, fixedName: $fixedName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ActionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.status == status &&
        other.fixedName == fixedName &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        status.hashCode ^
        fixedName.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
