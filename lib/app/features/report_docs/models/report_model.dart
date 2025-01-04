// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReportItemModel {
  String item_name;
  double total_qty;
  double selling_price;
  double total_profit;
  String currency_type;
  ReportItemModel({
    required this.item_name,
    required this.total_qty,
    required this.selling_price,
    required this.total_profit,
    required this.currency_type,
  });

  ReportItemModel copyWith(
      {String? item_name,
      double? total_qty,
      double? selling_price,
      double? total_profit,
      String? currency_type}) {
    return ReportItemModel(
      item_name: item_name ?? this.item_name,
      currency_type: currency_type ?? this.currency_type,
      total_qty: total_qty ?? this.total_qty,
      selling_price: selling_price ?? this.selling_price,
      total_profit: total_profit ?? this.total_profit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_name': item_name,
      'total_qty': total_qty,
      'selling_price': selling_price,
      'total_profit': total_profit,
    };
  }

  factory ReportItemModel.fromMap(Map<String, dynamic> map) {
    return ReportItemModel(
      currency_type: map['currency_type'] as String,
      item_name: map['item_name'] as String,
      total_qty: double.parse(map['total_qty'].toString()),
      selling_price: map['selling_price'] as double,
      total_profit: map['total_profit'] as double,
    );
  }
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
      'value': value.map((x) => x.toMap()).toList(),
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      name: map['name'] as String,
      value: List<ReportItemModel>.from(
        (map['value'] as List).map<ReportItemModel>(
          (x) => ReportItemModel.fromMap(x as Map<String, dynamic>),
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
