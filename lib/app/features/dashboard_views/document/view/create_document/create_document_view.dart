import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/currency/models/currency.dart';
import 'package:osonkassa/app/features/dashboard_views/document/models/draft_document.dart';

import 'package:osonkassa/app/styles/themes.dart';
import 'package:osonkassa/app/translation/translated_texts.dart';
import 'package:osonkassa/app/utils/formatter_functions/formatter_currency.dart';
import 'package:osonkassa/app/utils/helper/log_helper.dart';

import '../../../../../core/enums/product_doc_type.dart';
import '../../../../../core/validator/number_validator.dart';
import '../../../../../styles/container_decoration.dart';
import '../../../../../styles/text_input_styles.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../utils/texts/button_texts.dart';
import '../../../../../utils/texts/display_texts.dart';
import '../../../../../utils/texts/placeholder_texts.dart';
import '../../../../shared/export_commons.dart';
import '../../../category/logic/category_controller.dart';
import '../../../currency/logic/currency_controller.dart';

import '../../../item/logic/item_ctl.dart';
import '../../../item/models/item.dart';
import '../../../note/logic/note_controller.dart';
import '../../logic/document/document_ctl.dart';
import '../../logic/view_controller/manage_product_doc_item_ctl.dart';
import 'widgets/cached_products_table.dart';
import 'widgets/header_currency.dart';

class CreateDocumentView extends StatefulWidget {
  const CreateDocumentView({super.key});

  @override
  State<CreateDocumentView> createState() => _CreateDocumentViewState();
}

class _CreateDocumentViewState extends State<CreateDocumentView> {
  final CurrencyCtl currencyCtl = Get.find<CurrencyCtl>();
  final ItemCtl itemCtl = Get.find<ItemCtl>();
  final DocumentCtl storeCtl = Get.find<DocumentCtl>();
  final CategoryCtl categoryCtl = Get.find<CategoryCtl>();
  final ManageProductDocItemCtl manageProductDocItemCtl =
      Get.find<ManageProductDocItemCtl>();

  final NoteCtl noteCtl = Get.find<NoteCtl>();

  @override
  void didChangeDependencies() async {
    await currencyCtl.fetchItems();
    await manageProductDocItemCtl.setCurrency(cry: currencyCtl.list.first);
    super.didChangeDependencies();
  }

  reloadFetchItems() {
    currencyCtl.fetchItems();
    storeCtl.fetchItems();
    categoryCtl.fetchItems();
    itemCtl.removeSelectedCategory();
    itemCtl.resetItem();
  }

  @override
  void dispose() {
    if (manageProductDocItemCtl.productDocItems.isNotEmpty) {
      _submitForm();
    }
    itemCtl.resetItem();
    manageProductDocItemCtl.setCurrency(cry: Currency());
    super.dispose();
  }

  void addProductBadge() {
    if (manageProductDocItemCtl.formKey.currentState!.validate()) {
      manageProductDocItemCtl.storeProductDocItem(context);
    }
    reloadFetchItems();
  }

  void _submitForm() {
    DraftDocument drafDocument = DraftDocument(
      docType: DocumentType.buy.name,
      products: manageProductDocItemCtl.productDocItems,
    );

    LogHelper.logInfo("Document: ${drafDocument.toMap()}");

    storeCtl.addItem(drafDocument.toMap());
    manageProductDocItemCtl.clearStoreProductDocItemList();
    reloadFetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return BasicContainer(
      padding: const EdgeInsets.all(10),
      decoration: Decorations.decoration(
        boxShadow: BoxShadows.custom,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              Obx(() {
                if (manageProductDocItemCtl.currency.value.value != null) {
                  return HeaderCurrency(
                    currencyValue:
                        manageProductDocItemCtl.currency.value.value!,
                    constraints: constraints,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              const SizedBox(height: 15),
              Form(
                key: manageProductDocItemCtl.formKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLeftSide(constraints),
                    _buildRightSide(constraints),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLeftSide(BoxConstraints constraints) {
    return Obx(
      () {
        return BasicContainer(
          width: constraints.maxWidth * 0.72,
          child: Column(
            children: [
              BasicContainer(
                padding: const EdgeInsets.all(10),
                decoration: Decorations.decoration(
                  border: Border.all(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      if (itemCtl.selectedItem.value == null) {
                        return const SizedBox.shrink();
                      }
                      final item = itemCtl.selectedItem.value;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 25),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                        color: Colors.white,
                        shadowColor: Colors.black12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "🧾 Mahsulot Tafsilotlari",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _InfoRow(
                                label: TranslatedTexts.table.incomePrice.tr,
                                value: item!.incomePrice != null
                                    ? PriceFomatter.formatPrice(
                                        item.incomePrice!)
                                    : "0",
                                valueColor: Colors.teal.shade700,
                              ),
                              const SizedBox(height: 12),
                              _InfoRow(
                                label: TranslatedTexts.table.salePrice.tr,
                                value: item.salePrice != null
                                    ? PriceFomatter.formatPrice(item.salePrice!)
                                    : "0",
                                valueColor: Colors.blue.shade700,
                              ),
                              const SizedBox(height: 12),
                              _InfoRow(
                                label: TranslatedTexts.table.currency.tr,
                                valueWidget: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 6),
                                    Text(
                                      item.currencyType?.toUpperCase() ?? '-',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.165,
                              child: TextFormField(
                                controller:
                                    manageProductDocItemCtl.quantityController,
                                style: textStyleBlack18,
                                onChanged: (p0) {
                                  manageProductDocItemCtl.setQty(context);
                                },
                                decoration: customInputDecoration(
                                    PlaceholderTexts.qty_of_product),
                                validator: (p0) => NumberValidator.validPrice(
                                    p0!,
                                    isDouble: false),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: constraints.maxWidth * 0.028,
                                top: 2,
                              ),
                              child: Column(
                                children: [
                                  // if (manageProductDocItemCtl
                                  //         .sellingCurrency.value.name
                                  //         .toLowerCase() ==
                                  //     'uzs')
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Ustma foiz: ${manageProductDocItemCtl.profitPercentage.value.toStringAsFixed(3)} %",
                                        style: textStyleBlack18,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CachedProductsTable(
                manageProductDocItemCtl: manageProductDocItemCtl,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildRightSide(BoxConstraints constraints) {
    return BasicContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: constraints.maxWidth * 0.27,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: containerDecoration,
            child: Column(
              children: [
                Text(
                  DisplayTexts.info_of_product,
                  style: textStyleBlack18.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 15),
                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16)),
                    height: constraints.maxHeight * 0.5,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SearchTextField(
                            onChanged: (value) {
                              itemCtl.searchProduct(value);
                            },
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: ListView.builder(
                              padding: const EdgeInsets.all(5),
                              itemBuilder: (context, index) {
                                Item item = itemCtl.list[index];
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: constraints.minWidth * 0.002,
                                  ),
                                  decoration: BoxDecoration(
                                      color: itemCtl.selectedItem.value == item
                                          ? Colors.blue
                                          : Colors.white,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ListTile(
                                    title: Text(
                                      "${index + 1}. (${item.category}) ${item.name}",
                                      style: textStyleBlack18.copyWith(
                                        color:
                                            itemCtl.selectedItem.value == item
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (itemCtl.selectedItem.value ==
                                            item) {
                                          itemCtl.resetItem();
                                          manageProductDocItemCtl.removeItem();
                                        } else {
                                          itemCtl.selectItem(item);
                                          manageProductDocItemCtl.setItem(item);
                                        }
                                      });
                                    },
                                  ),
                                );
                              },
                              itemCount: itemCtl.list.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.02,
          ),
          Row(
            children: [
              Expanded(
                child: CustomButton2(
                  text: ButtonTexts.add_to_badge,
                  iconColor: Colors.white,
                  buttonBgColor: Colors.pinkAccent,
                  onClick: addProductBadge,
                  buttonSize: Size(constraints.maxWidth * 0.1, 45),
                  textStyle: textStyleBlack18.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(
                width: constraints.maxHeight * 0.02,
              ),
              Expanded(
                child: CustomButton2(
                  text: ButtonTexts.save,
                  iconColor: Colors.white,
                  buttonBgColor: Colors.blue,
                  onClick: _submitForm,
                  buttonSize: Size(constraints.maxWidth * 0.1, 45),
                  textStyle: textStyleBlack18.copyWith(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? valueWidget;
  final Color? valueColor;

  const _InfoRow({
    required this.label,
    this.value,
    this.valueWidget,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 12),
        valueWidget ??
            Text(
              value ?? "-",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black87,
              ),
            ),
      ],
    );
  }
}
