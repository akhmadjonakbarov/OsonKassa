import '../models/item.dart';

abstract class ProductRepository {
  Future<List<Item>> getProducts();

  Future<bool> updateProduct(Map<String, dynamic> updatedProduct);

  Future<bool> deleteProduct(int productId, String? typeName);
}
