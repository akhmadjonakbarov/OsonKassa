import 'package:dio/dio.dart';

import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/network/status_codes.dart';
import '../../../../core/validator/response_validator.dart';
import '../models/debt_model.dart';

const String _baseUrl = '/debt'; // Replace with your API base URL

class DebtRepository implements GetAll<DebtModel>, Update<int> {
  final Dio dio;

  DebtRepository(this.dio);
  @override
  Future<List<DebtModel>> getAll() async {
    try {
      List<DebtModel> debts = [];
      Response response = await dio.get(
        '$_baseUrl/all',
      );

      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var element in resData) {
            if (ResponseValidator.isMap(element)) {
              debts.add(DebtModel.fromMap(element));
            }
          }
        }
      }
      return debts;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> update(int debt_id) async {
    try {
      Response response = await dio.patch(
        '$_baseUrl/pay/$debt_id',
      );
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }
}
