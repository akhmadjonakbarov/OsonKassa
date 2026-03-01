// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'role.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final List<Role> roles;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String token;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });

  factory User.empty() {
    return User(
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

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    List<Role>? roles,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
  }) {
    return User(
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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
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
      token: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, roles: $roles, createdAt: $createdAt, updatedAt: $updatedAt, token: $token)';
  }

  @override
  bool operator ==(covariant User other) {
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
