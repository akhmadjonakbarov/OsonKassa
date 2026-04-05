import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/display/user_notifier.dart';
import '../../../../../core/enums/type_of_snackbar.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../translation/translated_texts.dart';
import '../../../../../utils/helper/log_helper.dart';
import '../../../../../utils/texts/placeholder_texts.dart';
import '../../../../shared/export_commons.dart';
import '../../../currency/models/currency.dart';
import '../../../item/domain/models/item.dart';
import '../../models/draf_product.dart';

class ManageProductDocItemCtl extends GetxController {
  final formKey = GlobalKey<FormState>();
  final quantityController = TextEditingController();
  var productDocItems = <DraftProduct>[].obs;

  var incomePrice = 0.0.obs;
  var exchangePrice = 0.0.obs;
  var qty = 0.0.obs;

  Rx<Currency> currency = Currency().obs;
  RxList<Item> selectedItems = RxList([]);

  @override
  void onClose() {
    quantityController.dispose();
    super.onClose();
  }

  // Add a product to the list
  void storeProductDocItem(BuildContext context) {
    for (Item item in selectedItems) {
      DraftProduct draftProduct = DraftProduct(
          itemId: item.id!,
          itemName: item.name!,
          incomePrice: item.incomePrice ?? 0,
          sellingPrice: item.salePrice ?? 0,
          id: productDocItems.length + 1,
          qty: double.parse(quantityController.text),
          sellingPercentage: 0.0,
          unit: item.unit!,
          type: item.type);
      productDocItems.add(draftProduct);
    }

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
                },
                textStyle: textStyleBlack14,
              )
            ],
          );
        },
      ),
    );
  }

  void addOrRemoveSelectItem(Item item) {
    if (isExistInSelectedItems(item)) {
      selectedItems.removeWhere((e) => e.id == item.id && e.type == item.type);
    } else {
      selectedItems.add(item);
    }
  }

  bool isExistInSelectedItems(Item item) {
    return selectedItems.any((e) => e.id == item.id && e.type == item.type);
  }

  void clearStoreProductDocItemList() {
    productDocItems.clear();
  }

  void removeItemFromStoreList(int drafProductId) {
    productDocItems.removeWhere(
      (element) => element.id == drafProductId,
    );
  }

  setCurrency({required Currency cry}) {
    LogHelper.logInfo("Currency was selected. ${cry.toString()}");
    currency.value = cry;
    update();
  }

  void reset() {
    quantityController.clear();
    selectedItems.clear();
    qty.value = 0.0;
    incomePrice.value = 0.0;
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
