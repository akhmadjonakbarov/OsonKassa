import 'package:dio/dio.dart';
import 'package:osonkassa/app/features/shared/models/api_data.dart';
import 'package:osonkassa/app/features/shared/models/pagination_model.dart';

import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/network/status_codes.dart';
import '../../../../core/validator/response_validator.dart';
import '../../document/models/doc_item_model.dart';

class StoreRepository
    implements
        GetAllWithPagination<ApiData>,
        Delete<int>,
        Update<DocItemModel> {
  final Dio dio;

  StoreRepository({required this.dio});

  static const _baseURL = "/store";

  // @override
  // Future<List<DocItemModel>> getAll() async {
  //   try {
  //     List<DocItemModel> store_products = [];
  //     Response response = await dio.get("$_baseURL/all");
  //     if (response.statusCode == StatusCodes.OK_200) {
  //       var resData = response.data['data']['list'];
  //       if (ResponseValidator.isNotEmptyAndIsList(resData)) {
  //         for (var element in resData) {
  //           if (ResponseValidator.isMap(element)) {
  //             store_products.add(DocItemModel.fromMap(element));
  //           }
  //         }
  //       }
  //     }
  //     return store_products;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<bool> delete(int id) async {
    try {
      Response response = await dio.delete("$_baseURL/delete/$id");
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> update(DocItemModel value) async {
    try {
      Response response = await dio.patch(
        "$_baseURL/update/${value.id}",
        data: value.toMap(),
      );
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiData> getAll(int page, int pageSize) async {
    ApiData data = ApiData(pagination: PaginationModel.empty(), items: []);
    try {
      List<DocItemModel> store_products = [];
      PaginationModel pagination = PaginationModel.empty();

      Response response =
          await dio.get("$_baseURL/all?page=$page&size=$pageSize");
      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        var paginationData = response.data['data']['pagination'];
        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var element in resData) {
            if (ResponseValidator.isMap(element)) {
              store_products.add(DocItemModel.fromMap(element));
            }
          }
        }
        pagination = PaginationModel.fromMap(paginationData);
      }

      data.pagination = pagination;
      data.items = store_products;

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
