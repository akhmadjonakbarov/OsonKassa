import 'package:osonkassa/app/features/shared/models/api_data.dart';

abstract class TypeRepository {
  Future<ApiData> getTypes({required int page, int pageSize = 20});

  Future<bool> saveType(String name);

  Future<bool> deleteType(int id);

  Future<bool> updateType(Type type);
}
