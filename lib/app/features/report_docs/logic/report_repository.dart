import 'package:dio/dio.dart';

import '../../../core/interfaces/api/api_interfaces.dart';
import '../../../core/network/status_codes.dart';
import '../../../core/validator/response_validator.dart';
import '../models/report_model.dart';

class ReportRepository implements GetAll<ReportModel> {
  final Dio dio;

  ReportRepository({required this.dio});
  static const String _baseURL = "/statistics";
  @override
  Future<List<ReportModel>> getAll() async {
    List<ReportModel> reports = [];
    try {
      Response response = await dio.get('$_baseURL/report');
      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var element in resData) {
            if (ResponseValidator.isMap(element)) {
              reports.add(ReportModel.fromMap(element));
            }
          }
        }
      }

      return reports;
    } catch (e) {
      rethrow;
    }
  }
}
