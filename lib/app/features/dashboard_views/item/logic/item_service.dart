import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/interfaces/api/add.dart';
import '../../../../core/interfaces/api/delete.dart';
import '../../../../core/interfaces/api/get_all.dart';
import '../../../../core/interfaces/api/update.dart';
import '../models/item_model.dart';

class ItemService {
  final Add<Map<String, dynamic>> _addRepo;
  final Delete<int> _deleteRepo;
  final GetAll<ItemModel> _getAllRepo;
  final Update<ItemModel> _updateRepo;

  ItemService({
    required Add<Map<String, dynamic>> addRepository,
    required Update<ItemModel> updateRepository,
    required Delete<int> deleteRepository,
    required GetAll<ItemModel> getAllRepository,
  })  : _addRepo = addRepository,
        _updateRepo = updateRepository,
        _deleteRepo = deleteRepository,
        _getAllRepo = getAllRepository;

  Future<bool> addItem(itemData) async {
    try {
      return await _addRepo.add(itemData);
    } on BarcodeAlreadyExistException catch (e) {
      throw BarcodeAlreadyExistException(message: e.message);
    } on InvalidDataException catch (e) {
      throw InvalidDataException(message: e.message);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateItem(ItemModel item) async {
    try {
      return await _updateRepo.update(item);
    } on BarcodeAlreadyExistException catch (e) {
      throw BarcodeAlreadyExistException(message: e.message);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteItem(int id) async {
    return await _deleteRepo.delete(id);
  }

  Future<List<ItemModel>> getAllItems() async {
    return await _getAllRepo.getAll();
  }
}
