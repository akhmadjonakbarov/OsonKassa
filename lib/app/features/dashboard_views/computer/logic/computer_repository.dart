import 'package:dio/dio.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../shared/models/api_data.dart';

import '../../../../core/exceptions/validador_exceptions.dart';
import '../../../../core/network/status_codes.dart';
import '../../../../core/validator/response_validator.dart';
import '../../../shared/models/pagination_model.dart';
import '../../currency/models/models.dart';

class ComputerRepository extends GetAllWithPagination<ApiData> {
  final Dio dio;

  ComputerRepository({required this.dio});

  static const String baseUrl = '/computers';

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
