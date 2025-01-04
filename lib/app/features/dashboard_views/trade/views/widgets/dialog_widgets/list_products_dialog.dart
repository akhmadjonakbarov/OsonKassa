import 'package:osonkassa/app/features/shared/export_commons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../styles/text_styles.dart';
import '../../../../../../utils/texts/button_texts.dart';
import '../../../../document/models/doc_item_model.dart';
import '../../../../store/logic/store_ctl.dart';

class ListProductsDialog extends StatelessWidget {
  const ListProductsDialog({
    super.key,
    required this.screenSize,
    required this.searchController,
    required this.storeCtl,
  });

  final Size screenSize;
  final TextEditingController searchController;
  final StoreCtl storeCtl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Obx(() {
            return Container(
              width: screenSize.width * 0.5,
              padding: const EdgeInsets.all(16),
              height: screenSize.height * 0.7,
              child: storeCtl.isLoading.value
                  ? const Loading(
                      hasPadding: false,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '${ButtonTexts.products} ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: ButtonTexts.search,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            storeCtl.searchProduct(value);
                          },
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListStoreProduct(
                            storeCtl: storeCtl,
                            searchController: searchController,
                            screenSize: screenSize,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: DialogTextButton(
                            onClick: () {
                              Navigator.of(context).pop();
                            },
                            text: ButtonTexts.close,
                            textStyle:
                                textStyleBlack18.copyWith(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
            );
          });
        },
      ),
    );
  }
}

class ListStoreProduct extends StatelessWidget {
  const ListStoreProduct({
    super.key,
    required this.storeCtl,
    required this.searchController,
    required this.screenSize,
  });

  final StoreCtl storeCtl;
  final TextEditingController searchController;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: storeCtl.list.length,
        itemBuilder: (context, index) {
          DocItemModel product = storeCtl.list[index];
          return StoreItemDialog(
            storeCtl: storeCtl,
            index: index + 1,
            product: product,
            searchController: searchController,
            screenSize: screenSize,
          );
        },
      );
    });
  }
}

class StoreItemDialog extends StatelessWidget {
  const StoreItemDialog({
    super.key,
    required this.storeCtl,
    required this.product,
    required this.searchController,
    required this.screenSize,
    required this.index,
  });
  final int index;
  final StoreCtl storeCtl;
  final DocItemModel product;
  final TextEditingController searchController;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.lightBlueAccent,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        storeCtl.searchByBarCode(
          product.item.barcode,
          isShowAlert: true,
        );
        searchController.clear();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        height: screenSize.width <= 1366
            ? screenSize.height * 0.20
            : screenSize.height * 0.15,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "$index",
                    style: textStyleBlack20.copyWith(color: Colors.white),
                  ),
                ),
                Text(
                  "(${product.item.category.name}) ${product.item.name}",
                  style: textStyleBlack20,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Qolgan: ${product.qty} ${product.item.units.firstWhere(
                            (element) => element.value == 'qop',
                          ).value}",
                      style: textStyleBlack18Bold,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kelish: ${product.income_price} ${product.currency_type}",
                      style: textStyleBlack18Bold,
                    ),
                    Text(
                      "Sotilish: ${product.selling_price} ${product.currency_type}",
                      style: textStyleBlack18Bold,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
