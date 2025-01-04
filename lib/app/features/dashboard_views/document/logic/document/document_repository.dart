import 'package:dio/dio.dart';

import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../../core/network/status_codes.dart';
import '../../../../../core/validator/response_validator.dart';
import '../../models/document_model.dart';

class DocumentRepository
    implements
        GetAll<DocumentModel>,
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
    } on DioException {
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
  Future<List<DocumentModel>> getAll() async {
    try {
      List<DocumentModel> productDocs = [];

      Response response = await dio.get('$_baseUrl/all');
      if (response.statusCode == 200) {
        var resData = response.data['data']['list'];

        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var productData in resData) {
            if (ResponseValidator.isMap(productData)) {
              DocumentModel productDoc = DocumentModel.fromMap(productData);
              productDocs.add(productDoc);
            } else {
              throw Exception('Unexpected data format');
            }
          }
        }

        return productDocs;
      } else {
        throw Exception(
          'Failed to fetch data with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future update(value) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
