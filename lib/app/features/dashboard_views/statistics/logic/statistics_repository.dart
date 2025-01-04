import 'package:dio/dio.dart';

import '../../../../core/network/status_codes.dart';
import '../../../../core/validator/response_validator.dart';
import '../models/daily_total_selling_price.dart';
import '../models/statistic_item_model.dart';

class StatisticsRepository {
  final Dio dio;

  StatisticsRepository(this.dio);

  static const String _baseUrl = "/document";
  final String _statistic = "/statistics/all";

  Future<List<StatisticItemModel>> getStatistics() async {
    List<StatisticItemModel> itemList = [];
    try {
      Response response = await dio.get(_statistic);
      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var element in resData) {
            if (ResponseValidator.isMap(element)) {
              StatisticItemModel statisticItemModel = StatisticItemModel(
                name: element['name'].toString(),
                value: double.parse(element['value'].toString()),
              );
              itemList.add(statisticItemModel);
            }
          }
        }
      }
      return itemList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DailyTotalSellingPrice>> getWeeklySellingPrice() async {
    List<DailyTotalSellingPrice> priceList = [];
    try {
      Response response = await dio.get("$_baseUrl/sold");
      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var element in resData) {
            if (ResponseValidator.isMap(element)) {
              priceList.add(DailyTotalSellingPrice.fromMap(element));
            }
          }
        }
      }

      return priceList;
    } catch (e) {
      rethrow;
    }
  }
}
