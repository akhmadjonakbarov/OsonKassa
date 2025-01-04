import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../models/company_model.dart';
import 'currency_repository.dart';
import 'currency_service.dart';

class CompanyCtl extends MainController<CompanyModel> {
  var selectedCompany = CompanyModel.empty().obs;

  late final CompanyRepository companyRepository;
  late final CompanyService companyService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    companyRepository = CompanyRepository(dio);
    companyService = CompanyService(
      addRepository: companyRepository as Add<Map<String, dynamic>>,
      updateRepository: companyRepository as Update<CompanyModel>,
      deleteRepository: companyRepository as Delete<int>,
      getAllRepository: companyRepository as GetAll<CompanyModel>,
    );
    fetchItems();
    super.onInit();
  }

  void resetCompany() {
    selectedCompany.value = CompanyModel.empty();
  }

  @override
  void fetchItems() async {
    try {
      isLoading(true);
      var apiCurrencies = await companyService.fetchCurrencies();
      list(apiCurrencies);
      isLoading(false);
    } catch (e) {
      handleError(e.toString());
    }
  }

  void selectCompany(CompanyModel company) {
    selectedCompany(company);
  }

  void searchCompany(String text) async {
    try {
      // Fetch all items from the service
      var company = await companyService.fetchCurrencies();

      text = text.toLowerCase();

      // Filter products based on barcode or name
      var filteredCurrencies = company.where((product) {
        final companyName = product.name;
        // Check if the search text is found in either the product name or the barcode
        return companyName.toString().contains(text.toString());
      }).toList();
      // Update the observable list with the filtered products
      list(filteredCurrencies);
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  void addItem(item) async {
    // try {
    //   bool isSuccess = await companyService.addCompany(
    //     companyData: item,
    //   );
    //   if (isSuccess) {
    //     UserNotifier.showSnackBar(
    //       label: "${item['value']} ${AlertTexts.created}",
    //       type: TypeOfSnackBar.success,
    //     );
    //     fetchItems();
    //   }
    // } catch (e) {
    //   handleError(e.toString());
    // }
  }

  @override
  void handleError(String e) {
    // UserNotifier.showSnackBar(
    //   label: e,
    //   type: TypeOfSnackBar.error,
    // );
  }

  @override
  void removeItem(int id) async {
    // try {
    //   await companyService.deleteCompany(id);
    //   UserNotifier.showSnackBar(
    //     label: "Kurs o'chirildi",
    //     type: TypeOfSnackBar.success,
    //   );
    // } catch (e) {
    //   UserNotifier.showSnackBar(text: e.toString(), type: TypeOfSnackBar.error);
    // } finally {
    //   isLoading(false);
    // }
    // fetchItems();
  }

  @override
  void updateItem(CompanyModel item) async {
    // try {
    //   isLoading(true);
    //   await companyService.updateCompany(company: item);
    //   UserNotifier.showSnackBar(
    //     label: "Kurs yangilandi",
    //     type: TypeOfSnackBar.success,
    //   );
    //   fetchItems();
    // } catch (e) {
    //   handleError(e.toString());
    // } finally {
    //   isLoading(false);
    // }
  }
}
