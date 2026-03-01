import 'package:osonkassa/features/dashboard_views/customer/domain/models/transaction.dart';

abstract class TransactionRepository {
  Future<bool> payDebt(Map<String, dynamic> transactionData);
}
