import 'dart:convert';

import 'order_item.dart';

class Order {
  int? id;
  String? createdAt;
  double? discount;
  bool? isDebt;
  int? customerId;
  List<OrderItem>? items;
  double? totalPrice;
  double? discountPrice;

  Order(
      {this.id,
      this.createdAt,
      this.discount,
      this.isDebt,
      this.customerId,
      this.items,
      this.totalPrice,
      this.discountPrice});

  Order copyWith({
    int? id,
    String? createdAt,
    double? discount,
    bool? isDebt,
    int? customerId,
    double? totalPrice,
    double? discountPrice,
    List<OrderItem>? items,
  }) =>
      Order(
          id: id ?? this.id,
          createdAt: createdAt ?? this.createdAt,
          discount: discount ?? this.discount,
          isDebt: isDebt ?? this.isDebt,
          customerId: customerId ?? this.customerId,
          totalPrice: totalPrice ?? this.totalPrice,
          items: items ?? this.items,
          discountPrice: discountPrice ?? this.discountPrice);

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        createdAt: json["created_at"],
        discount: json["discount"]?.toDouble(),
        isDebt: json["is_debt"],
        customerId: json["customer_id"],
        totalPrice: json["total_price"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
        items: json["items"] == null
            ? []
            : List<OrderItem>.from(
                json["items"]!.map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "discount": discount,
        "is_debt": isDebt,
        "customer_id": customerId,
        "total_price": totalPrice,
        "discount_price": discountPrice,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
