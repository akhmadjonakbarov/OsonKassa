import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/document/models/draf_product.dart';
import 'package:osonkassa/app/features/dashboard_views/item/models/item.dart';
import 'package:osonkassa/app/utils/helper/log_helper.dart';

import '../../../../../core/display/user_notifier.dart';
import '../../../../../core/enums/currency_type.dart';
import '../../../../../core/enums/type_of_snackbar.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../translation/translated_texts.dart';
import '../../../../../utils/texts/alert_texts.dart';
import '../../../../../utils/texts/button_texts.dart';
import '../../../../../utils/texts/placeholder_texts.dart';
import '../../../../shared/export_commons.dart';
import '../../../currency/models/currency.dart';

class ManageProductDocItemCtl extends GetxController {
  // Keys
  final formKey = GlobalKey<FormState>();

  final quantityController = TextEditingController();

  // Rx variables
  var productDocItems = <DraftProduct>[].obs;
  var unitValue = "".obs;
  var incomePrice = 0.0.obs;
  var exchangePrice = 0.0.obs;
  var sellPrice = 0.0.obs;
  var qty = 0.0.obs;
  var profitPercentage = 0.0.obs;
  var sellingPercentage = 0.0.obs;
  Rx<Currency> currency = Currency().obs;
  Rx<Item> item = Item().obs;

  @override
  void onClose() {
    quantityController.dispose();
    super.onClose();
  }

  void setItem(Item itm) {
    LogHelper.logInfo("Item was selected ${itm.toString()}");
    item.value = itm;
  }

  void removeItem() {
    LogHelper.logInfo("Item was removed");
    item.value = Item();
  }

  // Add a product to the list
  void storeProductDocItem(BuildContext context) {
    DraftProduct draftProduct = DraftProduct(
      itemId: item.value.id!,
      itemName: item.value.name!,
      incomePrice: item.value.incomePrice ?? 0,
      sellingPrice: item.value.salePrice ?? 0,
      id: productDocItems.length + 1,
      qty: double.parse(quantityController.text),
      sellingPercentage:
          double.parse(profitPercentage.value.toStringAsFixed(5)),
      unit: item.value.unit!,
    );
    productDocItems.add(draftProduct);
    UserNotifier.showFlutterSnackBar(
      context: context,
      type: TypeOfSnackBar.success,
      label: AlertTexts.addAlert(draftProduct.itemName),
    );
    reset();
  }

  void editProductDocItem(DraftProduct draftProduct) {
    TextEditingController qtyController = TextEditingController();
    int productIndex = productDocItems.indexOf(draftProduct);

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('edit'.tr),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Selling Price Input
                TextField(
                  controller: qtyController,
                  style: textStyleBlack18,
                  decoration: InputDecoration(
                    labelText: PlaceholderTexts.qty_of_product,
                    hintText: 'enter_qty'.tr,
                    labelStyle: textStyleBlack18,
                  ),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 10),
              ],
            ),
            actions: <Widget>[
              DialogTextButton(
                isNegative: true,
                text: TranslatedTexts.buttons.cancel.tr,
                onClick: () {
                  Get.back(); // Close dialog without changes
                },
                textStyle: textStyleBlack14,
              ),
              DialogTextButton(
                text: TranslatedTexts.buttons.save.tr,
                onClick: () {
                  productDocItems[productIndex] = productDocItems[productIndex]
                      .copyWith(
                          qty: double.parse(qtyController.text.toString()));
                  update();

                  Get.back(); // Close dialog
                  // UserNotifier.showSnackBar(
                  //   type: TypeOfSnackBar.alert,
                  //   label:
                  //       AlertTexts.updateAlert(productDocItem['item']['name']),
                  // );
                },
                textStyle: textStyleBlack14,
              )
            ],
          );
        },
      ),
    );
  }

  // Clear the list of products
  void clearStoreProductDocItemList() {
    productDocItems.clear(); // Correct way to clear the list
  }

  void removeItemFromStoreList(int drafProductId) {
    productDocItems.removeWhere(
      (element) => element.id == drafProductId,
    );
  }

  Future<void> setCurrency({required Currency cry}) async {
    LogHelper.logInfo("Currency was selected. ${cry.toString()}");
    currency.value = cry;
  }

  void calculateSellingProfitPercentage() {
    // if (currency.value.id != -1 &&
    //     incomeCurrency.value.toString().toLowerCase().contains('usd')) {
    //   LogHelper.logInfo("ExchangeRate: ${exchangePrice.value}");
    //   profitPercentage.value =
    //       ((sellPrice.value * 100) / exchangePrice.value) - 100;
    // } else {
    //   profitPercentage.value = 0.0;
    // }
  }

  void reset() {
    quantityController.clear();
    qty.value = 0.0;
    sellPrice.value = 0.0;
    incomePrice.value = 0.0;
    unitValue.value = "";
    sellingPercentage.value = 0.0;
    removeItem();
  }

  void setQty(BuildContext context) {
    String textQty = quantityController.text;
    if (textQty.isEmpty) {
      return;
    }
    if (double.tryParse(textQty) == null) {
      UserNotifier.showFlutterSnackBar(
          context: context,
          text: 'please_enter_number'.tr,
          type: TypeOfSnackBar.alert);
      return;
    }
    qty.value = double.parse(textQty);
  }
}
