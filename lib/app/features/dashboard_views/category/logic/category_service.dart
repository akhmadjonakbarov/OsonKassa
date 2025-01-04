import '../../../../core/interfaces/api/add.dart';
import '../../../../core/interfaces/api/delete.dart';
import '../../../../core/interfaces/api/get_all.dart';
import '../../../../core/interfaces/api/update.dart';
import '../../../shared/models/api_data.dart';
import '../models/category_models.dart';

class CategoryService {
  final Add<Map<String, dynamic>> _addRepository;
  final Update<CategoryModel> _updateRepository;
  final Delete<int> _deleteRepository;
  final GetAllWithPagination<ApiData> _getAllRepository;

  CategoryService({
    required Add<Map<String, dynamic>> addRepository,
    required Update<CategoryModel> updateRepository,
    required Delete<int> deleteRepository,
    required GetAllWithPagination<ApiData> getAllRepository,
  })  : _addRepository = addRepository,
        _updateRepository = updateRepository,
        _deleteRepository = deleteRepository,
        _getAllRepository = getAllRepository;

  Future<bool> addCategory(Map<String, dynamic> categoryData) async {
    return await _addRepository.add(categoryData);
  }

  Future<void> updateCategory(CategoryModel category) {
    return _updateRepository.update(category);
  }

  Future<bool> deleteCategory(int id) async {
    return await _deleteRepository.delete(id);
  }

  Future<ApiData> getAllCategories({int page = 1, int pageSize = 50}) {
    return _getAllRepository.getAll(page, pageSize);
  }
}
