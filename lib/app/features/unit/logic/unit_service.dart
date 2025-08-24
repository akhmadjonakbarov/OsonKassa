import '../../../core/interfaces/api/get_all.dart';
import '../models/unit.dart';

class UnitService {
  final GetAll<Unit> _getAllRepo;

  UnitService({required GetAll<Unit> getAllRepo}) : _getAllRepo = getAllRepo;
  Future<List<Unit>> getAllUnits() async {
    return await _getAllRepo.getAll();
  }
}
