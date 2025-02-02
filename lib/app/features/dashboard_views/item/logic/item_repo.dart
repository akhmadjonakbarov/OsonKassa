import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/interfaces/api/add.dart';
import '../../../../core/interfaces/api/delete.dart';
import '../../../../core/interfaces/api/get_all.dart';
import '../../../../core/interfaces/api/update.dart';
import '../../../../core/network/status_codes.dart';
import '../../../../core/validator/response_validator.dart';
import '../../../shared/models/api_data.dart';
import '../../../shared/models/pagination_model.dart';
import '../models/item.dart';

class ItemRepo
    implements
        GetAllWithPagination<ApiData>,
        Add<Map<String, dynamic>>,
        Delete<int>,
        Update<Item> {
  final Dio dio;

  ItemRepo(this.dio);

  final String _baseURL = "/item";

  @override
  Future<bool> add(itemData) async {
    try {
      Response response = await dio.post('$_baseURL/add', data: itemData);
      return response.statusCode == StatusCodes.CREATED_201;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.toString());
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

  // @override
  // Future<List<ItemModel>> getAll() async {
  //   try {
  //     List<ItemModel> products = [];
  //     Response response = await dio.get('$_baseURL/all');
  //     if (response.statusCode == StatusCodes.OK_200) {
  //       var resData = response.data['data']['list'];
  //       for (var element in resData) {
  //         ItemModel item = ItemModel.fromMap(element);
  //         products.add(item);
  //       }
  //     }
  //     return products;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<bool> update(Item item) async {
    try {
      Map<String, dynamic> itemMap = item.toMap();
      Response response = await dio.patch(
        '$_baseURL/update/${item.id}',
        data: itemMap,
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
  Future<ApiData> getAll(int page, int pageSize) async {
    ApiData<Item> data =
        ApiData(pagination: PaginationModel.empty(), items: []);
    PaginationModel pagination = PaginationModel.empty();
    try {
      List<Item> products = [];
      Response response = await dio.get(
        '$_baseURL/all?page=$page&size=$pageSize',
      );

      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        var paginationData = response.data['data']['pagination'];
        for (var element in resData) {
          Item item = Item.fromMap(element);
          products.add(item);
        }
        if (ResponseValidator.isMap(paginationData)) {
          pagination = PaginationModel.fromMap(paginationData);
        }
      }
      data.items = products;
      data.pagination = pagination;

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
