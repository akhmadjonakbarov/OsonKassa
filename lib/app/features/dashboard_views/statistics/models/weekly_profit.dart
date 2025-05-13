import 'dart:convert';

class WeeklyProfit {
  final String? day;
  final double? profit;

  WeeklyProfit({
    this.day,
    this.profit,
  });

  WeeklyProfit copyWith({
    String? day,
    double? profit,
  }) =>
      WeeklyProfit(
        day: day ?? this.day,
        profit: profit ?? this.profit,
      );

  factory WeeklyProfit.fromRawJson(String str) =>
      WeeklyProfit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeeklyProfit.fromJson(Map<String, dynamic> json) => WeeklyProfit(
        day: json["day"],
        profit: json["profit"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "profit": profit,
      };
}
