class BuilderDebtItem {
  final int itemId;
  final String name;
  final int id;
  final int qty;
  final double sellingPrice;

  BuilderDebtItem({
    required this.itemId,
    required this.name,
    required this.id,
    required this.qty,
    required this.sellingPrice,
  });

  // Factory method to parse from JSON
  factory BuilderDebtItem.fromJson(Map<String, dynamic> json) {
    return BuilderDebtItem(
      itemId: json['item_id'],
      name: json['name'],
      id: json['id'],
      qty: json['qty'],
      sellingPrice: double.parse(json['selling_price'].toString()),
    );
  }

  // Method to create from Map (alias for fromJson)
  factory BuilderDebtItem.fromMap(Map<String, dynamic> map) {
    return BuilderDebtItem.fromJson(map);
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'name': name,
      'id': id,
      'qty': qty,
      'selling_price': sellingPrice,
    };
  }
}

class BuilderDebt {
  final int id;
  final int builderId;
  final bool isPaid;
  final String created_at;
  final List<BuilderDebtItem> productDocItems;

  BuilderDebt({
    required this.id,
    required this.builderId,
    required this.isPaid,
    required this.created_at,
    required this.productDocItems,
  });

  // Factory method to parse from JSON
  factory BuilderDebt.fromJson(Map<String, dynamic> json) {
    var list = json['product_doc_items'] as List;
    List<BuilderDebtItem> itemsList =
        list.map((i) => BuilderDebtItem.fromJson(i)).toList();

    return BuilderDebt(
      id: json['id'],
      builderId: json['builder_id'],
      created_at: json['created_at'],
      isPaid: json['is_paid'],
      productDocItems: itemsList,
    );
  }

  // Method to create from Map (alias for fromJson)
  factory BuilderDebt.fromMap(Map<String, dynamic> map) {
    return BuilderDebt.fromJson(map);
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'builder_id': builderId,
      'is_paid': isPaid,
      'created_at': created_at,
      'product_doc_items':
          productDocItems.map((item) => item.toJson()).toList(),
    };
  }
}
