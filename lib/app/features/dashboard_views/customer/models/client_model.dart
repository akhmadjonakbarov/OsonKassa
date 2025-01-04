class CustomerModel {
  int id;
  String full_name;
  String phone_number;
  String phone_number2;
  String address;
  DateTime created_at;
  DateTime updated_at;

  CustomerModel({
    required this.id,
    required this.full_name,
    required this.phone_number,
    required this.phone_number2,
    required this.address,
    required this.created_at,
    required this.updated_at,
  });

  factory CustomerModel.empty() {
    return CustomerModel(
      id: -1,
      full_name: '',
      phone_number: '',
      phone_number2: '',
      address: '',
      created_at: DateTime.now(),
      updated_at: DateTime.now(),
    );
  }

  CustomerModel copyWith({
    int? id,
    String? name,
    String? phone_number,
    String? phone_number2,
    String? address,
    double? total_buying_price,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      full_name: name ?? this.full_name,
      phone_number: phone_number ?? this.phone_number,
      phone_number2: phone_number2 ?? this.phone_number2,
      address: address ?? this.address,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': full_name,
      'phone_number': phone_number,
      'phone_number2': phone_number2,
      'address': address,
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString(),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] as int,
      full_name: map['full_name'] as String,
      phone_number: map['phone_number'] as String,
      phone_number2: map['phone_number2'] as String,
      address: map['address'] as String,
      created_at: DateTime.parse(map['created_at']),
      updated_at: DateTime.parse(map['updated_at']),
    );
  }
}
