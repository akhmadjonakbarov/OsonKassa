import '../../../../core/interfaces/api/api_interfaces.dart';
import '../models/company_model.dart';

class CompanyService {
  final Add<Map<String, dynamic>> _addRepository;
  final Update<CompanyModel> _updateRepository;
  final Delete<int> _deleteRepository;
  final GetAll<CompanyModel> _getAllRepository;

  CompanyService({
    required Add<Map<String, dynamic>> addRepository,
    required Update<CompanyModel> updateRepository,
    required Delete<int> deleteRepository,
    required GetAll<CompanyModel> getAllRepository,
  })  : _addRepository = addRepository,
        _updateRepository = updateRepository,
        _deleteRepository = deleteRepository,
        _getAllRepository = getAllRepository;

  Future<List<CompanyModel>> fetchCurrencies() async {
    try {
      return await _getAllRepository.getAll(); // Fetch all currencies
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

  Future<bool> updateCurrency({required CompanyModel currency}) async {
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
