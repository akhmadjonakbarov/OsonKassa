import 'dart:convert';

class ProductSummary {
  final List<UnitSummary>? units;
  final Map<String, double>? price;

  ProductSummary({
    this.units,
    this.price,
  });

  ProductSummary copyWith({
    List<UnitSummary>? units,
    Map<String, double>? price,
  }) =>
      ProductSummary(
        units: units ?? this.units,
        price: price ?? this.price,
      );

  factory ProductSummary.fromRawJson(String str) =>
      ProductSummary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductSummary.fromJson(Map<String, dynamic> json) => ProductSummary(
        units: json["units"] == null
            ? []
            : List<UnitSummary>.from(
                json["units"]!.map((x) => UnitSummary.fromJson(x))),
        price: Map.from(json["price"]!)
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "units": units == null
            ? []
            : List<dynamic>.from(units!.map((x) => x.toJson())),
        "price":
            Map.from(price!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class UnitSummary {
  final String? unit;
  final double? qty;

  UnitSummary({
    this.unit,
    this.qty,
  });

  UnitSummary copyWith({
    String? unit,
    double? qty,
  }) =>
      UnitSummary(
        unit: unit ?? this.unit,
        qty: qty ?? this.qty,
      );

  factory UnitSummary.fromRawJson(String str) =>
      UnitSummary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnitSummary.fromJson(Map<String, dynamic> json) => UnitSummary(
        unit: json["unit"],
        qty: json["qty"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "unit": unit,
        "qty": qty,
      };
}
