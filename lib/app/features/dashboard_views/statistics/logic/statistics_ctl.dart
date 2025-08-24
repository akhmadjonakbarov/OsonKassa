import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../styles/chart_colors.dart';
import '../models/daily_total_selling_price.dart';
import '../models/product_count_report.dart';
import '../models/daily_sales_rate.dart';
import '../models/weekly_profit.dart';
import 'statistics_repository.dart';
import 'statistics_service.dart';

class StatisticsCtl extends GetxController {
  // Loading states
  var isLoading = false.obs;
  var isWeeklyProfitLoading = false.obs;
  var isProductSummaryLoading = false.obs;
  final isChartReady = false.obs;

  // Data
  var weeklyProfits = <WeeklyProfit>[].obs;
  var dailySalesRates = <DailySaleRate>[].obs;
  var weeklyPrices = <DailyTotalSellingPrice>[].obs;
  var productSummary = ProductSummary().obs;
  List<BarChartGroupData> barGroups = <BarChartGroupData>[];

  // Aggregates
  var totalWeeklyProfit = 0.0.obs;
  var weeklyTotalProfit = 0.0.obs;
  var weeklySellingRate = 0.0.obs;

  // Repositories
  late StatisticsService statisticsService;
  late ProfitRepository profitRepository;
  late SalesRateRepository salesRateRepository;
  late GeneralStatisticsRepository generalStatisticsRepository;

  @override
  void onInit() {
    super.onInit();
    final dio = DioProvider().createDio();

    generalStatisticsRepository = GeneralStatisticsRepository(dio: dio);
    profitRepository = ProfitRepository(dio: dio);
    salesRateRepository = SalesRateRepository(dio: dio);
    statisticsService = StatisticsService(StatisticsRepository(dio));
    barGroups.add(makeGroupData(
      0,
      0.0,
      0.0,
    ));
    loadAllStatistics();
  }

  Future<void> loadAllStatistics() async {
    await Future.wait([getWeeklyProfits(), getProductsQty(), prepareChart()]);
  }

  Future<void> getWeeklyProfits() async {
    isWeeklyProfitLoading(true);
    try {
      final profits = await profitRepository.getWeeklyProfit();

      // Use compute for heavy aggregation
      final total = await compute(
        (list) => list.fold<double>(
          0,
          (sum, e) => sum + (e.profit ?? 0),
        ),
        profits,
      );

      weeklyProfits(profits);
      totalWeeklyProfit(total);
    } catch (e) {
      UserNotifier.showSnackBar(text: e.toString(), type: TypeOfSnackBar.error);
    } finally {
      isWeeklyProfitLoading(false);
    }
  }

  Future<void> prepareChart() async {
    isChartReady(false);
    await getDailySalesRates();
    Future.delayed(Duration(milliseconds: 2000));
    await createBarGroups();
    isChartReady(true);
  }

  Future<void> getDailySalesRates() async {
    try {
      final sales = await salesRateRepository.getDailySalesRate();
      dailySalesRates(sales);
    } catch (e) {
      UserNotifier.showSnackBar(text: e.toString(), type: TypeOfSnackBar.error);
    }
  }

  Future<void> createBarGroups() async {
    barGroups.clear();
    for (int i = 0; i < dailySalesRates.length; i++) {
      barGroups.add(
        makeGroupData(
          i,
          dailySalesRates[i].sales!,
          dailySalesRates[i].profit!,
        ),
      );
    }
  }

  BarChartGroupData makeGroupData(int x, double price, double profit) {
    Color leftBarColor = ChartColors.contentColorYellow;

    Color rightBarColor = ChartColors.contentColorGreen;
    return BarChartGroupData(
      barsSpace: 10,
      x: x,
      barRods: [
        BarChartRodData(
          toY: price / 1000,
          color: leftBarColor, // For price
          width: 10,
        ),
        BarChartRodData(
          toY: profit / 1000,
          color: rightBarColor, // For profit
          width: 10,
        ),
      ],
    );
  }

  Future<void> getProductsQty() async {
    isProductSummaryLoading(true);
    try {
      final summary = await generalStatisticsRepository.getProductsSummary();
      productSummary(summary);
    } catch (e) {
      UserNotifier.showSnackBar(text: e.toString(), type: TypeOfSnackBar.error);
    } finally {
      isProductSummaryLoading(false);
    }
  }

  // Future<void> getWeeklyPriceStatistics() async {
  //   isLoading(true);
  //   try {
  //     final priceList = await statisticsService.getWeeklyPriceStatistics();
  //     weeklyPrices(priceList);

  //     // Aggregate with compute
  //     final totals = await compute(_aggregateWeeklyTotals, priceList);
  //     weeklyTotalProfit(totals['profit']!);
  //     weeklySellingRate(totals['selling']!);
  //   } catch (e) {
  //     UserNotifier.showSnackBar(text: e.toString(), type: TypeOfSnackBar.error);
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Isolated function for compute
  static Map<String, double> _aggregateWeeklyTotals(
      List<DailyTotalSellingPrice> items) {
    final profit = items.fold<double>(0, (sum, e) => sum + e.profit);
    final selling = items.fold<double>(0, (sum, e) => sum + e.price);
    return {'profit': profit, 'selling': selling};
  }
}
