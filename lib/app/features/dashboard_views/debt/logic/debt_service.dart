import '../../../../core/interfaces/api/api_interfaces.dart';
import '../models/builder_debt_model.dart';
import '../models/debt_model.dart';

class DebtService {
  final GetAll<DebtModel> _getAllRepository;
  final Update<int> _updateRepository;
  DebtService({
    required GetAll<DebtModel> getAllRepository,
    required Update<int> updateRepository,
  })  : _getAllRepository = getAllRepository,
        _updateRepository = updateRepository;

  Future<List<DebtModel>> fetchDebts() async {
    return await _getAllRepository.getAll();
  }

  Future<bool> update(int debt_id) async {
    return await _updateRepository.update(debt_id);
  }
}

class BuilderDebtService {
  final FetchItemsById<BuilderDebt> _fetchItemsById;
  final Update<int> _updateRepository;

  BuilderDebtService({
    required FetchItemsById<BuilderDebt> fetchItemsById,
    required Update<int> updateRepository,
  })  : _fetchItemsById = fetchItemsById,
        _updateRepository = updateRepository;

  Future<List<BuilderDebt>> getAll(int id) async {
    return await _fetchItemsById.fetchItemsById(id);
  }

  Future<bool> update(int debt_id) async {
    return await _updateRepository.update(debt_id);
  }
}
