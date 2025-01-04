import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../models/doc_item_model.dart';

class DocItemService {
  final FetchItemsById<DocItemModel> _fetchItemsById;
  final GetAll<DocItemModel> _getAll;
  final Delete<int> _deleteRepository;

  DocItemService(
      {required FetchItemsById<DocItemModel> fetchItemsById,
      required GetAll<DocItemModel> getAll,
      required Delete<int> deleteRepository})
      : _fetchItemsById = fetchItemsById,
        _getAll = getAll,
        _deleteRepository = deleteRepository;

  Future<List<DocItemModel>> fetchProductDocItemsByProductDocId(
      int product_doc_id) async {
    try {
      return await _fetchItemsById.fetchItemsById(product_doc_id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DocItemModel>> fetchItems() async {
    try {
      return await _getAll.getAll();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> delete(int id) async {
    try {
      return await _deleteRepository.delete(id);
    } catch (e) {
      rethrow;
    }
  }
}

class BoughtProductDocItemService {
  final GetAll<DocItemModel> _getAll;

  BoughtProductDocItemService({
    required GetAll<DocItemModel> getAll,
  }) : _getAll = getAll;

  Future<List<DocItemModel>> fetchItems() async {
    try {
      return await _getAll.getAll();
    } catch (e) {
      rethrow;
    }
  }
}
