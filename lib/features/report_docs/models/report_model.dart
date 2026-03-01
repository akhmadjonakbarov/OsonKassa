// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReportItemModel {
  String? name;
  String? unit;
  double? totalQty;
  double? totalIncome;
  double? totalSale;
  double? totalProfit;

  ReportItemModel({
    this.name,
    this.unit,
    this.totalQty,
    this.totalIncome,
    this.totalSale,
    this.totalProfit,
  });

  ReportItemModel copyWith({
    String? name,
    String? unit,
    double? totalQty,
    double? totalIncome,
    double? totalSale,
    double? totalProfit,
  }) =>
      ReportItemModel(
        name: name ?? this.name,
        unit: unit ?? this.unit,
        totalQty: totalQty ?? this.totalQty,
        totalIncome: totalIncome ?? this.totalIncome,
        totalSale: totalSale ?? this.totalSale,
        totalProfit: totalProfit ?? this.totalProfit,
      );

  factory ReportItemModel.fromRawJson(String str) =>
      ReportItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReportItemModel.fromJson(Map<String, dynamic> json) =>
      ReportItemModel(
        name: json["name"],
        unit: json["unit"],
        totalQty: json["total_qty"]?.toDouble(),
        totalIncome: json["total_income"]?.toDouble(),
        totalSale: json["total_sale"]?.toDouble(),
        totalProfit: json["total_profit"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "unit": unit,
        "total_qty": totalQty,
        "total_income": totalIncome,
        "total_sale": totalSale,
        "total_profit": totalProfit,
      };
}

class ReportModel {
  String name;
  List<ReportItemModel> value;
  ReportModel({
    required this.name,
    required this.value,
  });

  ReportModel copyWith({
    String? name,
    List<ReportItemModel>? value,
  }) {
    return ReportModel(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value.map((x) => x.toJson()).toList(),
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      name: map['name'] as String,
      value: List<ReportItemModel>.from(
        (map['value'] as List).map<ReportItemModel>(
          (x) => ReportItemModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) =>
      ReportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ReportModel(name: $name, value: $value)';
}
