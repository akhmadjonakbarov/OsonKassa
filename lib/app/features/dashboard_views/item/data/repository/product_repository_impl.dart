import 'package:dio/dio.dart';
import 'package:osonkassa/app/features/dashboard_views/item/domain/models/item.dart';
import 'package:osonkassa/app/features/dashboard_views/item/domain/repository/product_repository.dart';

import '../../../../../core/exceptions/app_exceptions.dart';
import '../../../../../core/network/status_codes.dart';

class ProductRepositoryImpl extends ProductRepository {
  final Dio dio;

  ProductRepositoryImpl({required this.dio});

  final String _baseURL = "/item";

  @override
  Future<List<Item>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<bool> updateProduct(Map<String, dynamic> updatedProduct) async {
    print(updatedProduct);
    try {
      Response response = await dio.patch(
        '$_baseURL/update/${updatedProduct['id']}',
        data: updatedProduct,
      );

      return response.statusCode == StatusCodes.OK_200;
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case StatusCodes.CONFLICT_409:
            throw BarcodeAlreadyExistException(
              message: "This barcode is already",
            );
          default:
            throw Exception("Unknown exception");
        }
      } else {
        // Something else went wrong (e.g. no response from the server)
        throw Exception("Network error or no response from the server.");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteProduct(int productId, String? typeName) async {
    try {
      Response response =
          await dio.delete('$_baseURL/delete/$productId', data: {
        "type_name": typeName,
      });
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }
}
