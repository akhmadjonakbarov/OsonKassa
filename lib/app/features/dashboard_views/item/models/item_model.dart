// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:osonkassa/app/features/dashboard_views/category/models/category_models.dart';
import 'package:osonkassa/app/features/dashboard_views/company/models/company_model.dart';
import 'package:osonkassa/app/features/unit/models/unit_model.dart';

class ItemModel {
  int id;
  String name;
  String barcode;
  List<UnitModel> units;
  CompanyModel? company;
  CategoryPublicModel category;
  DateTime created_at;
  DateTime updated_at;

  ItemModel(
      {required this.id,
      required this.name,
      required this.barcode,
      required this.units,
      this.company,
      required this.category,
      required this.created_at,
      required this.updated_at});

  factory ItemModel.empty() {
    return ItemModel(
      id: 0,
      created_at: DateTime.now(),
      updated_at: DateTime.now(),
      name: '',
      barcode: '',
      units: [],
      company: CompanyModel.empty(),
      category: CategoryPublicModel.empty(),
    );
  }

  ItemModel copyWith({
    int? id,
    String? name,
    String? barcode,
    List<UnitModel>? units,
    CompanyModel? company,
    CategoryPublicModel? category,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      units: units ?? this.units,
      company: company ?? this.company,
      category: category ?? this.category,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'barcode': barcode,
      'units': units.map((x) => x.toMap()).toList(),
      'company': company?.toMap(),
      'category': category.toMap(),
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
      barcode: map['barcode'] as String,
      units: List<UnitModel>.from(
        (map['units'] as List).map<UnitModel>(
          (x) => UnitModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      company: map['company'] != null
          ? CompanyModel.fromMap(map['company'] as Map<String, dynamic>)
          : null,
      category:
          CategoryPublicModel.fromMap(map['category'] as Map<String, dynamic>),
      created_at: DateTime.parse(map['created_at']),
      updated_at: DateTime.parse(map['updated_at']),
    );
  }

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, barcode: $barcode, units: $units, company: $company, category: $category, created_at: $created_at, updated_at: $updated_at)';
  }
}
