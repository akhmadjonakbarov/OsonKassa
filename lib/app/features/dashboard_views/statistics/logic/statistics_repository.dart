import 'package:dio/dio.dart';
import 'package:osonkassa/app/features/dashboard_views/statistics/models/daily_sales_rate.dart';
import 'package:osonkassa/app/features/dashboard_views/statistics/models/product_count_report.dart';
import 'package:osonkassa/app/features/dashboard_views/statistics/models/weekly_profit.dart';

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

class ProfitRepository {
  final Dio dio;

  ProfitRepository({required this.dio});

  static const _baseUrl = '/statistics/profit';

  Future<List<WeeklyProfit>> getWeeklyProfit() async {
    List<WeeklyProfit> profits = [];
    try {
      Response response = await dio.get("$_baseUrl/week");
      if (response.statusCode == StatusCodes.OK_200) {
        final profitData = response.data;
        for (var profit in profitData) {
          profits.add(WeeklyProfit.fromJson(profit));
        }
      }
      return profits;
    } catch (e) {
      rethrow;
    }
  }
}

class SalesRateRepository {
  final Dio dio;

  SalesRateRepository({required this.dio});

  static const _baseUrl = '/statistics';

  Future<List<DailySaleRate>> getDailySalesRate() async {
    List<DailySaleRate> sales = [];
    try {
      Response response = await dio.get("$_baseUrl/daily-sales-rate");
      if (response.statusCode == StatusCodes.OK_200) {
        final profitData = response.data;
        for (var salesRate in profitData) {
          sales.add(DailySaleRate.fromJson(salesRate));
        }
      }
      return sales;
    } catch (e) {
      rethrow;
    }
  }
}

class GeneralStatisticsRepository {
  final Dio dio;

  GeneralStatisticsRepository({required this.dio});

  static const _baseUrl = '/statistics';

  Future<ProductSummary> getProductsSummary() async {
    try {
      Response response = await dio.get("$_baseUrl/product-price-qty-report");
      if (response.statusCode == StatusCodes.OK_200) {
        return ProductSummary.fromJson(response.data);
      }
      return ProductSummary();
    } catch (e) {
      rethrow;
    }
  }
}
