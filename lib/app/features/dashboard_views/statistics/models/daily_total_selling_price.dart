class DailyTotalSellingPrice {
  DateTime date;
  double price;
  double profit;

  DailyTotalSellingPrice(
      {required this.date, required this.price, required this.profit});

  DailyTotalSellingPrice copyWith({
    DateTime? date,
    double? price,
    double? profit,
  }) {
    return DailyTotalSellingPrice(
      date: date ?? this.date,
      price: price ?? this.price,
      profit: profit ?? this.profit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'price': price,
    };
  }

  factory DailyTotalSellingPrice.fromMap(Map<String, dynamic> map) {
    return DailyTotalSellingPrice(
      profit: double.parse(map['profit'].toString()),
      date: DateTime.parse(map['date']),
      price: double.parse(map['price'].toString()),
    );
  }
}
