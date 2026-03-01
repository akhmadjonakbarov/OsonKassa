import 'package:dio/dio.dart';

import '../../../core/interfaces/api/get_all.dart';
import '../models/unit.dart';

class UnitRepository implements GetAll<Unit> {
  final Dio dio;
  UnitRepository(this.dio);

  static const String baseUrl = '/unit';

  @override
  Future<List<Unit>> getAll() async {
    try {
      List<Unit> units = [];
      Response response = await dio.get(
        '$baseUrl/all',
      );

      if (response.statusCode == 200) {
        var resData = response.data['data']['list'];
        for (var unit in resData) {
          units.add(Unit.fromMap(unit));
        }
      }
      return units;
    } catch (e) {
      rethrow;
    }
  }
}
