import 'package:dio/dio.dart';
import 'package:osonkassa/features/shared/models/pagination_model.dart';
import '../../../../../utils/helper/log_helper.dart';

import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../../core/network/status_codes.dart';
import '../../../../../core/validator/response_validator.dart';
import '../../../../shared/models/api_data.dart';
import '../../models/document.dart';

class DocumentRepository
    implements
        GetAllWithPagination<ApiData>,
        Add<Map<String, dynamic>>,
        Update,
        Delete<int> {
  final Dio dio;

  DocumentRepository({required this.dio});

  static const String _baseUrl = "/documents";

  @override
  Future<bool> add(productDocData) async {
    try {
      Response response = await dio.post(
        '$_baseUrl/buy',
        data: productDocData,
      );
      return response.statusCode == 201;
    } on DioException catch (e) {
      LogHelper.logError(e.response!.data);
      rethrow;
    }
  }

  @override
  Future<bool> delete(id) async {
    try {
      Response response = await dio.delete('$_baseUrl/delete/$id');
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<List<Document>> getAll() async {
  //   try {
  //     List<Document> productDocs = [];

  //     Response response = await dio.get('$_baseUrl/all');
  //     if (response.statusCode == 200) {
  //       var resData = response.data['data']['list'];

  //       if (ResponseValidator.isNotEmptyAndIsList(resData)) {
  //         for (var productData in resData) {
  //           Document productDoc = Document.fromJson(productData);
  //           productDocs.add(productDoc);
  //         }
  //       }

  //       return productDocs;
  //     } else {
  //       throw Exception(
  //         'Failed to fetch data with status code: ${response.statusCode}',
  //       );
  //     }
  //   } on DioException catch (e) {
  //     LogHelper.logError(e.response!.data);
  //     rethrow;
  //   }
  // }

  @override
  Future update(value) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<ApiData> getAll(int page, int pageSize) async {
    ApiData<Document> data =
        ApiData(pagination: PaginationModel.empty(), items: []);
    try {
      List<Document> documents = [];
      PaginationModel pagination = PaginationModel.empty();
      // Response response = await dio.get(
      //   '$_baseUrl/?page=$page&page_size=$pageSize',
      // );
      Response response = await dio.get(
        '$_baseUrl/',
      );

      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data;
        // var paginationData = response.data['data']['pagination'];
        for (var document in resData) {
          print(document);
          documents.add(Document.fromJson(document));
        }
        // if (ResponseValidator.isMap(paginationData)) {
        //   pagination = PaginationModel.fromMap(paginationData);
        // }

        data.items = documents;
        data.pagination = pagination;

        return data;
      } else {
        throw Exception(
          'Failed to fetch data with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow; // Rethrow the exception to propagate it up the call stack
    }
  }
}
