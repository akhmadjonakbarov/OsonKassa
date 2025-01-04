// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:osonkassa/app/features/auth/models/employee_model.dart';

class UserModel {
  final int id;
  final String last_name;
  final String first_name;
  final String email;
  final String token;
  final EmployeeModel employee;
  UserModel({
    required this.id,
    required this.last_name,
    required this.first_name,
    required this.email,
    required this.token,
    required this.employee,
  });

  UserModel copyWith({
    int? id,
    String? last_name,
    String? first_name,
    String? email,
    String? token,
    EmployeeModel? employee,
  }) {
    return UserModel(
      id: id ?? this.id,
      last_name: last_name ?? this.last_name,
      first_name: first_name ?? this.first_name,
      email: email ?? this.email,
      token: token ?? this.token,
      employee: employee ?? this.employee,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'last_name': last_name,
      'first_name': first_name,
      'email': email,
      'token': token,
      'employee': employee.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      last_name: map['last_name'] as String,
      first_name: map['first_name'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
      employee: EmployeeModel.fromMap(map['employee'] as Map<String, dynamic>),
    );
  }
  factory UserModel.empty() {
    return UserModel(
      id: 0,
      last_name: '',
      first_name: '',
      email: '',
      token: '',
      employee: EmployeeModel.empty(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, last_name: $last_name, first_name: $first_name, email: $email, token: $token, employee: $employee)';
  }
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
