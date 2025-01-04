import '../../../core/interfaces/api/get_all.dart';
import '../models/unit_model.dart';

class UnitService {
  final GetAll<UnitModel> _getAllRepo;

  UnitService({required GetAll<UnitModel> getAllRepo})
      : _getAllRepo = getAllRepo;
  Future<List<UnitModel>> getAllUnits() async {
    return await _getAllRepo.getAll();
  }
}
