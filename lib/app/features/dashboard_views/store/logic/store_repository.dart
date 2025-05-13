import 'package:dio/dio.dart';
import 'package:osonkassa/app/features/dashboard_views/store/models/store_item.dart';
import 'package:osonkassa/app/utils/helper/log_helper.dart';

import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/network/status_codes.dart';

import '../../../shared/models/api_data.dart';
import '../../../shared/models/pagination_model.dart';

class StoreRepository
    implements GetAllWithPagination<ApiData>, Delete<int>, Update<StoreItem> {
  final Dio dio;

  StoreRepository({required this.dio});

  static const _baseURL = "/store";

  Future<List<StoreItem>> fetchProduct() async {
    try {
      List<StoreItem> storeProducts = [];
      Response response = await dio.get("$_baseURL/fetch");
      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data;
        for (var storeItem in resData) {
          storeProducts.add(StoreItem.fromJson(storeItem));
        }
      }
      return storeProducts;
    } catch (e) {
      rethrow;
    }
  }

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
  Future<bool> update(StoreItem value) async {
    try {
      Response response = await dio.patch(
        "$_baseURL/update-item-balance/${value.id}",
        data: value.toJson(),
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
      List<StoreItem> products = [];
      PaginationModel pagination = PaginationModel.empty();

      Response response =
          await dio.get("$_baseURL/all?page=$page&size=$pageSize");
      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        var paginationData = response.data['data']['pagination'];
        for (var element in resData) {
          products.add(StoreItem.fromJson(element));
        }
        pagination = PaginationModel.fromMap(paginationData);
      }

      data.pagination = pagination;
      data.items = products;

      return data;
    } on DioException catch (e) {
      LogHelper.logError(e.response!.data);
      rethrow;
    }
  }
}
