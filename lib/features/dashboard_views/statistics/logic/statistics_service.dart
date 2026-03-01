import '../models/statistic_item_model.dart';
import 'statistics_repository.dart';

class StatisticsService {
  final StatisticsRepository repository;
  StatisticsService(this.repository);

  Future<List<StatisticItemModel>> getStatistics() async {
    return await repository.getStatistics();
  }
}
