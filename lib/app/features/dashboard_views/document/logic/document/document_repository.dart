import 'package:dio/dio.dart';
import 'package:osonkassa/app/core/exceptions/validador_exceptions.dart';
import 'package:osonkassa/app/features/shared/models/pagination_model.dart';
import '../../../../../utils/helper/log_helper.dart';

import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../../core/network/status_codes.dart';
import '../../../../../core/validator/response_validator.dart';
import '../../../../shared/models/api_data.dart';
import '../../models/document_model.dart';

class DocumentRepository
    implements
        GetAllWithPagination<ApiData>,
        Add<Map<String, dynamic>>,
        Update,
        Delete<int> {
  final Dio dio;

  DocumentRepository({required this.dio});

  static const String _baseUrl = "/document";

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
      List<Document> currencies = [];
      PaginationModel pagination = PaginationModel.empty();
      Response response = await dio.get(
        '$_baseUrl/all?page=$page&size=$pageSize',
      );

      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        var paginationData = response.data['data']['pagination'];
        for (var currency in resData) {
          if (ResponseValidator.isMap(currency)) {
            currencies.add(Document.fromJson(currency));
          } else {
            throw NotMapDataFormat();
          }
        }
        if (ResponseValidator.isMap(paginationData)) {
          pagination = PaginationModel.fromMap(paginationData);
        }

        data.items = currencies;
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
