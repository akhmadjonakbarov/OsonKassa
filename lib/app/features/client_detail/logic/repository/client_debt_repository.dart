import 'package:dio/dio.dart';

import '../../../../core/network/status_codes.dart';
import '../../../../core/validator/response_validator.dart';
import '../../models/client_debt_model.dart';

class ClientDebtRepository {
  final Dio dio;
  ClientDebtRepository({
    required this.dio,
  });

  final _baseURL = "/client/statistics";

  Future<List<ClientDebtModel>> getAll(int client_id) async {
    List<ClientDebtModel> debts = [];
    try {
      Response response = await dio.get("$_baseURL/$client_id/debts/");
      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var element in resData) {
            if (ResponseValidator.isMap(element)) {
              debts.add(ClientDebtModel.fromMap(element));
            }
          }
        }
      }
      return debts;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> pay(int debt_id) async {
    try {
      Response response = await dio.patch("$_baseURL/debts/$debt_id/pay/");
      return response.statusCode == StatusCodes.ACCEPTED_202;
    } catch (e) {
      rethrow;
    }
  }
}
