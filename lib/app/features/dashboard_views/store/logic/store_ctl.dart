import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/models/api_data.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/texts/alert_texts.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/placeholder_texts.dart';
import '../../../shared/export_commons.dart';
import '../../document/models/doc_item_model.dart';
import '../../trade/logic/trade_ctl.dart';
import 'store_repository.dart';
import 'store_service.dart';

class StoreCtl extends MainController<DocItemModel> {
  var totalProductQty = 0.0.obs;

  var storeProduct = DocItemModel.empty().obs;
  var selledProductDocItems = <DocItemModel>[].obs;

  final TradeCtl tradeCtl = Get.find<TradeCtl>();

  late final StoreRepository _storeRepository;
  late final StoreService _storeService;

  List<DocItemModel> filteredProducts = [];

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    _storeRepository = StoreRepository(dio: dio);
    _storeService = StoreService(
      getAllRepository: _storeRepository as GetAllWithPagination<ApiData>,
      deleteRepository: _storeRepository as Delete<int>,
      updateRepository: _storeRepository as Update<DocItemModel>,
    );
    super.onInit();
  }

  @override
  void fetchItems() async {
    try {
      // Start loading
      isLoading(true);
      // Fetch all items from the service

      // Optimized sorting using only necessary conditions

      ApiData storeProducts = await _storeService.getAll();
      cachedList.sort((a, b) {
        if (a.qty < 1 || b.qty < 1) return a.qty.compareTo(b.qty);
        if (a.qty < 5 || b.qty < 5) return a.qty.compareTo(b.qty);
        if (a.qty < 15 || b.qty < 15) return a.qty.compareTo(b.qty);
        return a.qty.compareTo(b.qty); // Sort by qty as a fallback
      });
      cachedList(storeProducts.items.cast<DocItemModel>());

      list(cachedList);
      pagination(storeProducts.pagination);

      // Calculate totalProduct and totalQtyKg
      double totalQty = cachedList.fold(0.0, (sum, item) => sum + item.qty);

      // Update the observables
      totalProductQty(totalQty);
      // Update the list to reflect the cached products
      list(cachedList);
    } catch (e) {
      handleError(e.toString());
    } finally {
      // Stop loading
      isLoading(false);
    }
  }

  bool areListsEqual(List<DocItemModel> list1, List<DocItemModel> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  @override
  void handleError(String e) {
    UserNotifier.showSnackBar(
      text: e,
      type: TypeOfSnackBar.error,
    );
  }

  searchByBarCode(String text, {bool isShowAlert = false}) async {
    if (text.isEmpty) {
      list(cachedList);
      return;
    }

    try {
      List<DocItemModel> product_doc_item_list = list;

      // Find the product with the matching barcode
      for (DocItemModel pDI in product_doc_item_list) {
        if (pDI.item.barcode == text) {
          // Check if the product already exists in the selledProductDocItems list
          int existingIndex = selledProductDocItems
              .indexWhere((item) => item.item.barcode == text);

          if (existingIndex != -1) {
            // If the product already exists, just increment its quantity
            selledProductDocItems[existingIndex].qty++;

            selledProductDocItems[existingIndex] =
                selledProductDocItems[existingIndex]; // Force update
          } else {
            selledProductDocItems.insert(
              0,
              DocItemModel(
                created_at: pDI.created_at,
                currency: pDI.currency,
                qty: 1,
                document: pDI.document,
                id: pDI.id,
                item: pDI.item,
                currency_type: pDI.currency_type,
                income_price: pDI.income_price,
                income_price_usd: pDI.income_price_usd,
                selling_percentage: pDI.selling_percentage,
                selling_price: pDI.selling_price,
                updated_at: pDI.updated_at,
              ),
            );
          }

          await tradeCtl.setSellProducts(selledProductDocItems);
          if (isShowAlert) {
            UserNotifier.showSnackBar(
              label: "Mahsulot tanlandi",
              type: TypeOfSnackBar.success,
            );
          }

          break;
        }
      }
    } catch (e) {
      handleError(e.toString());
    }
  }

  clearList() async {
    selledProductDocItems.clear();
  }

  void searchProduct(String text) {
    isLoading(true);
    var filteredProducts = [];
    list(cachedList);

    // Fetch the list of products from the service
    List<DocItemModel> products = list;

    // Split the search text into individual words (keywords)
    List<String> searchKeywords = text.toLowerCase().split(' ');

    // Filter products based on keywords matching product name or category name
    filteredProducts = filterProductByKeywords(products, searchKeywords);

    // Update the list with the filtered products
    list(filteredProducts.cast<DocItemModel>());
    isLoading(false);
  }

  List<DocItemModel> filterProductByKeywords(
      List<DocItemModel> products, List<String> keywords) {
    // Filter products by checking if all keywords match either product name or category
    return products.where((product) {
      final productName = product.item.name.toLowerCase();
      final categoryName = product.item.category.name.toLowerCase();
      final barcode = product.item.barcode.toLowerCase();

      // Check if all keywords are found in either product name or category name
      return keywords.every((keyword) =>
          productName.contains(keyword) ||
          categoryName.contains(keyword) ||
          barcode.contains(keyword));
    }).toList();
  }

  void sortItemsByQuantity() {
    list(cachedList);
    List<DocItemModel> sortedList = List.from(list);
    sortedList.sort((a, b) {
      // Sort by qty: items with qty < 5 should come first
      if (a.qty < 5 && b.qty >= 5) return -1;
      if (a.qty >= 5 && b.qty < 5) return 1;
      return a.qty.compareTo(b.qty);
    });
    list(sortedList);
  }

  void sortItemByName() {
    List<DocItemModel> sortedList = List.from(list);
    sortedList.sort((a, b) {
      return a.item.name.toLowerCase().compareTo(b.item.name.toLowerCase());
    });
    list(sortedList);
  }

  double calculateMonthlyProfit(List<DocItemModel> products) {
    Map<String, double> monthlyProfits = {};

    for (var product in products) {
      DateTime createdAt = DateTime.parse(product.created_at.toString());
      String monthYear = "${createdAt.year}-${createdAt.month}";

      if (!monthlyProfits.containsKey(monthYear)) {
        monthlyProfits[monthYear] = 0.0;
      }

      monthlyProfits[monthYear] = monthlyProfits[monthYear]! +
          (product.selling_price - product.income_price);
    }

    // Optionally, you can return the total profit for all months combined.
    return monthlyProfits.values.fold(0.0, (sum, profit) => sum + profit);
  }

  void selectStoreProduct(DocItemModel product) {
    storeProduct(product);
    editStoreProduct(product);
  }

  void editStoreProduct(DocItemModel product) {
    final TextEditingController incomePriceController = TextEditingController(
      text: product.income_price.toString(),
    );
    final TextEditingController incomePriceUSDController =
        TextEditingController(
      text: product.income_price_usd.toString(),
    );
    final TextEditingController sellingPriceController =
        TextEditingController(text: product.selling_price.toString());
    final TextEditingController qtyController = TextEditingController(
      text: product.qty.toString(),
    );
    try {
      Get.dialog(
        AlertDialog(
          title: Text(
              " ${product.item.name} ${ButtonTexts.edit.capitalizeFirst!}"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  style: textStyleBlack20,
                  controller: sellingPriceController,
                  decoration: const InputDecoration(
                    labelText: PlaceholderTexts.selling_price,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  style: textStyleBlack20,
                  controller: qtyController,
                  decoration: const InputDecoration(
                    labelText: PlaceholderTexts.qty_of_product,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                TextField(
                  controller: incomePriceUSDController,
                  style: textStyleBlack20,
                  decoration: const InputDecoration(
                    labelText: "${PlaceholderTexts.income_usd_price} ",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  style: textStyleBlack20,
                  controller: incomePriceController,
                  decoration: const InputDecoration(
                    labelText: PlaceholderTexts.income_price_with_number,
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            DialogTextButton(
              text: ButtonTexts.cancel,
              textStyle: textStyleBlack18.copyWith(fontSize: 16),
              onClick: () {
                resetStoreProduct();
                Get.back();
              },
              isNegative: true,
            ),
            DialogTextButton(
              text: ButtonTexts.edit,
              textStyle: textStyleBlack18.copyWith(fontSize: 16),
              onClick: () {
                // Parsing the input once and reusing it
                double incomePriceUSD =
                    double.parse(incomePriceUSDController.text.trim());
                double incomePrice =
                    double.parse(incomePriceController.text.trim());
                double sellingPrice =
                    double.parse(sellingPriceController.text.trim());
                double quantity = double.parse(qtyController.text.trim());

                // Assigning parsed values to product object
                product.qty = quantity;
                product.selling_price =
                    double.parse(sellingPrice.toStringAsFixed(4));
                product.income_price_usd =
                    double.parse(incomePriceUSD.toStringAsFixed(4));
                product.income_price =
                    double.parse(incomePrice.toStringAsFixed(4));

                // Optimized calculation of selling percentage
                product.selling_percentage =
                    double.parse(calculateSellingPricePercent(
                  sellingPrice,
                  incomePrice,
                ).toStringAsFixed(4));

                updateItem(product);
                Get.back();
              },
            )
          ],
        ),
      ).then((value) => resetStoreProduct());
    } catch (e) {
      handleError(e.toString());
    }
  }

  double calculateSellingPricePercent(selling_price, income_price) {
    return ((selling_price - income_price) / income_price) * 100;
  }

  void resetStoreProduct() {
    storeProduct(DocItemModel.empty());
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
  void updateItem(DocItemModel item) async {
    try {
      bool isUpdate = await _storeService.update(item);
      if (isUpdate) {
        UserNotifier.showSnackBar(
            label: AlertTexts.updateAlert(item.item.name),
            type: TypeOfSnackBar.update);
        fetchItems();
      }
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
