import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/currency/models/models.dart';
import 'package:osonkassa/app/features/dashboard_views/document/models/draft_document.dart';

import 'package:osonkassa/app/features/dashboard_views/document/view/create_document/widgets/currency_type_dropdown.dart';
import 'package:osonkassa/app/styles/themes.dart';
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
    manageProductDocItemCtl.setCurrency(cry: CurrencyModel.empty());
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
              Obx(
                () => HeaderCurrency(
                  currencyValue: manageProductDocItemCtl.currency.value.value,
                  constraints: constraints,
                ),
              ),
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
                    CurrencyTypeDropdown(
                      incomeCurrency:
                          manageProductDocItemCtl.incomeCurrency.value,
                      sellingCurrency:
                          manageProductDocItemCtl.sellingCurrency.value,
                      onSelectSellingCurrency: (sellingCurrency_) {
                        manageProductDocItemCtl
                            .setSellingCurrency(sellingCurrency_);
                      },
                      onSelectIncomeCurrency: (incomeCurrency_) {
                        manageProductDocItemCtl
                            .setIncomeCurrency(incomeCurrency_);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.165,
                              child: TextFormField(
                                controller: manageProductDocItemCtl
                                    .incomePriceController,
                                style: textStyleBlack18,
                                decoration: customInputDecoration(
                                  PlaceholderTexts.income_price_with_number,
                                ),
                                onChanged: (value) {
                                  manageProductDocItemCtl
                                      .setIncomePrice(context);
                                },
                                validator: (p0) =>
                                    NumberValidator.validPrice(p0!),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.165,
                              child: TextFormField(
                                style: textStyleBlack18,
                                controller:
                                    manageProductDocItemCtl.sellPriceController,
                                decoration: customInputDecoration(
                                  PlaceholderTexts.selling_price_with_number,
                                ),
                                onChanged: (value) {
                                  manageProductDocItemCtl.setSellPrice(context);
                                  manageProductDocItemCtl
                                      .calculateSellingProfitPercentage();
                                },
                                validator: (value) =>
                                    NumberValidator.validPrice(
                                        value!.replaceAll(",", "")),
                              ),
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
                                  if (manageProductDocItemCtl
                                          .sellingCurrency.value.name
                                          .toLowerCase() ==
                                      'uzs')
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
                                      "${index + 1}. (${item.category.name}) ${item.name}",
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
