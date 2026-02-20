import 'package:get/get.dart';
import 'package:osonkassa/app/config/dio_provider.dart';

import 'package:osonkassa/app/features/dashboard_views/customer/data/repository/transaction_repository_impl.dart';
import 'package:osonkassa/app/features/dashboard_views/customer/domain/repositories/transaction_repository.dart';
import 'package:osonkassa/app/features/dashboard_views/customer/view/controllers/transaction_event.dart';

class TransactionController extends GetxController {
  late TransactionRepository transactionRepository;

  Rxn<TransactionEvent> transactionEvents = Rxn<TransactionEvent>();

  @override
  void onInit() {
    super.onInit();
    final dio = DioProvider().createDio();
    transactionRepository = TransactionRepositoryImpl(dio: dio);
  }

  payDebt({required Map<String, dynamic> transactionData}) async {
    final result = await transactionRepository.payDebt(transactionData);
    if (result) {
      transactionEvents.value = TransactionCreated();
    }
  }

  getTransactions() async {}
}
