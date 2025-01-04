import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/display/user_notifier.dart';
import '../../../../../core/enums/type_of_snackbar.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../utils/texts/alert_texts.dart';
import '../../../../../utils/texts/button_texts.dart';
import '../../../../../utils/texts/placeholder_texts.dart';
import '../../../../shared/export_commons.dart';

class ManageProductDocItemCtl extends GetxController {
  var productDocItems = <Map<String, dynamic>>[].obs;

  // Add a product to the list
  void storeProductDocItem(Map<String, dynamic> productDocItem) {
    productDocItems.add(productDocItem);
    UserNotifier.showSnackBar(
      type: TypeOfSnackBar.success,
      label: AlertTexts.addAlert(productDocItem['item']['name']),
    );
  }

  void editProductDocItem(Map<String, dynamic> productDocItem) {
    // Initialize TextEditingController with the current selling price
    TextEditingController sellingPriceController = TextEditingController(
      text: productDocItem['selling_price']?.toString() ?? '',
    );

    int product_index = productDocItems.indexOf(productDocItem);

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Tahrirlash"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Selling Price Input
                TextField(
                  controller: sellingPriceController,
                  style: textStyleBlack18,
                  decoration: InputDecoration(
                    labelText: PlaceholderTexts.selling_price,
                    hintText: "Narx kiriting",
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
                text: ButtonTexts.cancel,
                onClick: () {
                  Get.back(); // Close dialog without changes
                },
                textStyle: textStyleBlack14,
              ),
              DialogTextButton(
                text: ButtonTexts.edit,
                onClick: () {
                  // Parse the selling price input
                  if (sellingPriceController.text.isNotEmpty) {
                    productDocItem['selling_price'] =
                        double.tryParse(sellingPriceController.text) ?? 0.0;
                  }

                  productDocItems[product_index] = productDocItem;
                  update();

                  Get.back(); // Close dialog
                  UserNotifier.showSnackBar(
                    type: TypeOfSnackBar.alert,
                    label:
                        AlertTexts.updateAlert(productDocItem['item']['name']),
                  );
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

  void removeItemFromStoreList(Map<String, dynamic> productDocItem) {
    productDocItems.remove(productDocItem);
  }
}
