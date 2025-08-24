import 'package:dio/dio.dart';

import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../../core/network/status_codes.dart';
import '../../models/document_item.dart';

class DocItemRepository
    implements GetAll<DocumentItem>, FetchItemsById<DocumentItem>, Delete<int> {
  final Dio dio;

  DocItemRepository(this.dio);

  static const String _baseUrl = "/doc-item";

  @override
  Future<List<DocumentItem>> fetchItemsById(int id) async {
    try {
      List<DocumentItem> documentItems = [];
      Response response = await dio.get("$_baseUrl/all?document_id=$id");

      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        for (var itemData in resData) {
          DocumentItem productDocItem = DocumentItem.fromJson(itemData);
          documentItems.add(productDocItem);
        }
      }
      return documentItems;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<List<DocumentItem>> getAll() async {
    try {
      List<DocumentItem> documentItems = [];
      Response response = await dio.get("$_baseUrl/all");

      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        for (var itemData in resData) {
          DocumentItem productDocItem = DocumentItem.fromJson(itemData);
          documentItems.add(productDocItem);
        }
      }
      return documentItems;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      Response response = await dio.delete("$_baseUrl/delete/$id");
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }
}
