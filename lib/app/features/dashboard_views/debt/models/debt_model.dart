class DebtModel {
  int id;
  String name;
  String phone_number;
  String? phone_number2;
  String address;
  bool is_paid;
  double amount;
  DebtModel({
    required this.id,
    required this.name,
    required this.phone_number,
    this.phone_number2,
    required this.address,
    required this.is_paid,
    required this.amount,
  });

  DebtModel copyWith({
    int? id,
    String? name,
    String? phone_number,
    String? phone_number2,
    String? address,
    bool? is_paid,
    double? debt_price,
  }) {
    return DebtModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone_number: phone_number ?? this.phone_number,
      phone_number2: phone_number2 ?? this.phone_number2,
      address: address ?? this.address,
      is_paid: is_paid ?? this.is_paid,
      amount: debt_price ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone_number': phone_number,
      'phone_number2': phone_number2,
      'address': address,
      'is_paid': is_paid,
      'amount': amount,
    };
  }

  factory DebtModel.fromMap(Map<String, dynamic> map) {
    return DebtModel(
      id: map['id'] as int,
      name: map['name'] as String,
      phone_number: map['phone_number'] as String,
      phone_number2: map['phone_number2'] as String?,
      address: map['address'] as String,
      is_paid: map['is_paid'] as bool,
      amount: double.parse(map['amount'].toString()),
    );
  }
}
