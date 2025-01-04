// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:osonkassa/app/features/dashboard_views/currency/models/models.dart';

import '../../item/models/item_model.dart';

class StoreProductDocItemBalanceModel {
  int id;
  int qty;
  double selling_price;
  double income_price;
  double discount_price;
  double selling_percentage;
  double income_price_usd;
  String created_at;
  String updated_at;
  ItemModel item;
  CurrencyTypeModel currency_type;
  CurrencyModel currency;
  StoreProductDocItemBalanceModel({
    required this.id,
    required this.qty,
    required this.selling_price,
    required this.income_price,
    required this.discount_price,
    required this.selling_percentage,
    required this.income_price_usd,
    required this.created_at,
    required this.updated_at,
    required this.item,
    required this.currency_type,
    required this.currency,
  });

  factory StoreProductDocItemBalanceModel.empty() {
    return StoreProductDocItemBalanceModel(
        id: -1,
        qty: 0,
        selling_price: 0.0,
        income_price: 0.0,
        discount_price: 0.0,
        selling_percentage: 0.0,
        income_price_usd: 0.0,
        created_at: '',
        updated_at: '',
        currency_type: CurrencyTypeModel.empty(),
        item: ItemModel.empty(),
        currency: CurrencyModel.empty());
  }

  StoreProductDocItemBalanceModel copyWith({
    int? id,
    int? qty,
    double? selling_price,
    double? income_price,
    double? discount_price,
    double? selling_percentage,
    double? income_price_usd,
    String? created_at,
    String? updated_at,
    ItemModel? item,
    CurrencyTypeModel? currency_type,
    CurrencyModel? currency,
  }) {
    return StoreProductDocItemBalanceModel(
      id: id ?? this.id,
      qty: qty ?? this.qty,
      selling_price: selling_price ?? this.selling_price,
      income_price: income_price ?? this.income_price,
      discount_price: discount_price ?? this.discount_price,
      selling_percentage: selling_percentage ?? this.selling_percentage,
      income_price_usd: income_price_usd ?? this.income_price_usd,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      item: item ?? this.item,
      currency_type: currency_type ?? this.currency_type,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'qty': qty,
      'selling_price': selling_price,
      'income_price': income_price,
      'discount_price': discount_price,
      'selling_percentage': selling_percentage,
      'income_price_usd': income_price_usd,
      'created_at': created_at,
      'updated_at': updated_at,
      'item': item.toMap(),
      'currency_type': currency_type.toMap(),
      'currency': currency.toMap(),
    };
  }

  factory StoreProductDocItemBalanceModel.fromMap(Map<String, dynamic> map) {
    return StoreProductDocItemBalanceModel(
      id: map['id'] as int,
      qty: map['qty'] as int,
      selling_price: map['selling_price'] as double,
      income_price: map['income_price'] as double,
      discount_price: map['discount_price'] as double,
      selling_percentage: map['selling_percentage'] as double,
      income_price_usd: map['income_price_usd'] as double,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      item: ItemModel.fromMap(map['item'] as Map<String, dynamic>),
      currency_type: CurrencyTypeModel.fromMap(
          map['currency_type'] as Map<String, dynamic>),
      currency: CurrencyModel.fromMap(map['currency'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreProductDocItemBalanceModel.fromJson(String source) =>
      StoreProductDocItemBalanceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoreProductDocItemBalanceModel(id: $id, qty: $qty, selling_price: $selling_price, income_price: $income_price, discount_price: $discount_price, selling_percentage: $selling_percentage, income_price_usd: $income_price_usd, created_at: $created_at, updated_at: $updated_at, item: $item, currency_type: $currency_type, currency: $currency)';
  }

  @override
  bool operator ==(covariant StoreProductDocItemBalanceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.qty == qty &&
        other.selling_price == selling_price &&
        other.income_price == income_price &&
        other.discount_price == discount_price &&
        other.selling_percentage == selling_percentage &&
        other.income_price_usd == income_price_usd &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.item == item &&
        other.currency_type == currency_type &&
        other.currency == currency;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        qty.hashCode ^
        selling_price.hashCode ^
        income_price.hashCode ^
        discount_price.hashCode ^
        selling_percentage.hashCode ^
        income_price_usd.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        item.hashCode ^
        currency_type.hashCode ^
        currency.hashCode;
  }
}
