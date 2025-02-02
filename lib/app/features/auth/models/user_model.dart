// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../action/models/action_model.dart';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final List<Role> roles;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String token;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });

  factory UserModel.empty() {
    return UserModel(
      id: 0,
      firstName: '',
      lastName: '',
      email: '',
      roles: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      token: '',
    );
  }

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    List<Role>? roles,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'roles': roles.map((x) => x.toMap()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String,
      roles: List<Role>.from(
        (map['roles']).map<Role>(
          (x) => Role.fromMap(x as Map<String, dynamic>),
        ),
      ),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, roles: $roles, createdAt: $createdAt, updatedAt: $updatedAt, token: $token)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        listEquals(other.roles, roles) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        roles.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        token.hashCode;
  }
}

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
      permissions: List<PermissionModel>.from(
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
      baseSalary: map['base_salary'] as double,
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
  final int id;
  final String typeOfSalary;
  final DateTime createdAt;
  final DateTime updatedAt;

  SalaryTypeModel({
    required this.id,
    required this.typeOfSalary,
    required this.createdAt,
    required this.updatedAt,
  });

  SalaryTypeModel copyWith({
    int? id,
    String? typeOfSalary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SalaryTypeModel(
      id: id ?? this.id,
      typeOfSalary: typeOfSalary ?? this.typeOfSalary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type_of_salary': typeOfSalary,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  factory SalaryTypeModel.fromMap(Map<String, dynamic> map) {
    return SalaryTypeModel(
      id: map['id'] as int,
      typeOfSalary: map['type_of_salary'] as String,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SalaryTypeModel.fromJson(String source) =>
      SalaryTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SalaryTypeModel(id: $id, typeOfSalary: $typeOfSalary, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant SalaryTypeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.typeOfSalary == typeOfSalary &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typeOfSalary.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
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

class PublicUserModel {
  final int id;
  final String address;

  final DateTime created_at;
  final DateTime updated_at;
  final String last_name;
  final String first_name;

  PublicUserModel({
    required this.id,
    required this.address,
    required this.created_at,
    required this.updated_at,
    required this.last_name,
    required this.first_name,
  });

  PublicUserModel copyWith({
    int? id,
    String? address,
    DateTime? created_at,
    DateTime? updated_at,
    String? last_name,
    String? first_name,
  }) {
    return PublicUserModel(
      id: id ?? this.id,
      address: address ?? this.address,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      last_name: last_name ?? this.last_name,
      first_name: first_name ?? this.first_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
      'last_name': last_name,
      'first_name': first_name,
    };
  }

  factory PublicUserModel.fromMap(Map<String, dynamic> map) {
    return PublicUserModel(
      id: map['id'] as int,
      address: map['address'] as String,
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updated_at: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      last_name: map['last_name'] as String,
      first_name: map['first_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PublicUserModel.fromJson(String source) =>
      PublicUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PublicUserModel(id: $id, address: $address, created_at: $created_at, updated_at: $updated_at, last_name: $last_name, first_name: $first_name)';
  }
}
