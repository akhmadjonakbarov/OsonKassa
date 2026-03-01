import 'trade_repository.dart';

class TradeService {
  TradeRepository repository;
  TradeService(this.repository);
  Future<bool> sell(Map<String, dynamic> sellProductsData) async {
    try {
      return await repository.sell(sellProductsData);
    } catch (e) {
      rethrow;
    }
  }
}
