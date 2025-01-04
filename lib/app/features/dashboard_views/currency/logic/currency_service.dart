import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../shared/models/api_data.dart';
import '../models/models.dart';

class CurrencyService {
  final Add<Map<String, dynamic>> _addRepository;
  final Update<CurrencyModel> _updateRepository;
  final Delete<int> _deleteRepository;
  final GetAllWithPagination<ApiData> _getAllRepository;

  CurrencyService({
    required Add<Map<String, dynamic>> addRepository,
    required Update<CurrencyModel> updateRepository,
    required Delete<int> deleteRepository,
    required GetAllWithPagination<ApiData> getAllRepository,
  })  : _addRepository = addRepository,
        _updateRepository = updateRepository,
        _deleteRepository = deleteRepository,
        _getAllRepository = getAllRepository;

  Future<ApiData> fetchCurrencies({int page = 1, int size = 50}) async {
    try {
      return await _getAllRepository.getAll(page, size); // Fetch all currencies
    } catch (e) {
      throw Exception('Failed to fetch currencies: $e');
    }
  }

  Future<bool> deleteCurrency(int currencyId) async {
    try {
      return await _deleteRepository.delete(currencyId);
    } catch (e) {
      throw Exception('Failed to delete currency: $e');
    }
  }

  Future<bool> updateCurrency({required CurrencyModel currency}) async {
    try {
      return await _updateRepository.update(currency);
    } catch (e) {
      throw Exception('Failed to update currency: $e');
    }
  }

  Future<bool> addCurrency({
    required Map<String, dynamic> currencyData,
  }) async {
    try {
      return await _addRepository.add(currencyData);
    } catch (e) {
      throw Exception('Failed to add currency: $e');
    }
  }
}
