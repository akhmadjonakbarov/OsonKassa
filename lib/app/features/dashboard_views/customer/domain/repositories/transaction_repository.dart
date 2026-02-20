abstract class TransactionRepository {
  Future<bool> payDebt(Map<String, dynamic> transactionData);
}
