import 'package:dio/dio.dart';
import 'package:osonkassa/features/dashboard_views/type/domain/repository/type_repository.dart';
import 'package:osonkassa/features/dashboard_views/type/domain/models/type.dart';
import '../../../../../core/network/status_codes.dart';
import '../../../../../core/validator/response_validator.dart';
import '../../../../shared/models/api_data.dart';
import '../../../../shared/models/pagination_model.dart';

class TypeRepositoryImpl extends TypeRepository {
  final Dio dio;

  TypeRepositoryImpl({required this.dio});

  final String _baseURL = "/types";

  @override
  Future<ApiData> getTypes({required int page, int pageSize = 20}) async {
    ApiData<Type_> data =
        ApiData(items: [], pagination: PaginationModel.empty());
    List<Type_> categories = [];
    PaginationModel pagination = PaginationModel.empty();
    try {
      Response response =
          await dio.get('$_baseURL/all?page=$page&pageSize=$pageSize');
      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        var paginationData = response.data['data']['pagination'];
        for (var element in resData) {
          Type_ type = Type_.fromJson(element);
          categories.add(type);
        }
        if (ResponseValidator.isMap(paginationData)) {
          pagination = PaginationModel.fromMap(paginationData);
        }
      }
      data.items = categories;
      data.pagination = pagination;
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteType(int id) {
    // TODO: implement deleteType
    throw UnimplementedError();
  }

  @override
  Future<bool> saveType(String name) async {
    try {
      Response response = await dio.post('$_baseURL/add', data: {
        "name": name,
      });
      if (response.statusCode == StatusCodes.CREATED_201) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateType(Type type) {
    // TODO: implement updateType
    throw UnimplementedError();
  }
}
