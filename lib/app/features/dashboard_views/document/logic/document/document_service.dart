import 'package:osonkassa/app/features/shared/models/api_data.dart';

import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../models/document_model.dart';

class DocumentService {
  final Add<Map<String, dynamic>> _addRepository;
  final GetAllWithPagination<ApiData> _getAllRepository;
  final Delete<int> _deleteRepository;

  DocumentService({
    required Add<Map<String, dynamic>> addRepository,
    required GetAllWithPagination<ApiData> getAllRepository,
    required Delete<int> deleteRepository,
  })  : _addRepository = addRepository,
        _getAllRepository = getAllRepository,
        _deleteRepository = deleteRepository;

  Future<ApiData> getDocuments({int page = 1, int size = 30}) async {
    try {
      return await _getAllRepository.getAll(page, size); // Fetch all currencies
    } catch (e) {
      throw Exception('Failed to fetch currencies: $e');
    }
  }

  Future<bool> addDocument(Map<String, dynamic> productDoc) async {
    try {
      return await _addRepository.add(productDoc);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteProductDoc(int productDocId) async {
    try {
      return await _deleteRepository.delete(productDocId);
    } catch (e) {
      rethrow;
    }
  }
}
