import 'package:dio/dio.dart';
import 'package:get/get.dart';

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
  var statistics_list = <StatisticItemModel>[].obs;
  var cachedList = <DailyTotalSellingPrice>[].obs;

  var weekly_total_profit = 0.0.obs;
  var weekly_selling_rate = 0.0.obs;

  var monthly_total_profit = 0.0.obs;
  var monthly_selling_rate = 0.0.obs;

  var total_profit = 0.0;
  var total_value_of_products_uzs = 0.0.obs;
  var total_value_of_products_usd = 0.0.obs;

  late StatisticsService statisticsService;
  late StatisticsRepository statisticsRepository;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    statisticsRepository = StatisticsRepository(dio);
    statisticsService = StatisticsService(statisticsRepository);

    super.onInit();
  }

  fetchWeeklyPriceStatistics() async {
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

  bool areListsEqual(
      List<DailyTotalSellingPrice> list1, List<DailyTotalSellingPrice> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  fetchStatistics() async {
    isLoading(true);
    try {
      List<StatisticItemModel> statisticList =
          await statisticsService.getStatistics();
      var profit_for_months = statisticList.firstWhere(
        (element) => element.name.contains('total_profit'),
      );
      var total_value_of_products_uzs_item = statisticList.firstWhere(
        (element) => element.name.contains('total_value_of_products_uzs'),
      );
      var total_value_of_products_usd_item = statisticList.firstWhere(
        (element) => element.name.contains('total_value_of_products_usd'),
      );

      total_profit = profit_for_months.value;
      total_value_of_products_uzs.value =
          total_value_of_products_uzs_item.value;
      total_value_of_products_usd.value =
          total_value_of_products_usd_item.value;
      statistics_list(statisticList);
      update();
    } catch (e) {
      UserNotifier.showSnackBar(text: e.toString(), type: TypeOfSnackBar.error);
    } finally {
      isLoading(false);
    }
  }
}
