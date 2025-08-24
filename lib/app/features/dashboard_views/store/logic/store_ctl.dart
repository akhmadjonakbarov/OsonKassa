import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/store/models/store_item.dart';
import 'package:osonkassa/app/utils/helper/log_helper.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../../../../utils/texts/alert_texts.dart';
import '../../../shared/models/api_data.dart';
import '../../document/models/document_item.dart';
import '../../trade/logic/trade_ctl.dart';
import 'store_repository.dart';
import 'store_service.dart';

class StoreCtl extends MainController<StoreItem> {
  var totalProductQty = 0.0.obs;

  var storeProduct = StoreItem().obs;
  var productsInStore = <StoreItem>[].obs;

  final TradeCtl tradeCtl = Get.find<TradeCtl>();

  late final StoreRepository _storeRepository;
  late final StoreService _storeService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    _storeRepository = StoreRepository(dio: dio);
    _storeService = StoreService(
      storeRepository: _storeRepository,
      getAllRepository: _storeRepository as GetAllWithPagination<ApiData>,
      deleteRepository: _storeRepository as Delete<int>,
      updateRepository: _storeRepository as Update<StoreItem>,
    );
    super.onInit();
    fetchItems();
    fetchProductInStore();
  }

  @override
  Future<void> fetchItems() async {
    try {
      isLoading(true);

      ApiData storeProducts = await _storeService.getAll();

      list(storeProducts.items.cast<StoreItem>());
      pagination(storeProducts.pagination);
    } catch (e) {
      handleError(e.toString());
    } finally {
      // Stop loading
      isLoading(false);
    }
  }

  fetchProductInStore() async {
    try {
      isLoading(true);
      List<StoreItem> products = await _storeRepository.fetchProduct();
      productsInStore(products);
    } catch (e) {
      handleError(e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void handleError(String e) {
    UserNotifier.showSnackBar(
      text: e,
      type: TypeOfSnackBar.error,
    );
  }

  clearList() async {}

  Future<void> searchProduct(String text) async {
    isLoading(true);

    if (text.isEmpty) {
      await fetchItems();
      isLoading(false);
      return;
    }

    List<StoreItem> products = list;
    List<String> searchKeywords = text.toLowerCase().split(' ');
    var filteredProducts = filterProductByKeywords(products, searchKeywords);

    list(filteredProducts.cast<StoreItem>());
    isLoading(false);
  }

  List<StoreItem> filterProductByKeywords(
      List<StoreItem> products, List<String> keywords) {
    // Filter products by checking if all keywords match either product name or category
    return products.where((product) {
      final productName = product.item!.name!.toLowerCase();
      final categoryName = product.item!.category!.toLowerCase();
      final barcode = product.item!.barcode!.toLowerCase();

      // Check if all keywords are found in either product name or category name
      return keywords.every((keyword) =>
          productName.contains(keyword) ||
          categoryName.contains(keyword) ||
          barcode.contains(keyword));
    }).toList();
  }

  void sortItemsByQuantity() {
    List<StoreItem> sortedList = List.from(list);
    sortedList.sort((a, b) {
      // Sort by qty: items with qty < 5 should come first
      if (a.qty! < 5 && b.qty! >= 5) return -1;
      if (a.qty! >= 5 && b.qty! < 5) return 1;
      return a.qty!.compareTo(b.qty!);
    });
    list(sortedList);
  }

  void sortItemByName() {
    List<StoreItem> sortedList = List.from(list);
    sortedList.sort((a, b) {
      return a.item!.name!.toLowerCase().compareTo(b.item!.name!.toLowerCase());
    });
    list(sortedList);
  }

  void selectStoreProduct(StoreItem product) {
    storeProduct(product);
    editStoreProduct(product);
  }

  void editStoreProduct(StoreItem product) {
    showEditProductDialog(product, (updated) {
      updateItem(updated);
    });
  }

  void showEditProductDialog(
      StoreItem item, void Function(StoreItem updated) onSave) {
    // final incomePriceController =
    //     TextEditingController(text: item.incomePrice?.toString() ?? '');
    // final sellingPriceController =
    //     TextEditingController(text: item.sellingPrice?.toString() ?? '');
    // final qtyController =
    //     TextEditingController(text: item.qty?.toString() ?? '');

    // Get.defaultDialog(
    //   title: "✏️ Edit Product",
    //   titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //   contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //   content: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       _buildInputField("Income Price", incomePriceController),
    //       const SizedBox(height: 10),
    //       _buildInputField("Selling Price", sellingPriceController),
    //       const SizedBox(height: 10),
    //       _buildInputField("Quantity", qtyController),
    //     ],
    //   ),
    //   confirm: ElevatedButton.icon(
    //     icon: const Icon(Icons.check_circle_outline),
    //     label: const Text("Save"),
    //     style: ElevatedButton.styleFrom(
    //       backgroundColor: Colors.green,
    //       foregroundColor: Colors.white,
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //     ),
    //     onPressed: () {
    //       double? parsedIncomePrice =
    //           double.tryParse(incomePriceController.text);
    //       double? parsedSellingPrice =
    //           double.tryParse(sellingPriceController.text);
    //       double? parsedQty = double.tryParse(qtyController.text);

    //       if (parsedIncomePrice == null || parsedSellingPrice == null) {
    //         Get.snackbar("Invalid input", "Please enter valid prices.",
    //             backgroundColor: Colors.redAccent, colorText: Colors.white);
    //         return;
    //       }

    //       double newSellPercentage = 0.0;

    //       StoreItem updatedItem = item.copyWith(
    //         incomePrice: parsedIncomePrice,
    //         sellingPrice: parsedSellingPrice,
    //         qty: parsedQty,
    //       );

    //       final isUsd = storeProduct.value.incomeCurrency
    //               ?.toLowerCase()
    //               .contains('usd') ??
    //           false;
    //       if (isUsd) {
    //         double convertedIncomePrice =
    //             parsedIncomePrice * item.currency!.value!;

    //         newSellPercentage = ((parsedSellingPrice - convertedIncomePrice) /
    //                 convertedIncomePrice) *
    //             100;

    //         // Optionally round to 2 decimal places
    //         newSellPercentage =
    //             double.parse(newSellPercentage.toStringAsFixed(2));

    //         updatedItem = updatedItem.copyWith(
    //           sellingPercentage: newSellPercentage,
    //         );
    //       }

    //       LogHelper.logInfo(updatedItem.toRawJson());

    //       onSave(updatedItem);
    //       Get.back();
    //     },
    //   ),
    //   cancel: TextButton.icon(
    //     icon: const Icon(Icons.cancel_outlined),
    //     label: const Text("Cancel"),
    //     style: TextButton.styleFrom(
    //       foregroundColor: Colors.grey[700],
    //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //     ),
    //     onPressed: () => Get.back(),
    //   ),
    // );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      ),
    );
  }

  void resetStoreProduct() {
    storeProduct(StoreItem());
  }

  @override
  void removeItem(int id) async {
    try {
      bool isDelete = await _storeService.delete(id);
      if (isDelete) {
        UserNotifier.showSnackBar(
            label: AlertTexts.delete_data, type: TypeOfSnackBar.delete);
        fetchItems();
      }
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  void updateItem(StoreItem storeItem) async {
    try {
      bool isUpdate = await _storeService.update(storeItem);
      if (isUpdate) {
        UserNotifier.showSnackBar(
            label: AlertTexts.updateAlert(storeItem.item!.name!),
            type: TypeOfSnackBar.update);
        fetchItems();
      }
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  searchByBarCode(String text, {bool isShowAlert = false}) async {
    if (text.isEmpty) {
      fetchProductInStore();
      return;
    }

    try {
      List<StoreItem> storeItemList = productsInStore;

      // Find the product with the matching barcode
      for (StoreItem storeItem in storeItemList) {
        if (storeItem.item!.barcode!.contains(text)) {
          tradeCtl.setSellStoreItem(storeItem);
        }
      }
    } catch (e) {
      handleError(e.toString());
    }
  }

  selectProduct(StoreItem item) {
    LogHelper.logInfo(item.toRawJson());
    try {
      List<StoreItem> storeItemList = productsInStore;

      // Find the product with the matching barcode
      for (StoreItem storeItem in storeItemList) {
        if (storeItem.item!.barcode!.contains(item.item!.barcode!)) {
          tradeCtl.setSellStoreItem(storeItem);
        }
      }
    } catch (e) {
      handleError(e.toString());
    }
  }
}
