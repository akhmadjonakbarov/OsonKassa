import 'package:dio/dio.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../models/debt_model.dart';
import 'debt_repository.dart';
import 'debt_service.dart';

class DebtCtl extends MainController<DebtModel> {
  late final DebtRepository debtRepository;
  late final DebtService debtService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    debtRepository = DebtRepository(dio);
    debtService = DebtService(
      getAllRepository: debtRepository as GetAll<DebtModel>,
      updateRepository: debtRepository as Update<int>,
    );
    fetchItems();
    super.onInit();
  }

  @override
  void fetchItems() async {
    try {
      List<DebtModel> debts = await debtService.fetchDebts();
      list(debts);
    } catch (e) {
      handleError(e.toString());
    }
  }

  void searchDebt(String text) async {
    try {
      // Fetch all items from the service
      var debts = await debtService.fetchDebts();

      // Convert the search text to lowercase to make the search case-insensitive
      text = text.toLowerCase();

      // Filter products based on barcode or name
      var filteredDebts = debts.where((debt) {
        final productName = debt.name.toLowerCase();

        // Check if the search text is found in either the product name or the barcode
        return productName.toLowerCase().contains(text.toLowerCase()) ||
            productName.toLowerCase().startsWith(text.toLowerCase());
      }).toList();

      // Update the observable list with the filtered products
      list(filteredDebts);
    } catch (e) {
      handleError(e.toString());
    }
  }

  void pay(int debt_id) async {
    try {
      await debtService.update(debt_id);
      fetchItems();
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  void handleError(String e) {
    UserNotifier.showSnackBar(
      text: e.toString(),
      type: TypeOfSnackBar.error,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
