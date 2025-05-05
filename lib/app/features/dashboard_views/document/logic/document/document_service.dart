import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../models/document_model.dart';

class DocumentService {
  final Add<Map<String, dynamic>> _addRepository;
  final GetAll<Document> _getAllRepository;
  final Delete<int> _deleteRepository;

  DocumentService({
    required Add<Map<String, dynamic>> addRepository,
    required GetAll<Document> getAllRepository,
    required Delete<int> deleteRepository,
  })  : _addRepository = addRepository,
        _getAllRepository = getAllRepository,
        _deleteRepository = deleteRepository;

  Future<List<Document>> getDocuments() async {
    return await _getAllRepository.getAll();
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
