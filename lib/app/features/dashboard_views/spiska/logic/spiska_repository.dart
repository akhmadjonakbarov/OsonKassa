import 'package:dio/dio.dart';

import '../../../../core/interfaces/api/get_all.dart';
import '../models/spiska_model.dart';

class SpiskaRepository implements GetAll<SpiskaModel> {
  final Dio dio;

  SpiskaRepository({required this.dio});

  static const String baseUrl = '/notes'; // Replace with your API base URL

  @override
  Future<List<SpiskaModel>> getAll() async {
    try {
      List<SpiskaModel> spikas = [];
      Response response = await dio.get(
        '$baseUrl/all',
      );

      if (response.statusCode == 200) {
        var resData = response.data['data']['list'];
        for (var provider in resData) {
          spikas.add(SpiskaModel.fromMap(provider));
        }
      }
      return spikas;
    } catch (e) {
      rethrow; // Rethrow the exception to propagate it up the call stack
    }
  }
}
