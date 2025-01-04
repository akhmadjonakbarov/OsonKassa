import '../../../../core/interfaces/api/api_interfaces.dart';
import '../models/client_model.dart';

class ClientService {
  final Add<Map<String, dynamic>> _addRepository;
  final Update<CustomerModel> _updateRepository;
  final Delete<int> _deleteRepository;
  final GetAll<CustomerModel> _getAllRepository;

  ClientService({
    required Add<Map<String, dynamic>> addRepository,
    required Update<CustomerModel> updateRepository,
    required Delete<int> deleteRepository,
    required GetAll<CustomerModel> getAllRepository,
  })  : _addRepository = addRepository,
        _updateRepository = updateRepository,
        _deleteRepository = deleteRepository,
        _getAllRepository = getAllRepository;

  Future<List<CustomerModel>> getAllClient() async {
    try {
      return await _getAllRepository.getAll();
    } catch (e) {
      throw Exception('Failed to fetch client: $e');
    }
  }

  Future<bool> deleteClient(int id) async {
    try {
      return await _deleteRepository.delete(id);
    } catch (e) {
      throw Exception('Failed to delete client: $e');
    }
  }

  Future<CustomerModel?> updateClient({required CustomerModel client}) async {
    try {
      return await _updateRepository.update(client);
    } catch (e) {
      throw Exception('Failed to update client: $e');
    }
  }

  Future<bool> addClient({required Map<String, dynamic> clientData}) async {
    try {
      return await _addRepository.add(clientData);
    } catch (e) {
      throw Exception('Failed to add client: $e');
    }
  }
}
