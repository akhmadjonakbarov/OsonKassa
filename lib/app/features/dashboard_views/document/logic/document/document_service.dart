import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../models/document_model.dart';

class DocumentService {
  final Add<Map<String, dynamic>> _addRepository;
  final GetAll<DocumentModel> _getAllRepository;
  final Delete<int> _deleteRepository;

  DocumentService({
    required Add<Map<String, dynamic>> addRepository,
    required GetAll<DocumentModel> getAllRepository,
    required Delete<int> deleteRepository,
  })  : _addRepository = addRepository,
        _getAllRepository = getAllRepository,
        _deleteRepository = deleteRepository;

  Future<List<DocumentModel>> getAllProductDocs() async {
    try {
      return await _getAllRepository.getAll();
    } catch (e) {
      throw Exception('Failed to fetch ProductDocs: $e');
    }
  }

  Future<bool> addProductDoc(Map<String, dynamic> productDoc) async {
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
