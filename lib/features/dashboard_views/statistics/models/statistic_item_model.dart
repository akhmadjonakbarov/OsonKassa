class StatisticItemModel {
  final String name;
  final double value;

  StatisticItemModel({
    required this.name,
    required this.value,
  });

  factory StatisticItemModel.fromJson(Map<String, dynamic> json) {
    return StatisticItemModel(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}
