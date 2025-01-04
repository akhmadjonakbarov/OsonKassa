import 'package:dio/dio.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/exceptions/validador_exceptions.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/network/status_codes.dart';
import '../../../../core/validator/response_validator.dart';
import '../models/company_model.dart';

class CompanyRepository
    implements
        GetAll<CompanyModel>,
        Add<Map<String, dynamic>>,
        Update<CompanyModel>,
        Delete<int> {
  final Dio dio;

  CompanyRepository(this.dio);

  static const String baseUrl = '/shop/company';

  @override
  Future<bool> add(Map<String, dynamic> currencyData) async {
    try {
      Response response = await dio.post(
        '$baseUrl/add/',
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
        '$baseUrl/delete/$id/',
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
  Future<List<CompanyModel>> getAll() async {
    try {
      List<CompanyModel> currencies = [];
      Response response = await dio.get(
        '$baseUrl/all/',
      );

      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var currency in resData) {
            if (ResponseValidator.isMap(currency)) {
              currencies.add(CompanyModel.fromMap(currency));
            } else {
              throw NotMapDataFormat();
            }
          }
        }
        return currencies;
      } else {
        throw Exception(
          'Failed to fetch data with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow; // Rethrow the exception to propagate it up the call stack
    }
  }

  @override
  Future<bool> update(CompanyModel currency) async {
    try {
      Map<String, dynamic> currencyData = {
        'name': currency.name,
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
}
