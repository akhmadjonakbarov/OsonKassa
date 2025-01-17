import 'package:dio/dio.dart';
import 'package:osonkassa/app/features/shared/models/api_data.dart';
import 'package:osonkassa/app/features/shared/models/pagination_model.dart';
import 'package:osonkassa/app/features/shared/widgets/pagination.dart';

import '../../../../core/interfaces/api/add.dart';
import '../../../../core/interfaces/api/delete.dart';
import '../../../../core/interfaces/api/get_all.dart';
import '../../../../core/interfaces/api/update.dart';
import '../../../../core/network/status_codes.dart';
import '../models/category_models.dart';

class CategoryRepository
    implements
        GetAllWithPagination<ApiData>,
        Add<Map<String, dynamic>>,
        Update<CategoryModel>,
        Delete<int> {
  final Dio dio;

  CategoryRepository({required this.dio});

  final String _baseURL = "/category";

  // @override
  // Future<List<CategoryModel>> getAll() async {
  //   try {
  //     List<CategoryModel> categories = [];
  //     Response response = await dio.get('$_baseURL/all');
  //     if (response.statusCode == StatusCodes.OK_200) {
  //       var resData = response.data['data']['list'];
  //       for (var element in resData) {
  //         CategoryModel categoryModel = CategoryModel.fromMap(element);
  //         categories.add(categoryModel);
  //       }
  //     }
  //     return categories;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<bool> add(Map<String, dynamic> categoryData) async {
    try {
      Response response = await dio.post(
        '$_baseURL/add',
        data: categoryData,
      );
      return response.statusCode == StatusCodes.CREATED_201;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future update(value) async {
    try {
      Map<String, dynamic> categoryData = {
        'name': value.name,
      };
      await dio.patch('$_baseURL/update/${value.id}', data: categoryData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(id) async {
    try {
      Response response = await dio.delete(
        '$_baseURL/delete/$id/',
      );
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiData> getAll(int page, int pageSize) async {
    ApiData<CategoryModel> data =
        ApiData(items: [], pagination: PaginationModel.empty());
    try {
      List<CategoryModel> categories = [];
      PaginationModel pagination = PaginationModel.empty();
      Response response =
          await dio.get('$_baseURL/all?page=$page&pageSize=$pageSize');
      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        for (var element in resData) {
          CategoryModel categoryModel = CategoryModel.fromMap(element);
          categories.add(categoryModel);
        }
      }
      data.items = categories;
      data.pagination = pagination;
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
