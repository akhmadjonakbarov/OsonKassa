import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/product_doc_type.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/texts/alert_texts.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../../utils/texts/placeholder_texts.dart';
import '../../../report_docs/logic/report_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../document/models/doc_item_model.dart';
import 'trade_repository.dart';
import 'trade_service.dart';

class TradeCtl extends GetxController {
  var sellProductDocItems = <DocItemModel>[].obs;
  var store_doc_items = <DocItemModel>[].obs;

  var totalSelledProductKg = 0.0.obs;
  var totalSelledProductCount = 0.0.obs;
  var totalSelledProductPrice = 0.0.obs;
  var totalDiscount = 0.0.obs;

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
    int? clientId = -1,
    Map<String, dynamic>? debtData,
    bool isDebt = false,
  }) async {
    try {
      List<Map<String, dynamic>> productList = [];
      for (DocItemModel element in sellProductDocItems) {
        productList.add(element.toMap());
      }

      Map<String, dynamic> data = {
        "product_doc_items": productList,
        "doc_type": ProductDocType.sell.name,
        "clientId": clientId,
        "debt_data": debtData,
        "is_debt": isDebt
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

  void setStoreItems(List<DocItemModel> items) {
    store_doc_items(items);
    updateTotals();
  }

  clearData() async {
    setSellProducts([]);
    updateTotals();
  }

  setSellProducts(List<DocItemModel> sell_list) {
    sellProductDocItems(sell_list);
    updateTotals();
  }

  void editProduct(BuildContext context, DocItemModel docItem) {
    final TextEditingController sellingPriceController = TextEditingController(
      text: docItem.selling_price.toStringAsFixed(3),
    );
    final TextEditingController qtyController = TextEditingController(
      text: docItem.qty.toStringAsFixed(0),
    );

    int selected_unit_id = docItem.item.units.first.id;

    double updatePrice() {
      double qtyKg = 0.0;
      double sellingPrice = 0.0;

      if (sellingPriceController.text.isNotEmpty) {
        sellingPrice = double.parse(sellingPriceController.text);
      }

      return qtyKg * sellingPrice;
    }

    // Create a FocusNode to handle focus and keyboard events
    final FocusNode focusNode = FocusNode();

    void updateItem() {
      int index = sellProductDocItems
          .indexWhere((item) => item.item.barcode == docItem.item.barcode);
      sellProductDocItems[index].qty =
          double.parse(qtyController.text.toString());
      sellProductDocItems[index].selling_price = double.parse(
        double.parse(sellingPriceController.text.toString()).toStringAsFixed(3),
      );

      sellProductDocItems[index] = sellProductDocItems[index];
    }

    Get.dialog(
      AlertDialog(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(docItem.item.name),
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
                    // if (false)
                    //   UnitSelectionWidget(
                    //     doc_item: doc_item,
                    //     onSelectId: (p0) {
                    //       setState(
                    //         () {
                    //           selected_unit_id = p0;
                    //         },
                    //       );
                    //     },
                    //   ),
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
                      "${PlaceholderTexts.income_price}: ${formatPriceAtUZS(docItem.income_price)}",
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
    double totalKg = 0;
    double totalPrice = 0.0;
    double totalCount = 0.0;

    for (DocItemModel item in sellProductDocItems) {
      totalCount += item.qty;
    }

    // Update the total counts and prices
    totalSelledProductKg.value = totalKg;
    totalSelledProductPrice.value = totalPrice;
    totalSelledProductCount.value = totalCount;

    update();
  }

  void incrementQty(String barcode) {
    int index = sellProductDocItems.indexWhere((item) {
      return item.item.barcode == barcode;
    });
    if (index != -1) {
      var balanceItem = store_doc_items.firstWhere(
        (element) => element.item.id == sellProductDocItems[index].item.id,
      );

      if (balanceItem.qty == sellProductDocItems[index].qty) {
        UserNotifier.showSnackBar(
            label: "Ombordagi barcha mahsulot belgilandi",
            type: TypeOfSnackBar.alert,
            duration: const Duration(seconds: 8),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 300));
      } else {
        sellProductDocItems[index].qty += 1;

        sellProductDocItems[index] =
            sellProductDocItems[index]; // Force the update
      }

      updateTotals(); // Update totals after changing qty
    }
  }

  void calculateDiscount(String barcode) {
    int index =
        sellProductDocItems.indexWhere((item) => item.item.barcode == barcode);

    if (index != -1) {
      var item = sellProductDocItems[index];

      item.selling_price = (item.selling_price * 0.99).ceilToDouble();

      // Ensure the discount price does not go below the income price
      if (item.selling_price < item.income_price) {
        item.selling_price = item.selling_price;
      }
      // Force update in the list
      sellProductDocItems[index] = item;
      updateTotals(); // Update totals after changing price
    }
  }

  void decrementQty(String barcode) {
    int index =
        sellProductDocItems.indexWhere((item) => item.item.barcode == barcode);
    if (index != -1 && sellProductDocItems[index].qty > 0) {
      sellProductDocItems[index].qty = sellProductDocItems[index].qty - 1;
      sellProductDocItems[index] =
          sellProductDocItems[index]; // Force the update
      updateTotals(); // Update totals after changing qty
    }
  }

  deleteItemFromSelledProductList(String barcode) {
    try {
      sellProductDocItems
          .removeWhere((doc_item) => doc_item.item.barcode == barcode);

      updateTotals();
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
        type: TypeOfSnackBar.delete,
      );
    }
  }
}
