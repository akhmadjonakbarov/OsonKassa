import 'package:dio/dio.dart';

import '../../../core/interfaces/api/get_all.dart';
import '../models/unit_model.dart';

class UnitRepository implements GetAll<UnitModel> {
  final Dio dio;
  UnitRepository(this.dio);

  static const String baseUrl = '/shop/unit';

  @override
  Future<List<UnitModel>> getAll() async {
    try {
      List<UnitModel> units = [];
      Response response = await dio.get(
        '$baseUrl/all/',
      );

      if (response.statusCode == 200) {
        var resData = response.data['data']['list'];
        for (var unit in resData) {
          units.add(UnitModel.fromMap(unit));
        }
      }
      return units;
    } catch (e) {
      rethrow;
    }
  }
}
