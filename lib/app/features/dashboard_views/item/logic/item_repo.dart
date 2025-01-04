import 'package:dio/dio.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/interfaces/api/add.dart';
import '../../../../core/interfaces/api/delete.dart';
import '../../../../core/interfaces/api/get_all.dart';
import '../../../../core/interfaces/api/update.dart';
import '../../../../core/network/status_codes.dart';
import '../models/item_model.dart';

class ItemRepo
    implements
        GetAll<ItemModel>,
        Add<Map<String, dynamic>>,
        Delete<int>,
        Update<ItemModel> {
  final Dio dio;

  ItemRepo(this.dio);

  final String _baseURL = "/item";

  @override
  Future<bool> add(itemData) async {
    try {
      Response response = await dio.post('$_baseURL/add', data: itemData);
      return response.statusCode == StatusCodes.CREATED_201;
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case StatusCodes.CONFLICT_409:
            throw BarcodeAlreadyExistException(
              message: "This barcode is already",
            );
          case StatusCodes.BAD_REQUEST_400:
            throw InvalidDataException(
              message: e.response!.data['data']['error'],
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
  Future<bool> delete(int id) async {
    try {
      Response response = await dio.delete('$_baseURL/delete/$id');
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ItemModel>> getAll() async {
    try {
      List<ItemModel> products = [];
      Response response = await dio.get('$_baseURL/all');
      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        for (var element in resData) {
          ItemModel item = ItemModel.fromMap(element);
          products.add(item);
        }
      }
      return products;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> update(ItemModel item) async {
    try {
      Response response = await dio.patch(
        '$_baseURL/update/${item.id}',
        data: item.toMap(),
      );

      if (response.statusCode == StatusCodes.OK_200) {
        return true;
      } else {
        return false;
      }
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
}
