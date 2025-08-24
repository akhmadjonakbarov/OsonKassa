import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/interfaces/api/add.dart';
import '../../../../core/interfaces/api/delete.dart';
import '../../../../core/interfaces/api/get_all.dart';
import '../../../../core/interfaces/api/update.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../../../../utils/helper/log_helper.dart';
import '../../../../utils/texts/alert_texts.dart';
import '../../../shared/models/api_data.dart';
import '../../../unit/logic/unit_controller.dart';
import '../../category/logic/category_controller.dart';
import '../../company/logic/company_ctl.dart';
import '../models/item.dart';
import 'item_repo.dart';
import 'item_service.dart';

class ItemCtl extends MainController<Item> {
  var categoryName = ''.obs;

  Rxn<Item> selectedItem = Rxn(null);

  void setLoading(bool value) {
    isLoading.value = value;
  }

  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController incomePriceController = TextEditingController();

  // controllers
  final CategoryCtl categoryCtl = Get.find<CategoryCtl>();
  final UnitCtl unitCtl = Get.find<UnitCtl>();
  final CompanyCtl companyCtl = Get.find<CompanyCtl>();

  late final ItemRepo _productRepo;
  late final ItemService _productService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    _productRepo = ItemRepo(dio);
    _productService = ItemService(
      addRepository: _productRepo as Add<Map<String, dynamic>>,
      deleteRepository: _productRepo as Delete<int>,
      updateRepository: _productRepo as Update<Item>,
      getAllRepository: _productRepo as GetAllWithPagination<ApiData>,
    );

    super.onInit();
    fetchItems();
  }

  @override
  Future<void> fetchItems() async {
    try {
      setLoading(true);
      var data = await _productService.getAllItems(page: page.value);
      list(data.items.cast<Item>());
      pagination(data.pagination);
    } catch (e) {
      handleError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void selectItem(Item item) {
    selectedItem(item);
  }

  @override
  void addItem(Map<String, dynamic> item) async {
    try {
      bool isCreated = await _productService.addItem(item);
      if (isCreated) {
        UserNotifier.showSnackBar(
          label: AlertTexts.addAlert(item['name']),
          type: TypeOfSnackBar.success,
        );
        fetchItems();
      }
    } on BarcodeAlreadyExistException {
      handleError(AlertTexts.barcode_unique);
    } on InvalidDataException {
      handleError(AlertTexts.invalid_data);
    } catch (e) {
      rethrow;
    }
  }

  void removeSelectedCategory() {
    categoryName('');
    fetchItems();
  }

  @override
  void updateItem(Item item) async {
    try {
      bool isSuccess = await _productService.updateItem(item);
      if (isSuccess) {
        UserNotifier.showSnackBar(
          label: AlertTexts.updateAlert(item.name!),
          type: TypeOfSnackBar.update,
        );
        fetchItems();
      }
    } on BarcodeAlreadyExistException {
      handleError(AlertTexts.barcode_unique);
    } catch (e) {
      handleError(e.toString());
    }
  }

  void filterByCategory(String name) async {
    List<Item> filteredProducts = [];
    try {
      categoryName(name);
      await fetchItems();

      var products = list;

      // Filter products by category ID
      if (categoryIsSelected()) {
        filteredProducts = products
            .where((element) =>
                element.category!.trim().toLowerCase() ==
                categoryName.value.trim().toLowerCase())
            .toList();
      }

      list.assignAll(filteredProducts); // Use assignAll for observable lists
    } catch (e) {
      handleError(e.toString()); // Handle errors
    }
  }

  void searchProduct(String text) {
    // If text is empty, reset to the cached list without re-fetching
    if (text.isEmpty) {
      fetchItems();
      return;
    }

    try {
      // Convert search text to lowercase only once
      List<String> searchKeywords = text.toLowerCase().split(' ');

      // Filter products based on barcode or name
      var filteredProducts = list.where((product) {
        // Convert product name and category name to lowercase only once
        final productName = product.name!.toLowerCase();
        final categoryName = product.category!.toLowerCase();

        // Check if all keywords are found in either product name or category name
        return searchKeywords.every((keyword) =>
            productName.contains(keyword) || categoryName.contains(keyword));
      }).toList();

      // Filter by selected category if applicable
      if (categoryIsSelected()) {
        filteredProducts = filteredProducts
            .where((product) => product.category == categoryName.value)
            .toList();
      }

      // Update the observable list with the filtered products
      list(filteredProducts);
    } catch (e) {
      handleError(e.toString());
    }
  }

  void resetItem() {
    selectedItem(
      null,
    );
  }

  bool categoryIsSelected() {
    LogHelper.logInfo(categoryName.value.isNotEmpty.toString());
    LogHelper.logInfo(categoryName.value.toString());
    return categoryName.value.isNotEmpty;
  }

  @override
  void handleError(String e) {
    UserNotifier.showSnackBar(
      text: e,
      type: TypeOfSnackBar.error,
    );
  }

  @override
  void removeItem(int id) async {
    try {
      bool isDelete = await _productService.deleteItem(id);
      if (isDelete) {
        UserNotifier.showSnackBar(
          label: AlertTexts.deleted.capitalizeFirst!,
          type: TypeOfSnackBar.delete,
        );
      }
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
        type: TypeOfSnackBar.error,
      );
    } finally {
      fetchItems();
    }
  }

  void editItem(BuildContext context, {Item? item}) async {}
}
