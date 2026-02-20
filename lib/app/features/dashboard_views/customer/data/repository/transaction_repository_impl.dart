import 'package:dio/dio.dart';
import 'package:osonkassa/app/features/dashboard_views/customer/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final Dio dio;

  TransactionRepositoryImpl({required this.dio});

  final _baseUrl = "/transactions";

  @override
  Future<bool> payDebt(transactionData) async {
    try {
      final response = await dio.post(_baseUrl, data: transactionData);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
