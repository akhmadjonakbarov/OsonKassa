import 'package:dio/dio.dart';

import '../../../core/network/status_codes.dart';
import '../models/purchase.dart';

class PurchaseRepository {
  final Dio dio;

  PurchaseRepository({
    required this.dio,
  });

  static const _baseUrl = '/purchase';

  Future<List<Purchase>> getPurchases() async {
    List<Purchase> purchases = [];
    Response response = await dio.get('$_baseUrl/all');
    if (response.statusCode == StatusCodes.OK_200) {
      final purchasesMap = response.data;
      for (var purchase in purchasesMap) {
        purchases.add(Purchase.fromJson(purchase));
      }
    }
    return purchases;
  }

  Future<List<Purchase>> getPurchasesByCustomerId(
      {required int customerId}) async {
    try {
      List<Purchase> purchases = [];
      Response response =
          await dio.get('$_baseUrl/customer-purchases/$customerId');
      if (response.statusCode == StatusCodes.OK_200) {
        final purchasesMap = response.data;
        for (var purchase in purchasesMap) {
          purchases.add(Purchase.fromJson(purchase));
        }
      }
      return purchases;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> pay({required int customerId, required int purchaseId}) async {
    try {
      Response response = await dio.post(
          '$_baseUrl/pay?customer_id=$customerId&purchase_id=$purchaseId');

      return response.statusCode == StatusCodes.OK_200;
    } catch (e) {
      rethrow;
    }
  }
}
