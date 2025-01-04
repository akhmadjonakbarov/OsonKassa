// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserRoleModel {
  int id;
  String role;
  UserRoleModel({
    required this.id,
    required this.role,
  });

  UserRoleModel copyWith({
    int? id,
    String? role,
  }) {
    return UserRoleModel(
      id: id ?? this.id,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'role': role,
    };
  }

  factory UserRoleModel.fromMap(Map<String, dynamic> map) {
    return UserRoleModel(
      id: map['id'] as int,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRoleModel.empty() {
    return UserRoleModel(id: 0, role: '');
  }

  factory UserRoleModel.fromJson(String source) =>
      UserRoleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserRoleModel(id: $id, role: $role)';

  @override
  bool operator ==(covariant UserRoleModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.role == role;
  }

  @override
  int get hashCode => id.hashCode ^ role.hashCode;
}

class SalaryTypeModel {
  int id;
  String type_of_salary;
  SalaryTypeModel({
    required this.id,
    required this.type_of_salary,
  });

  SalaryTypeModel copyWith({
    int? id,
    String? type_of_salary,
  }) {
    return SalaryTypeModel(
      id: id ?? this.id,
      type_of_salary: type_of_salary ?? this.type_of_salary,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type_of_salary': type_of_salary,
    };
  }

  factory SalaryTypeModel.fromMap(Map<String, dynamic> map) {
    return SalaryTypeModel(
      id: map['id'] as int,
      type_of_salary: map['type_of_salary'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalaryTypeModel.fromJson(String source) =>
      SalaryTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory SalaryTypeModel.empty() {
    return SalaryTypeModel(id: 0, type_of_salary: '');
  }

  @override
  String toString() =>
      'SalaryTypeModel(id: $id, type_of_salary: $type_of_salary)';

  @override
  bool operator ==(covariant SalaryTypeModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.type_of_salary == type_of_salary;
  }

  @override
  int get hashCode => id.hashCode ^ type_of_salary.hashCode;
}

class EmployeeModel {
  int id;
  UserRoleModel role;
  SalaryTypeModel salary_type;
  double base_salary;
  EmployeeModel({
    required this.id,
    required this.role,
    required this.salary_type,
    required this.base_salary,
  });

  EmployeeModel copyWith({
    int? id,
    UserRoleModel? role,
    SalaryTypeModel? salary_type,
    double? base_salary,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      role: role ?? this.role,
      salary_type: salary_type ?? this.salary_type,
      base_salary: base_salary ?? this.base_salary,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'role': role.toMap(),
      'salary_type': salary_type.toMap(),
      'base_salary': base_salary,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] as int,
      role: UserRoleModel.fromMap(map['role']),
      salary_type: SalaryTypeModel.fromMap(map['salary_type']),
      base_salary: double.parse(map['base_salary'].toString()),
    );
  }

  static empty() {
    return EmployeeModel(
      id: 0,
      role: UserRoleModel.empty(),
      salary_type: SalaryTypeModel.empty(),
      base_salary: 0.0,
    );
  }
}
