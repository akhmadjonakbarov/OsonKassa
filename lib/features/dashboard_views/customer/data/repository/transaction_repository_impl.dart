import 'package:dio/dio.dart';
import 'package:osonkassa/features/dashboard_views/customer/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final Dio dio;

  TransactionRepositoryImpl({required this.dio});

  final _baseUrl = "/transactions";

  @override
  Future<bool> payDebt(transactionData) async {
    try {
      final response = await dio.post(_baseUrl, data: transactionData);
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
