import 'package:osonkassa/app/features/shared/models/api_data.dart';

import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../document/models/doc_item_model.dart';

class StoreService {
  final GetAllWithPagination<ApiData> _getAllRepository;
  final Delete<int> _deleteRepository;
  final Update<DocItemModel> _updateRepository;

  StoreService(
      {required GetAllWithPagination<ApiData> getAllRepository,
      required Delete<int> deleteRepository,
      required Update<DocItemModel> updateRepository})
      : _getAllRepository = getAllRepository,
        _deleteRepository = deleteRepository,
        _updateRepository = updateRepository;

  Future<ApiData> getAll({int page = 1, int pageSize = 50}) async {
    return await _getAllRepository.getAll(page, pageSize);
  }

  Future<bool> delete(int balance_id) async {
    return await _deleteRepository.delete(balance_id);
  }

  Future<bool> update(DocItemModel model) async {
    return await _updateRepository.update(model);
  }
}
