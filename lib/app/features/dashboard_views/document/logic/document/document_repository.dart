import 'package:dio/dio.dart';
import '../../../../../utils/helper/log_helper.dart';

import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../../core/network/status_codes.dart';
import '../../../../../core/validator/response_validator.dart';
import '../../models/document_model.dart';

class DocumentRepository
    implements
        GetAll<Document>,
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

  @override
  Future<List<Document>> getAll() async {
    try {
      List<Document> productDocs = [];

      Response response = await dio.get('$_baseUrl/all');
      if (response.statusCode == 200) {
        var resData = response.data['data']['list'];

        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var productData in resData) {
            Document productDoc = Document.fromJson(productData);
            productDocs.add(productDoc);
          }
        }

        return productDocs;
      } else {
        throw Exception(
          'Failed to fetch data with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      LogHelper.logError(e.response!.data);
      rethrow;
    }
  }

  @override
  Future update(value) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
