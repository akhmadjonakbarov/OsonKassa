import '../../../core/interfaces/api/api_interfaces.dart';
import '../models/action_model.dart';

class ActionService {
  final GetAll<ActionModel> _getAllRepository;

  ActionService({
    required GetAll<ActionModel> getAllRepository,
  }) : _getAllRepository = getAllRepository;

  Future<List<ActionModel>> getAllActions() {
    return _getAllRepository.getAll();
  }
}
