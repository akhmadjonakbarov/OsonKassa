import 'dart:convert';

class OrderItem {
  int? id;
  int? itemId;
  double? qty;
  double? incomePrice;
  double? salePrice;
  String? name;
  String? barcode;
  String? unit;

  OrderItem({
    this.id,
    this.itemId,
    this.qty,
    this.incomePrice,
    this.salePrice,
    this.name,
    this.barcode,
    this.unit,
  });

  OrderItem copyWith({
    int? id,
    int? itemId,
    double? qty,
    double? incomePrice,
    double? salePrice,
    String? name,
    String? barcode,
    String? unit,
  }) =>
      OrderItem(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        qty: qty ?? this.qty,
        incomePrice: incomePrice ?? this.incomePrice,
        salePrice: salePrice ?? this.salePrice,
        name: name ?? this.name,
        barcode: barcode ?? this.barcode,
        unit: unit ?? this.unit,
      );

  factory OrderItem.fromRawJson(String str) =>
      OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        itemId: json["item_id"],
        qty: json["qty"]?.toDouble(),
        incomePrice: json["income_price"]?.toDouble(),
        salePrice: json["sale_price"]?.toDouble(),
        name: json["name"],
        barcode: json["barcode"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "qty": qty,
        "income_price": incomePrice,
        "sale_price": salePrice,
        "name": name,
        "barcode": barcode,
        "unit": unit,
      };
}
