class DocItemBalance {
  int id;
  int qty;
  int itemId;
  double income_price;
  double selling_price;
  int product_doc_id;
  int product_doc_item_id;

  DocItemBalance({
    required this.id,
    required this.qty,
    required this.itemId,
    required this.income_price,
    required this.selling_price,
    required this.product_doc_id,
    required this.product_doc_item_id,
  });

  DocItemBalance copyWith({
    int? id,
    int? qty,
    int? itemId,
    double? income_price,
    double? selling_price,
    int? product_doc_id,
    int? product_doc_item_id,
  }) {
    return DocItemBalance(
      id: id ?? this.id,
      qty: qty ?? this.qty,
      itemId: itemId ?? this.itemId,
      income_price: income_price ?? this.income_price,
      selling_price: selling_price ?? this.selling_price,
      product_doc_id: product_doc_id ?? this.product_doc_id,
      product_doc_item_id: product_doc_item_id ?? this.product_doc_item_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'qty': this.qty,
      'itemId': this.itemId,
      'income_price': this.income_price,
      'selling_price': this.selling_price,
      'product_doc_id': this.product_doc_id,
      'product_doc_item_id': this.product_doc_item_id,
    };
  }

  factory DocItemBalance.fromMap(Map<String, dynamic> map) {
    return DocItemBalance(
      id: map['id'] as int,
      qty: map['qty'] as int,
      itemId: map['itemId'] as int,
      income_price: map['income_price'] as double,
      selling_price: map['selling_price'] as double,
      product_doc_id: map['product_doc_id'] as int,
      product_doc_item_id: map['product_doc_item_id'] as int,
    );
  }
}
