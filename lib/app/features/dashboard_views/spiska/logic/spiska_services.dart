import '../../../../core/interfaces/api/get_all.dart';
import '../models/spiska_model.dart';

class SpiskaService {
  final GetAll<SpiskaModel> _getAllRepository;

  SpiskaService({
    required GetAll<SpiskaModel> getAllRepository,
  }) : _getAllRepository = getAllRepository;

  Future<List<SpiskaModel>> getAllProviders() async {
    try {
      return await _getAllRepository.getAll();
    } catch (e) {
      throw Exception('Failed to fetch providers: $e');
    }
  }
}
