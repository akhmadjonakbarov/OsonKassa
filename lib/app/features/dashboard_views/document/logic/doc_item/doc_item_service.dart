import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../models/document_item.dart';

class DocItemService {
  final FetchItemsById<DocumentItem> _fetchItemsById;
  final GetAll<DocumentItem> _getAll;
  final Delete<int> _deleteRepository;

  DocItemService(
      {required FetchItemsById<DocumentItem> fetchItemsById,
      required GetAll<DocumentItem> getAll,
      required Delete<int> deleteRepository})
      : _fetchItemsById = fetchItemsById,
        _getAll = getAll,
        _deleteRepository = deleteRepository;

  Future<List<DocumentItem>> fetchProductDocItemsByProductDocId(
      int product_doc_id) async {
    try {
      return await _fetchItemsById.fetchItemsById(product_doc_id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DocumentItem>> fetchItems() async {
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
  final GetAll<DocumentItem> _getAll;

  BoughtProductDocItemService({
    required GetAll<DocumentItem> getAll,
  }) : _getAll = getAll;

  Future<List<DocumentItem>> fetchItems() async {
    try {
      return await _getAll.getAll();
    } catch (e) {
      rethrow;
    }
  }
}
