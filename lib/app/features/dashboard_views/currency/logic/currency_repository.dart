import 'package:dio/dio.dart';
import 'package:osonkassa/app/features/shared/models/api_data.dart';
import 'package:osonkassa/app/features/shared/models/pagination_model.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/exceptions/validador_exceptions.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/network/status_codes.dart';
import '../../../../core/validator/response_validator.dart';
import '../models/models.dart';

class CurrencyRepository
    implements
        GetAllWithPagination<ApiData>,
        Add<Map<String, dynamic>>,
        Update<CurrencyModel>,
        Delete<int> {
  final Dio dio;

  CurrencyRepository(this.dio);

  static const String baseUrl = '/currency';

  @override
  Future<bool> add(Map<String, dynamic> currencyData) async {
    try {
      Response response = await dio.post(
        '$baseUrl/add',
        data: currencyData,
      );
      return response.statusCode == 201;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      Response response = await dio.delete(
        '$baseUrl/delete/$id',
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response!.statusCode == StatusCodes.NOT_FOUND_404) {
        throw DataNotFoundException(
          message: e.response!.data['data']['message'].toString(),
        );
      }
      rethrow;
    }
  }

  @override
  Future<bool> update(CurrencyModel currency) async {
    try {
      Map<String, dynamic> currencyData = {
        'value': currency.value,
      };
      Response response = await dio.patch(
        '$baseUrl/update/${currency.id}/',
        data: currencyData,
      );
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiData> getAll(int page, int pageSize) async {
    ApiData<CurrencyModel> data =
        ApiData(pagination: PaginationModel.empty(), items: []);
    try {
      List<CurrencyModel> currencies = [];
      PaginationModel pagination = PaginationModel.empty();
      Response response = await dio.get(
        '$baseUrl/all?page=$page&size=$pageSize',
      );

      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        var paginationData = response.data['data']['pagination'];
        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var currency in resData) {
            if (ResponseValidator.isMap(currency)) {
              currencies.add(CurrencyModel.fromMap(currency));
            } else {
              throw NotMapDataFormat();
            }
          }
        }
        if (ResponseValidator.isMap(paginationData)) {
          pagination = PaginationModel.fromMap(paginationData);
        }

        data.items = currencies;
        data.pagination = pagination;

        return data;
      } else {
        throw Exception(
          'Failed to fetch data with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow; // Rethrow the exception to propagate it up the call stack
    }
  }
}
