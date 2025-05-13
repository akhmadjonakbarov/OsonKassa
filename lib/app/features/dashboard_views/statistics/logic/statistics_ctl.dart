import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/statistics/models/daily_sales_rate.dart';
import 'package:osonkassa/app/features/dashboard_views/statistics/models/product_count_report.dart';
import 'package:osonkassa/app/features/dashboard_views/statistics/models/weekly_profit.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../models/daily_total_selling_price.dart';
import '../models/statistic_item_model.dart';
import 'statistics_repository.dart';
import 'statistics_service.dart';

class StatisticsCtl extends GetxController {
  var isLoading = false.obs;
  var isLoadingList = false.obs;
  var list = <DailyTotalSellingPrice>[].obs;
  var productSummary = ProductSummary().obs;
  var weeklyProfits = <WeeklyProfit>[].obs;
  var dailySalesRates = <DailySaleRate>[].obs;
  var cachedList = <DailyTotalSellingPrice>[].obs;
  var totalWeeklyProfit = 0.0.obs;

  var weekly_total_profit = 0.0.obs;
  var weekly_selling_rate = 0.0.obs;

  var monthly_total_profit = 0.0.obs;
  var monthly_selling_rate = 0.0.obs;

  var total_profit = 0.0;
  var total_value_of_products_uzs = 0.0.obs;
  var total_value_of_products_usd = 0.0.obs;

  late StatisticsService statisticsService;
  late StatisticsRepository statisticsRepository;

  // profit
  late ProfitRepository profitRepository;
  late SalesRateRepository salesRateRepository;
  late GeneralStatisticsRepository generalStatisticsRepository;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    generalStatisticsRepository = GeneralStatisticsRepository(dio: dio);
    profitRepository = ProfitRepository(dio: dio);
    salesRateRepository = SalesRateRepository(dio: dio);
    statisticsRepository = StatisticsRepository(dio);
    statisticsService = StatisticsService(statisticsRepository);
    loadAllStatistics();

    super.onInit();
  }

  loadAllStatistics() {
    getDailySalesRates();
    getWeeklyProfits();
    getProductsQty();
  }

  getWeeklyProfits() async {
    final profits = await profitRepository.getWeeklyProfit();
    final profit = profits.fold(
      0.0,
      (previousValue, element) =>
          previousValue = previousValue + element.profit!,
    );
    totalWeeklyProfit(profit);
    weeklyProfits(profits);
  }

  getDailySalesRates() async {
    final sales = await salesRateRepository.getDailySalesRate();
    dailySalesRates(sales);
  }

  getProductsQty() async {
    final summary = await generalStatisticsRepository.getProductsSummary();
    productSummary(summary);
  }

  getWeeklyPriceStatistics() async {
    isLoadingList(true);
    try {
      // Reset values to zero before processing
      weekly_total_profit(0);
      weekly_selling_rate(0);

      // Fetch data and update list once
      List<DailyTotalSellingPrice> priceList =
          await statisticsService.getWeeklyPriceStatistics();
      list(priceList);

      // Use fold to aggregate values for profit and selling rate
      weekly_total_profit.value =
          priceList.fold(0, (sum, item) => sum + item.profit);
      weekly_selling_rate.value =
          priceList.fold(0, (sum, item) => sum + item.price);
    } catch (e) {
      UserNotifier.showSnackBar(text: e.toString(), type: TypeOfSnackBar.error);
    } finally {
      isLoadingList(false);
    }
  }
}
