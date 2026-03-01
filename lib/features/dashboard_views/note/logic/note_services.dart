import '../../../../core/interfaces/api/get_all.dart';
import '../models/note.dart';

class SpiskaService {
  final GetAll<Note> _getAllRepository;

  SpiskaService({
    required GetAll<Note> getAllRepository,
  }) : _getAllRepository = getAllRepository;

  Future<List<Note>> getAllProviders() async {
    try {
      return await _getAllRepository.getAll();
    } catch (e) {
      throw Exception('Failed to fetch providers: $e');
    }
  }
}
