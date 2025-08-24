import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../store/models/store_item.dart';
import '../../../../utils/helper/log_helper.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/texts/alert_texts.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../../utils/texts/placeholder_texts.dart';
import '../../../report_docs/logic/report_ctl.dart';
import '../../../shared/export_commons.dart';
import 'trade_repository.dart';
import 'trade_service.dart';

class TradeCtl extends GetxController {
  var sellProducts = <StoreItem>[].obs;

  var totalSelledProductCount = 0.0.obs;
  var totalSelledProductPrice = 0.0.obs;
  var discountPrice = 0.0.obs;
  var discount = 0.0.obs;

  late TradeRepository tradeRepository;
  late TradeService tradeService;

  final ReportCtl reportCtl = Get.find<ReportCtl>();

  @override
  void onInit() {
    Dio dio = DioProvider().createDio();
    tradeRepository = TradeRepository(dio);
    tradeService = TradeService(tradeRepository);

    super.onInit();
  }

  sell({
    int? customer_id = -1,
    Map<String, dynamic>? debtData,
    bool isDebt = false,
  }) async {
    try {
      List<Map<String, dynamic>> productList = [];
      for (StoreItem element in sellProducts) {
        productList.add(element.toSellJson());
      }

      Map<String, dynamic> data = {
        "sold_products": productList,
        "customer_id": customer_id,
        "is_debt": isDebt,
        "discount": discountPrice.value
      };

      bool isSuccess = await tradeService.sell(data);
      if (isSuccess) {
        UserNotifier.showSnackBar(
          label: AlertTexts.success_trade,
          type: TypeOfSnackBar.success,
        );
        reportCtl.fetchItems();
      }
    } catch (e) {
      UserNotifier.showSnackBar(text: e.toString(), type: TypeOfSnackBar.error);
    }
  }

  clearData() async {
    sellProducts([]);
    discount.value = 0.0;
    discountPrice.value = 0.0;
    updateTotals();
  }

  setSellStoreItem(StoreItem item) {
    int existingItemOfIndex = sellProducts
        .indexWhere((element) => element.item!.barcode! == item.item!.barcode!);
    LogHelper.logInfo("ProductIndex: $existingItemOfIndex");
    if (existingItemOfIndex <= -1) {
      sellProducts.insert(
        0,
        StoreItem(
          qty: 1,
          item: item.item,
          incomePrice: item.incomePrice,
          salePrice: item.salePrice,
          currency: item.currency,
        ),
      );
    } else {
      final currenItem = sellProducts[existingItemOfIndex];
      final updatedItem = currenItem.copyWith(qty: currenItem.qty! + 1);
      sellProducts[existingItemOfIndex] = updatedItem;
    }
    updateTotals();
  }

  void editProduct(BuildContext context, StoreItem storeItem) {
    final TextEditingController sellingPriceController = TextEditingController(
      text: storeItem.salePrice!.toStringAsFixed(3),
    );
    final TextEditingController qtyController = TextEditingController(
      text: storeItem.qty!.toStringAsFixed(3),
    );

    double updatePrice() {
      double qty = 0.0;
      double sellingPrice = 0.0;

      if (sellingPriceController.text.isNotEmpty) {
        sellingPrice = double.parse(sellingPriceController.text);
      }

      return qty * sellingPrice;
    }

    // Create a FocusNode to handle focus and keyboard events
    final FocusNode focusNode = FocusNode();

    void updateItem() {
      int index = sellProducts
          .indexWhere((item) => item.item!.barcode == storeItem.item!.barcode);
      sellProducts[index] = sellProducts[index].copyWith(
        qty: double.tryParse(qtyController.text.trim()) ?? 0.0,
        salePrice: double.tryParse(
              double.tryParse(sellingPriceController.text.trim())
                      ?.toStringAsFixed(3) ??
                  '0.0',
            ) ??
            0.0,
      );

      sellProducts[index] = sellProducts[index];
    }

    Get.dialog(
      AlertDialog(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(storeItem.item!.name!),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        content: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Focus(
                focusNode: focusNode,
                onKey: (node, event) {
                  // Listen for the Enter key
                  if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                    updateItem(); // Perform the update
                    Get.back(); // Close the dialog
                    updateTotals(); // Recalculate totals
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
                child: Column(
                  children: [
                    TextField(
                      style: textStyleBlack20,
                      controller: qtyController,
                      decoration: const InputDecoration(
                        labelText: PlaceholderTexts.qty_of_product,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          try {
                            double qty = double.parse(value);
                            if (qty > 0) {
                              setState(() => updatePrice());
                            }
                          } catch (e) {
                            qtyController.clear();
                            UserNotifier.showSnackBar(
                              label: "Iltimos raqam kiriting",
                            );
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    TextField(
                      style: textStyleBlack20,
                      controller: sellingPriceController,
                      decoration: const InputDecoration(
                        labelText: PlaceholderTexts.selling_price,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(
                          () => updateItem(),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "${PlaceholderTexts.income_price}: ${formatPriceAtUZS(storeItem.incomePrice!)}",
                      style: textStyleBlack20,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "${DisplayTexts.total_of_sum}: ${formatPriceAtUZS(updatePrice())}",
                      style: textStyleBlack20,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          DialogTextButton(
            text: ButtonTexts.cancel,
            textStyle: textStyleBlack18.copyWith(fontSize: 16),
            onClick: () {
              Get.back();
            },
            isNegative: true,
          ),
          DialogTextButton(
            text: ButtonTexts.edit,
            textStyle: textStyleBlack18.copyWith(fontSize: 16),
            onClick: () {
              updateItem();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ).then(
      (_) => updateTotals(),
    );
  }

  void updateTotals() {
    double totalPrice = 0.0;
    double totalCount = 0.0;

    for (StoreItem item in sellProducts) {
      totalCount += item.qty!;
      if (item.currency != null) {
        totalPrice += (item.qty! * item.salePrice!) * item.currency!.value!;
      } else {
        totalPrice += (item.qty! * item.salePrice!);
      }
    }

    totalSelledProductPrice.value = totalPrice;
    totalSelledProductCount.value = totalCount;

    update();
  }

  void incrementQty(String barcode) {
    int index = sellProducts.indexWhere((item) {
      return item.item!.barcode == barcode;
    });
    if (index != -1) {
      sellProducts[index] = sellProducts[index].copyWith(
        qty: sellProducts[index].qty! + 1,
      );

      updateTotals();
    }
  }

  void calculateDiscount(String barcode) {
    int index =
        sellProducts.indexWhere((item) => item.item!.barcode! == barcode);

    if (index != -1) {
      var item = sellProducts[index];

      item = item.copyWith(salePrice: (item.salePrice! * 0.99).ceilToDouble());

      // Ensure the discount price does not go below the income price
      if (item.salePrice! < item.incomePrice!) {
        item = item.copyWith(salePrice: item.salePrice);
      }
      // Force update in the list
      sellProducts[index] = item;
      updateTotals(); // Update totals after changing price
    }
  }

  void decrementQty(String barcode) {
    int index =
        sellProducts.indexWhere((item) => item.item!.barcode == barcode);
    if (index != -1 && sellProducts[index].qty! > 0) {
      sellProducts[index] = sellProducts[index].copyWith(
        qty: sellProducts[index].qty! - 1,
      );

      updateTotals(); // Update totals after changing qty
      update();
    }
  }

  removeItem(String barcode) {
    try {
      sellProducts
          .removeWhere((storeItem) => storeItem.item!.barcode! == barcode);

      updateTotals();
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
        type: TypeOfSnackBar.delete,
      );
    }
  }

  void editTotalDiscount() {
    final TextEditingController discountController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Edit Total Discount",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: discountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Enter discount",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final input = discountController.text;
                      final discountValue = double.tryParse(input);
                      if (discountValue != null && discountValue >= 0) {
                        discountPrice.value =
                            totalSelledProductPrice.value - discountValue;
                        discount.value = discountValue;
                        Get.back();
                      } else {
                        Get.snackbar(
                          "Invalid input",
                          "Please enter a valid discount amount.",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
