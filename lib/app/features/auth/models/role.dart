import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../action/models/action_model.dart';

class Role {
  final int id;
  final String name;
  final List<EmployeeModel> employees;
  final List<PermissionModel> permissions;
  final DateTime createdAt;
  final DateTime updatedAt;

  Role({
    required this.id,
    required this.name,
    required this.employees,
    required this.permissions,
    required this.createdAt,
    required this.updatedAt,
  });

  Role copyWith({
    int? id,
    String? name,
    List<EmployeeModel>? employees,
    List<PermissionModel>? permissions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Role(
      id: id ?? this.id,
      name: name ?? this.name,
      employees: employees ?? this.employees,
      permissions: permissions ?? this.permissions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'employees': employees.map((x) => x.toMap()).toList(),
      'permissions': permissions.map((x) => x.toMap()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'] as int,
      name: map['name'] as String,
      employees: List<EmployeeModel>.from(
        (map['employees']).map<EmployeeModel>(
          (x) => EmployeeModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      permissions: map['permissions'] == null
          ? []
          : List<PermissionModel>.from(
              (map['permissions']).map<PermissionModel>(
                (x) => PermissionModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) =>
      Role.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoleModel(id: $id, name: $name, employees: $employees, permissions: $permissions, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Role other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.employees, employees) &&
        listEquals(other.permissions, permissions) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        employees.hashCode ^
        permissions.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class EmployeeModel {
  final int id;
  final double baseSalary;
  final SalaryTypeModel salaryType;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmployeeModel({
    required this.id,
    required this.baseSalary,
    required this.salaryType,
    required this.createdAt,
    required this.updatedAt,
  });

  EmployeeModel copyWith({
    int? id,
    double? baseSalary,
    SalaryTypeModel? salaryType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      baseSalary: baseSalary ?? this.baseSalary,
      salaryType: salaryType ?? this.salaryType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'base_salary': baseSalary,
      'salary_type': salaryType.toMap(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] as int,
      baseSalary: double.parse(map['base_salary'].toString()),
      salaryType:
          SalaryTypeModel.fromMap(map['salary_type'] as Map<String, dynamic>),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromJson(String source) =>
      EmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmployeeModel(id: $id, baseSalary: $baseSalary, salaryType: $salaryType, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant EmployeeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.baseSalary == baseSalary &&
        other.salaryType == salaryType &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        baseSalary.hashCode ^
        salaryType.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class SalaryTypeModel {
  final String typeOfSalary;

  SalaryTypeModel({
    required this.typeOfSalary,
  });

  SalaryTypeModel copyWith({
    String? typeOfSalary,
  }) {
    return SalaryTypeModel(
      typeOfSalary: typeOfSalary ?? this.typeOfSalary,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type_of_salary': typeOfSalary,
    };
  }

  factory SalaryTypeModel.fromMap(Map<String, dynamic> map) {
    return SalaryTypeModel(
      typeOfSalary: map['type_of_salary'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalaryTypeModel.fromJson(String source) =>
      SalaryTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PermissionModel {
  final int id;
  final ActionModel action;

  PermissionModel({
    required this.id,
    required this.action,
  });

  PermissionModel copyWith({
    int? id,
    ActionModel? action,
  }) {
    return PermissionModel(
      id: id ?? this.id,
      action: action ?? this.action,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'action': action.toMap(),
    };
  }

  factory PermissionModel.fromMap(Map<String, dynamic> map) {
    return PermissionModel(
      id: map['id'] as int,
      action: ActionModel.fromMap(map['action'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PermissionModel.fromJson(String source) =>
      PermissionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PermissionModel(id: $id, action: $action)';

  @override
  bool operator ==(covariant PermissionModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.action == action;
  }

  @override
  int get hashCode => id.hashCode ^ action.hashCode;
}
