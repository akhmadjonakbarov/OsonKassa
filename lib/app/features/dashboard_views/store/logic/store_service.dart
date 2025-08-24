import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../shared/models/api_data.dart';
import '../models/store_item.dart';
import 'store_repository.dart';

class StoreService {
  final GetAllWithPagination<ApiData> _getAllRepository;
  final Delete<int> _deleteRepository;
  final Update<StoreItem> _updateRepository;
  final StoreRepository _storeRepository;

  StoreService(
      {required GetAllWithPagination<ApiData> getAllRepository,
      required Delete<int> deleteRepository,
      required Update<StoreItem> updateRepository,
      required StoreRepository storeRepository})
      : _getAllRepository = getAllRepository,
        _deleteRepository = deleteRepository,
        _storeRepository = storeRepository,
        _updateRepository = updateRepository;

  Future<ApiData> getAll({int page = 1, int pageSize = 50}) async {
    return await _getAllRepository.getAll(page, pageSize);
  }

  Future<bool> delete(int balanceId) async {
    return await _deleteRepository.delete(balanceId);
  }

  Future<bool> update(StoreItem model) async {
    return await _updateRepository.update(model);
  }

  Future<List<StoreItem>> fetchProductsInStore() async {
    return await _storeRepository.fetchProduct();
  }
}
