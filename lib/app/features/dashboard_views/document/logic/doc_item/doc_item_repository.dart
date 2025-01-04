import 'package:dio/dio.dart';

import '../../../../../../main.dart';
import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../../core/network/status_codes.dart';
import '../../../../../core/validator/response_validator.dart';
import '../../models/doc_item_model.dart';

class DocItemRepository
    implements GetAll<DocItemModel>, FetchItemsById<DocItemModel>, Delete<int> {
  final Dio dio;

  DocItemRepository(this.dio);

  static const String _baseUrl = "/doc-item";

  @override
  Future<List<DocItemModel>> fetchItemsById(int id) async {
    try {
      List<DocItemModel> product_doc_items = [];
      Response response = await dio.get("$_baseUrl/all?document_id=$id");

      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        for (var itemData in resData) {
          DocItemModel productDocItem = DocItemModel.fromMap(itemData);
          product_doc_items.add(productDocItem);
        }
      }
      return product_doc_items;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<List<DocItemModel>> getAll() async {
    try {
      List<DocItemModel> product_doc_items = [];
      Response response = await dio.get("$_baseUrl/all");

      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var itemData in resData) {
            if (ResponseValidator.isMap(itemData)) {
              DocItemModel productDocItem = DocItemModel.fromMap(itemData);
              product_doc_items.add(productDocItem);
            }
          }
        }
      }
      return product_doc_items;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      Response response = await dio.delete("$_baseUrl/delete/$id/");
      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }
}

class BoughtProductDocItemRepository {
  final Dio dio;

  BoughtProductDocItemRepository(this.dio);

  static const String _baseUrl = "/doc-item/all";

  Future<List<DocItemModel>> getByDocumentId(int document_id) async {
    try {
      List<DocItemModel> product_doc_items = [];
      Response response =
          await dio.get("$_baseUrl/all?document_id=$document_id");
      if (response.statusCode == StatusCodes.OK_200) {
        var resData = response.data['data']['list'];
        if (ResponseValidator.isNotEmptyAndIsList(resData)) {
          for (var itemData in resData) {
            if (ResponseValidator.isMap(itemData)) {
              DocItemModel productDocItem = DocItemModel.fromMap(itemData);
              product_doc_items.add(productDocItem);
            }
          }
        }
      }
      return product_doc_items;
    } on DioException catch (e) {
      AppLogger.instance.info(
        e.response!.data,
      );
      rethrow;
    }
  }
}
