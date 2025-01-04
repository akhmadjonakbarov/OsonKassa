import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../../../../utils/texts/alert_texts.dart';
import '../../../shared/models/api_data.dart';
import '../models/models.dart';
import 'currency_repository.dart';
import 'currency_service.dart';

class CurrencyCtl extends MainController<CurrencyModel> {
  var selectedCurrency = CurrencyModel.empty().obs;

  late final CurrencyRepository currencyRepository;
  late final CurrencyService currencyService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    currencyRepository = CurrencyRepository(dio);
    currencyService = CurrencyService(
      addRepository: currencyRepository as Add<Map<String, dynamic>>,
      updateRepository: currencyRepository as Update<CurrencyModel>,
      deleteRepository: currencyRepository as Delete<int>,
      getAllRepository: currencyRepository as GetAllWithPagination<ApiData>,
    );
    super.onInit();
  }

  void resetCurrency() {
    selectedCurrency.value = CurrencyModel.empty();
  }

  @override
  void fetchItems() async {
    try {
      isLoading(true);
      var apiCurrencies =
          await currencyService.fetchCurrencies(page: page.value);
      list(apiCurrencies.items.cast<CurrencyModel>());
      pagination(apiCurrencies.pagination);
      isLoading(false);
    } catch (e) {
      handleError(e.toString());
    }
  }

  void selectPage(int page_value) {
    page(page_value);

    fetchItems();
  }

  void selectCurrency(CurrencyModel currency) {
    selectedCurrency(currency);
  }

  void searchCurrency(String text) async {
    try {
      // Fetch all items from the service
      var currency = await currencyService.fetchCurrencies();

      text = text.toLowerCase();

      // Filter products based on barcode or name
      var filteredCurrencies = currency.items.where((product) {
        final productName = product.value;
        // Check if the search text is found in either the product name or the barcode
        return productName.toString().contains(text.toString());
      }).toList();
      // Update the observable list with the filtered products
      list(filteredCurrencies.cast<CurrencyModel>());
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  void addItem(item) async {
    try {
      bool isSuccess = await currencyService.addCurrency(
        currencyData: item,
      );
      if (isSuccess) {
        UserNotifier.showSnackBar(
          label: "${item['value']} ${AlertTexts.created}",
          type: TypeOfSnackBar.success,
        );
        fetchItems();
      }
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  void handleError(String e) {
    UserNotifier.showSnackBar(
      label: e,
      type: TypeOfSnackBar.error,
    );
  }

  @override
  void removeItem(int id) async {
    try {
      await currencyService.deleteCurrency(id);
      UserNotifier.showSnackBar(
        label: "Kurs o'chirildi",
        type: TypeOfSnackBar.success,
      );
    } catch (e) {
      UserNotifier.showSnackBar(text: e.toString(), type: TypeOfSnackBar.error);
    } finally {
      isLoading(false);
    }
    fetchItems();
  }

  @override
  void updateItem(CurrencyModel item) async {
    try {
      isLoading(true);
      await currencyService.updateCurrency(currency: item);
      UserNotifier.showSnackBar(
        label: "Kurs yangilandi",
        type: TypeOfSnackBar.success,
      );
      fetchItems();
    } catch (e) {
      handleError(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
