import 'dart:convert';

class DailySaleRate {
  final DateTime? date;
  final double? sales;
  final double? profit;

  DailySaleRate({
    this.date,
    this.sales,
    this.profit,
  });

  DailySaleRate copyWith({
    DateTime? date,
    double? sales,
    double? profit,
  }) =>
      DailySaleRate(
        date: date ?? this.date,
        sales: sales ?? this.sales,
        profit: profit ?? this.profit,
      );

  factory DailySaleRate.fromRawJson(String str) => DailySaleRate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DailySaleRate.fromJson(Map<String, dynamic> json) => DailySaleRate(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    sales: json["sales"]?.toDouble(),
    profit: json["profit"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "sales": sales,
    "profit": profit,
  };
}
