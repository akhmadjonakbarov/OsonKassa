import 'package:dio/dio.dart';

import '../../../../core/network/status_codes.dart';

class TradeRepository {
  Dio dio;
  TradeRepository(this.dio);

  static const String _baseURL = "/shop/document/sell/";
  Future<bool> sell(Map<String, dynamic> sellProductsData) async {
    try {
      Response response = await dio.post(_baseURL, data: sellProductsData);
      return response.statusCode == StatusCodes.CREATED_201;
    } on DioException {
      rethrow;
    }
  }
}
