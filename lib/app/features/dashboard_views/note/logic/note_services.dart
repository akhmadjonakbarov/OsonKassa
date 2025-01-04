import '../../../../core/interfaces/api/get_all.dart';
import '../models/note_model.dart';

class SpiskaService {
  final GetAll<NoteModel> _getAllRepository;

  SpiskaService({
    required GetAll<NoteModel> getAllRepository,
  }) : _getAllRepository = getAllRepository;

  Future<List<NoteModel>> getAllProviders() async {
    try {
      return await _getAllRepository.getAll();
    } catch (e) {
      throw Exception('Failed to fetch providers: $e');
    }
  }
}
