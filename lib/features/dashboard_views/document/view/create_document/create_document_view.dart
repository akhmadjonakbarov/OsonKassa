import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/core/display/user_notifier.dart';
import 'package:osonkassa/features/dashboard_views/document/view/controllers/document_event.dart';
import 'package:osonkassa/features/shared/widgets/buttons/primary_button.dart';

import '../../../../../core/enums/product_doc_type.dart';
import '../../../../../core/validator/number_validator.dart';
import '../../../../../styles/text_input_styles.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../styles/themes.dart';
import '../../../../../utils/globals.dart';
import '../../../../../utils/helper/log_helper.dart';
import '../../../../../utils/texts/placeholder_texts.dart';
import '../../../../shared/export_commons.dart';
import '../../../category/logic/category_controller.dart';
import '../../../currency/logic/currency_controller.dart';
import '../../../currency/models/currency.dart';
import '../../../item/logic/item_ctl.dart';
import '../../../item/domain/models/item.dart';
import '../../../note/logic/note_controller.dart';
import '../../logic/document/document_ctl.dart';
import '../../logic/view_controller/manage_product_doc_item_ctl.dart';
import '../../models/draft_document.dart';
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
  final DocumentCtl documentCtl = Get.find<DocumentCtl>();
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

  @override
  void initState() {
    super.initState();
    once(
      documentCtl.events,
      (callback) {
        if (callback is DocumentCreated) {
          messengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text('Document created successfully!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }

  reloadFetchItems() {
    currencyCtl.fetchItems();
    documentCtl.fetchItems();
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
    DraftDocument draftDocument = DraftDocument(
      docType: DocumentType.buy.name,
      products: manageProductDocItemCtl.productDocItems,
    );

    LogHelper.logInfo("Document: ${draftDocument.toMap()}");

    documentCtl.addItem(draftDocument.toMap());
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
      height: double.infinity,
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
    return BasicContainer(
      width: constraints.maxWidth * 0.72,
      child: CachedProductsTable(
        manageProductDocItemCtl: manageProductDocItemCtl,
      ),
    );
  }

  Widget _buildRightSide(BoxConstraints constraints) {
    return BasicContainer(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16)),
      width: constraints.maxWidth * 0.27,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'products'.tr,
                style: textStyleBlack18.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 15),
              Obx(
                () => SizedBox(
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
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (context, index) {
                              Item item = itemCtl.list[index];

                              return Obx(() {
                                final exists = manageProductDocItemCtl
                                    .isExistInSelectedItems(item);
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: constraints.minWidth * 0.002,
                                  ),
                                  decoration: BoxDecoration(
                                    color: exists ? Colors.blue : Colors.white,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "${index + 1}. (${item.category}) ${item.name} ${item.type == null ? '' : "${item.type}"}",
                                      style: textStyleBlack18.copyWith(
                                        color: exists
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    onTap: () {
                                      manageProductDocItemCtl
                                          .addOrRemoveSelectItem(item);
                                    },
                                  ),
                                );
                              });
                            },
                            itemCount: itemCtl.list.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: manageProductDocItemCtl.quantityController,
                  style: textStyleBlack18,
                  onChanged: (p0) {
                    manageProductDocItemCtl.setQty(context);
                  },
                  decoration:
                      customInputDecoration(PlaceholderTexts.qty_of_product),
                  validator: (p0) =>
                      NumberValidator.validPrice(p0!, isDouble: false),
                ),
              ),
            ],
          ),
          SizedBox(
            height: constraints.maxHeight * 0.02,
          ),
          Row(
            children: [
              Expanded(
                  child: PrimaryButton(
                      backgroundColor: Colors.green,
                      onPressed: addProductBadge,
                      child: Text(
                        'add'.tr,
                        style: textStyleBlack18.copyWith(
                          color: Colors.white,
                        ),
                      ))),
              SizedBox(
                width: constraints.maxHeight * 0.02,
              ),
              Expanded(
                  child: Obx(
                () => PrimaryButton(
                  isLoading: documentCtl.isSaving.value,
                  onPressed: _submitForm,
                  child: Text(
                    'save'.tr,
                    style: textStyleBlack18.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
