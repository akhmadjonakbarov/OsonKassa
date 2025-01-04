import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../../core/display/user_notifier.dart';
import '../../../../../core/enums/product_doc_type.dart';
import '../../../../../core/enums/type_of_snackbar.dart';
import '../../../../../core/validator/number_validator.dart';
import '../../../../../styles/container_decoration.dart';

import '../../../../../styles/text_input_styles.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../utils/media/get_screen_size.dart';
import '../../../../../utils/texts/button_texts.dart';
import '../../../../../utils/texts/display_texts.dart';
import '../../../../../utils/texts/placeholder_texts.dart';
import '../../../../shared/export_commons.dart';
import '../../../category/logic/category_controller.dart';
import '../../../currency/logic/currency_controller.dart';
import '../../../currency/models/models.dart';
import '../../../item/logic/item_ctl.dart';
import '../../../item/models/item_model.dart';
import 'package:osonkassa/app/features/dashboard_views/note/logic/note_controller.dart';
import '../../logic/document/document_ctl.dart';
import '../../logic/view_controller/manage_product_doc_item_ctl.dart';
import 'widgets/cached_products_table.dart';

import 'widgets/header_currency.dart';
import 'widgets/radio_button.dart';
import 'widgets/show_price_qty.dart';

enum CurrencyType { usd, uzs }

class EditProductDocItemScreen extends StatefulWidget {
  const EditProductDocItemScreen({super.key});

  @override
  State<EditProductDocItemScreen> createState() =>
      _EditProductDocItemScreenState();
}

class _EditProductDocItemScreenState extends State<EditProductDocItemScreen> {
  final _productDocItemKey = GlobalKey<FormState>();

  final CurrencyCtl currencyCtl = Get.find<CurrencyCtl>();
  final ItemCtl itemCtl = Get.find<ItemCtl>();
  final DocumentCtl storeCtl = Get.find<DocumentCtl>();
  final CategoryCtl categoryCtl = Get.find<CategoryCtl>();
  final ManageProductDocItemCtl manageProductDocItemCtl =
      Get.find<ManageProductDocItemCtl>();

  final NoteCtl spiskaCtl = Get.find<NoteCtl>();

  @override
  void initState() {
    super.initState();
    reloadFetchItems();
  }

  reloadFetchItems() {
    currencyCtl.fetchItems();
    storeCtl.fetchItems();
    categoryCtl.fetchItems();
    itemCtl.removeSelectedCategory();
  }

  @override
  void dispose() {
    if (manageProductDocItemCtl.productDocItems.isNotEmpty) {
      _submitForm();
    }
    super.dispose();
  }

  final NumberFormat numberFormatterForUSD =
      NumberFormat.currency(locale: 'en_US', symbol: '\$');

  final MultiSelectController multiSelectControllerCategory =
      MultiSelectController();

  CurrencyType currencyType = CurrencyType.usd;

  int category_id = 0;
  double percentageOfPrice = 0;
  double currencyValue = 0.0;
  int currencyId = -1;
  bool isUSDConvert = false;
  bool isUSD = false;
  double priceAtUSD = 0.0;
  String currency_type = '';
  double priceAtUZS = 0.0;
  double priceValue = 0.0;
  double totalPriceOfProducts = 0.0;
  double quantityOfProduct = 0;

  double sellingPrice = 0.0;
  double profit = 0.0;
  CurrencyModel currency = CurrencyModel.empty();

  Map<String, dynamic> productDocData = {
    "reg_date": DateTime.now(),
    "doc_type": ProductDocType.none.name,
    "product_doc_items": <Map<String, dynamic>>[],
  };

  Map<String, dynamic> productDocItem = {
    "id": UniqueKey().toString(),
    "qty": -1,
    "item": -1,
    "can_be_cheaper": false,
    "income_price": 0.0,
    "currency_type": '',
    "income_price_usd": 0.0,
    "selling_percentage": 0.0,
    "selling_price": 0.0,
    "currency": null,
  };

  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _incomePriceController = TextEditingController();
  final TextEditingController _qtyKgController = TextEditingController();

  void calculateSellingPrice() {
    String textSellingPrice = _sellingPriceController.text.replaceAll(',', '');
    if (textSellingPrice == "0" ||
        textSellingPrice == "" ||
        double.tryParse(textSellingPrice) == null ||
        double.parse(textSellingPrice) < priceValue ||
        double.parse(textSellingPrice) < priceAtUZS) {
      setState(() {
        sellingPrice = 0;
      });
    } else {
      setState(() {
        sellingPrice =
            double.parse(_sellingPriceController.text.replaceAll(',', ''));
      });
    }

    calculatePrice();
    calculateProfit();
    calculatePercentageDifference();
  }

  void calculateProfit() {
    setState(() {
      if (sellingPrice > 0) {
        profit = ((sellingPrice * quantityOfProduct) - totalPriceOfProducts);
      } else {
        profit = 0;
      }
    });
  }

  void chooseItemPriceData(ItemModel item) {
    // setState(() {
    //   if (item.doc_item != null) {
    //     if (item.doc_item!.income_price_usd > 0) {
    //       isUSDConvert = true;
    //       priceValue = item.doc_item!.income_price_usd;
    //       _incomePriceController.text = priceValue.toString();
    //     } else {
    //       priceValue = item.doc_item!.income_price;
    //       _incomePriceController.text = priceValue.toString();
    //       isUSDConvert = false;
    //     }

    //     _sellingPriceController.text = item.doc_item!.selling_price.toString();
    //     sellingPrice = item.doc_item!.selling_price;
    //     percentageOfPrice = double.parse(
    //       item.doc_item!.selling_percentage.toStringAsFixed(2),
    //     );
    //   }
    // });
  }

  void calculatePrice() {
    setState(() {
      if (_incomePriceController.text.isEmpty) {
        priceValue = 0.0;
      } else {
        priceValue = double.parse(_incomePriceController.text);
      }

      priceAtUZS = isUSDConvert ? priceValue * currencyValue : priceValue;
      if (isUSDConvert) {
        priceAtUZS = priceValue * currencyValue;
        priceAtUSD = priceValue;
      } else {
        priceAtUSD = 0.0;
        priceAtUZS = priceValue;
      }

      totalPriceOfProducts = quantityOfProduct * priceAtUZS;
      calculateProfit();
    });
  }

  calculatePercentageDifference() {
    if (isUSDConvert) {
      percentageOfPrice = ((sellingPrice / priceAtUZS) * 100) - 100;
    } else {
      setState(() {
        percentageOfPrice = 0;
      });
    }
  }

  bool isItemSelected() {
    return productDocItem['item'] != -1;
  }

  void addProductBadge() {
    if (_productDocItemKey.currentState!.validate()) {
      if (isItemSelected()) {
        productDocItem['qty'] = quantityOfProduct;
        productDocItem['qty_kg'] = _qtyKgController.text.toString();
        productDocItem['currency_type'] = currencyType.name;
        productDocItem['income_price'] =
            double.parse(priceAtUZS.toStringAsFixed(4));
        productDocItem['selling_price'] =
            double.parse(sellingPrice.toStringAsFixed(4));
        productDocItem['selling_percentage'] =
            double.parse(percentageOfPrice.toStringAsFixed(4));
        productDocItem['income_price_usd'] =
            double.parse(priceAtUSD.toStringAsFixed(4));
        if (isUSDConvert) {
          productDocItem['currency'] = currency.toMap();
        } else {
          productDocItem['currency'] = CurrencyModel.empty().toMap();
        }

        manageProductDocItemCtl.storeProductDocItem(productDocItem);

        _reset();
      } else {
        UserNotifier.showSnackBar(
          type: TypeOfSnackBar.alert,
          label: "Mahsulotni tanlang",
        );
      }
    }
  }

  void _submitForm() {
    productDocData['reg_date'] = DateTime.now().toString();
    productDocData['product_doc_items'] =
        manageProductDocItemCtl.productDocItems;

    productDocData['doc_type'] = ProductDocType.buy.name;

    storeCtl.addItem(productDocData);
    manageProductDocItemCtl.clearStoreProductDocItemList();
    _reset();
  }

  void _reset() {
    _productDocItemKey.currentState!.reset();
    _sellingPriceController.clear();
    _incomePriceController.clear();
    _qtyKgController.clear();

    itemCtl.fetchItems();
    spiskaCtl.fetchItems();

    productDocData = {
      "reg_date": DateTime.now().toString(),
      "doc_type": ProductDocType.none.name,
      "product_doc_items": <Map<String, dynamic>>[],
    };

    productDocItem = {
      "id": UniqueKey().toString(),
      "qty": -1,
      "qty_kg": -1,
      "item": -1,
      "can_be_cheaper": false,
      "income_price": 0.0,
      'income_price_usd': 0.0,
      "selling_price": 0.0,
      "selling_percentage": 0.0,
      "currency": null,
    };
    itemCtl.resetItem();

    setState(() {
      sellingPrice = 0.0;
      priceValue = 0.0;
      percentageOfPrice = 0;
      quantityOfProduct = 0;
      totalPriceOfProducts = 0.0;
    });
    reloadFetchItems();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (currencyCtl.list.isNotEmpty) {
        currency = currencyCtl.list.first;
        currencyValue = currency.value;
        currencyId = currency.id;
      }
    });
    Size screenSize = getScreenSize(context);

    return AppContainer(
      height: screenSize.height,
      margin: const EdgeInsets.only(top: 20),
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              HeaderCurrency(
                currencyValue: currencyValue,
                constraints: constraints,
              ),
              const SizedBox(height: 15),
              Form(
                key: _productDocItemKey,
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
    return AppContainer(
      padding: const EdgeInsets.only(bottom: 10),
      width: constraints.maxWidth * 0.72,
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          AppContainer(
            padding: const EdgeInsets.all(10),
            decoration: containerDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Pul birligi:",
                      style: textStyleBlack18Bold,
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.007,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: CurrencyType.usd == currencyType
                              ? Colors.blue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15)),
                      child: CustomRadioButton(
                        label: "USD",
                        value: CurrencyType.usd,
                        currencyType: currencyType,
                        onChanged: (CurrencyType value) {
                          setState(() {
                            currencyType = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.005,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: CurrencyType.uzs == currencyType
                            ? Colors.blue
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: CustomRadioButton(
                        value: CurrencyType.uzs,
                        label: "UZS",
                        currencyType: currencyType,
                        onChanged: (CurrencyType value) {
                          setState(() {
                            currencyType = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.05,
                    ),
                    if (CurrencyType.uzs == currencyType)
                      Row(
                        children: [
                          Checkbox(
                            value: isUSDConvert,
                            onChanged: (value) {
                              setState(() {
                                isUSDConvert = value!;
                                calculatePrice();
                              });

                              calculateSellingPrice();
                            },
                          ),
                          Text(
                            "\$ USD",
                            style: textStyleBlack18,
                          ),
                        ],
                      )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildQuantityField(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.165,
                      child: TextFormField(
                        controller: _incomePriceController,
                        style: textStyleBlack18,
                        decoration: customInputDecoration(
                          PlaceholderTexts.income_price_with_number,
                        ),
                        onChanged: (value) {
                          calculatePrice();
                        },
                        validator: (p0) => NumberValidator.validPrice(p0!),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.165,
                      child: TextFormField(
                        style: textStyleBlack18,
                        controller: _sellingPriceController,
                        decoration: customInputDecoration(
                          PlaceholderTexts.selling_price,
                        ),
                        onChanged: (value) {
                          setState(() {
                            calculateSellingPrice();
                          });
                        },
                        validator: (value) => NumberValidator.validPrice(
                            value!.replaceAll(",", "")),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: constraints.maxWidth * 0.028,
                    top: 2,
                  ),
                  child: Column(
                    children: [
                      if (isUSDConvert)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${percentageOfPrice.toStringAsFixed(3)} %",
                              style: textStyleBlack18,
                            ),
                            SizedBox(
                              width: constraints.maxHeight * 0.09,
                            ),
                            Text(
                              sellingPrice == 0
                                  ? ""
                                  : "${formatPriceAtUZS(sellingPrice, isUSD: true)} ",
                              style: textStyleBlack18,
                            ),
                          ],
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (CurrencyType.usd == currencyType)
                              Text(
                                sellingPrice == 0
                                    ? ""
                                    : "${formatPriceAtUZS(sellingPrice, isUSD: true)} ",
                                style: textStyleBlack18,
                              )
                            else
                              Text(
                                sellingPrice == 0
                                    ? ""
                                    : "${formatPriceAtUZS(sellingPrice)} ",
                                style: textStyleBlack18,
                              ),
                            SizedBox(
                              width: constraints.maxHeight * 0.04,
                            ),
                          ],
                        ),
                      SizedBox(
                        height: constraints.maxHeight * 0.02,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ShowPriceQtyOfProduct(
                  isUSD: isUSDConvert,
                  priceValue: priceValue,
                  quantity: quantityOfProduct,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isUSDConvert) ...[
                      Text(
                        "${DisplayTexts.price_of_product_in_uzs}: ${formatPrice(currencyValue, priceValue)} = ${formatPriceAtUZS(priceAtUZS)}",
                        style: textStyleBlack18.copyWith(fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (CurrencyType.usd == currencyType)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DisplayTexts.total_of_product_price}: ${formatPriceAtUZS(priceAtUZS, isUSD: true)} * $quantityOfProduct = ${formatTotalPrice(totalPriceOfProducts, isUSD: true)}",
                            style: textStyleBlack18.copyWith(fontSize: 22),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${DisplayTexts.total_profit}: ${formatPriceAtUZS(profit, isUSD: true)}",
                            style: textStyleBlack18.copyWith(fontSize: 22),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DisplayTexts.total_of_product_price}: ${formatPriceAtUZS(priceAtUZS)} * $quantityOfProduct = ${formatTotalPrice(totalPriceOfProducts)}",
                            style: textStyleBlack18.copyWith(fontSize: 22),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${DisplayTexts.total_profit}: ${formatPriceAtUZS(profit)}",
                            style: textStyleBlack18.copyWith(fontSize: 22),
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
  }

  Widget _buildQuantityField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.165,
          child: TextFormField(
            style: textStyleBlack18,
            onChanged: (p0) {
              setState(() {
                quantityOfProduct =
                    p0.trim().isEmpty ? 0 : double.tryParse(p0) ?? 0;
                calculatePrice();
              });
            },
            decoration: customInputDecoration(PlaceholderTexts.qty_of_product),
            validator: (p0) => NumberValidator.validPrice(p0!, isDouble: false),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.165,
          child: TextFormField(
            controller: _qtyKgController,
            style: textStyleBlack18,
            decoration: customInputDecoration("Mahsulot kg-da *"),
          ),
        ),
      ],
    );
  }

  Widget _buildRightSide(BoxConstraints constraints) {
    return AppContainer(
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
                                ItemModel item = itemCtl.list[index];
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
                                          productDocItem['item'] = -1;
                                          _reset();
                                        } else {
                                          itemCtl.selectItem(item);
                                          chooseItemPriceData(item);
                                          productDocItem['item'] = item.toMap();
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
