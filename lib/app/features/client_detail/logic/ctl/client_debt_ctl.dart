import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../models/client_debt_model.dart';
import '../repository/client_debt_repository.dart';
import '../service/client_debt_service.dart';

class ClientDebtCtl extends GetxController {
  var list = <ClientDebtModel>[].obs;
  var isLoading = false.obs;

  late ClientDebtRepository clientDebtRepository;
  late ClientDebtService clientDebtService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    clientDebtRepository = ClientDebtRepository(dio: dio);
    clientDebtService = ClientDebtService(
      clientDebtRepository: clientDebtRepository,
    );
    super.onInit();
  }

  void fetchItems(int clientId) async {
    isLoading(true); // start loading
    try {
      List<ClientDebtModel> debts = await clientDebtService.getAll(clientId);
      list.assignAll(debts); // update list with new debts
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
        type: TypeOfSnackBar.error,
      );
    } finally {
      isLoading(false); // stop loading
    }
  }

  void pay(int debtId, int clientId) async {
    try {
      bool isPaid = await clientDebtService.pay(debtId);
      if (isPaid) {
        fetchItems(clientId); // reload debts if payment was successful
      }
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
        type: TypeOfSnackBar.error,
      );
    }
  }
}
