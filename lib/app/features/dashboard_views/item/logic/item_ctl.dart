import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:osonkassa/app/utils/helper/log_helper.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/interfaces/api/add.dart';
import '../../../../core/interfaces/api/delete.dart';
import '../../../../core/interfaces/api/get_all.dart';
import '../../../../core/interfaces/api/update.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../../../../styles/colors.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/helper/valid_alert.dart';
import '../../../../utils/texts/alert_texts.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/models/api_data.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../unit/logic/unit_controller.dart';
import '../../../unit/models/unit_model.dart';
import '../../category/logic/category_controller.dart';
import '../../category/models/category_models.dart';
import '../../company/logic/company_ctl.dart';
import '../../company/models/company_model.dart';
import '../constants/texts.dart';
import '../models/item.dart';
import 'item_repo.dart';
import 'item_service.dart';

class ItemCtl extends MainController<Item> {
  var categoryName = ''.obs;

  var selectedItem = Item().obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  // controllers
  final CategoryCtl categoryCtl = Get.find<CategoryCtl>();
  final UnitCtl unitCtl = Get.find<UnitCtl>();
  final CompanyCtl companyCtl = Get.find<CompanyCtl>();

  late final ItemRepo _productRepo;
  late final ItemService _productService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    _productRepo = ItemRepo(dio);
    _productService = ItemService(
      addRepository: _productRepo as Add<Map<String, dynamic>>,
      deleteRepository: _productRepo as Delete<int>,
      updateRepository: _productRepo as Update<Item>,
      getAllRepository: _productRepo as GetAllWithPagination<ApiData>,
    );

    super.onInit();
    fetchItems();
  }

  @override
  Future<void> fetchItems() async {
    try {
      setLoading(true);
      var data = await _productService.getAllItems(page: page.value);
      list(data.items.cast<Item>());
      pagination(data.pagination);
    } catch (e) {
      handleError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void selectItem(Item item, {BuildContext? context}) async {
    selectedItem(item);

    if (context != null) {
      editDialog(context);
    }
  }

  @override
  void addItem(Map<String, dynamic> item) async {
    try {
      bool isCreated = await _productService.addItem(item);
      if (isCreated) {
        UserNotifier.showSnackBar(
          label: AlertTexts.addAlert(item['name']),
          type: TypeOfSnackBar.success,
        );
        fetchItems();
      }
    } on BarcodeAlreadyExistException {
      handleError(AlertTexts.barcode_unique);
    } on InvalidDataException {
      handleError(AlertTexts.invalid_data);
    } catch (e) {
      rethrow;
    }
  }

  void removeSelectedCategory() {
    categoryName('');
    fetchItems();
  }

  @override
  void updateItem(Item item) async {
    try {
      bool isSuccess = await _productService.updateItem(item);
      if (isSuccess) {
        UserNotifier.showSnackBar(
          label: AlertTexts.updateAlert(item.name!),
          type: TypeOfSnackBar.update,
        );
        fetchItems();
      }
    } on BarcodeAlreadyExistException {
      handleError(AlertTexts.barcode_unique);
    } catch (e) {
      handleError(e.toString());
    }
  }

  void filterByCategory(String name) async {
    List<Item> filteredProducts = [];
    try {
      categoryName(name);
      await fetchItems();

      var products = list;

      // Filter products by category ID
      if (categoryIsSelected()) {
        filteredProducts = products
            .where((element) =>
                element.category!.trim().toLowerCase() ==
                categoryName.value.trim().toLowerCase())
            .toList();
      }

      list.assignAll(filteredProducts); // Use assignAll for observable lists
    } catch (e) {
      handleError(e.toString()); // Handle errors
    }
  }

  void searchProduct(String text) {
    // If text is empty, reset to the cached list without re-fetching
    if (text.isEmpty) {
      fetchItems();
      return;
    }

    try {
      // Convert search text to lowercase only once
      List<String> searchKeywords = text.toLowerCase().split(' ');

      // Filter products based on barcode or name
      var filteredProducts = list.where((product) {
        // Convert product name and category name to lowercase only once
        final productName = product.name!.toLowerCase();
        final categoryName = product.category!.toLowerCase();

        // Check if all keywords are found in either product name or category name
        return searchKeywords.every((keyword) =>
            productName.contains(keyword) || categoryName.contains(keyword));
      }).toList();

      // Filter by selected category if applicable
      if (categoryIsSelected()) {
        filteredProducts = filteredProducts
            .where((product) => product.category == categoryName.value)
            .toList();
      }

      // Update the observable list with the filtered products
      list(filteredProducts);
    } catch (e) {
      handleError(e.toString());
    }
  }

  void resetItem() {
    selectedItem(
      Item(),
    );
  }

  bool categoryIsSelected() {
    LogHelper.logInfo(categoryName.value.isNotEmpty.toString());
    LogHelper.logInfo(categoryName.value.toString());
    return categoryName.value.isNotEmpty;
  }

  @override
  void handleError(String e) {
    UserNotifier.showSnackBar(
      text: e,
      type: TypeOfSnackBar.error,
    );
  }

  @override
  void removeItem(int id) async {
    try {
      bool isDelete = await _productService.deleteItem(id);
      if (isDelete) {
        UserNotifier.showSnackBar(
          label: AlertTexts.deleted.capitalizeFirst!,
          type: TypeOfSnackBar.delete,
        );
      }
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
        type: TypeOfSnackBar.error,
      );
    } finally {
      fetchItems();
    }
  }

  void editDialog(BuildContext context) {
    companyCtl.fetchItems();
    categoryCtl.fetchItems();
    unitCtl.fetchItems();

    Map<String, dynamic> itemData = {
      'name': '',
      'barcode': '',
      'category': '',
      'unit': '',
      'company': '',
    };

    bool isCategoryNull = false;
    Map<String, dynamic> categoryData = CategoryModel.empty().toMap();
    Map<String, dynamic> unitData = UnitModel.empty().toMap();
    Map<String, dynamic> companyData = CompanyModel.empty().toMap();

    bool isNull = selectedItem.value.id == null;

    final TextEditingController itemNameController = TextEditingController();
    final TextEditingController barcodeController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    if (!isNull) {
      itemNameController.text = selectedItem.value.name!;
      barcodeController.text = selectedItem.value.barcode!;
      itemData['category'] = selectedItem.value.category;
      itemData['unit'] = selectedItem.value.unit;
      itemData['company'] = selectedItem.value.company;
    }

    final String actionText = isNull ? ButtonTexts.add : ButtonTexts.edit;

    for (CategoryModel category in categoryCtl.list) {
      if (category.name.toLowerCase() ==
          itemData['category'].toString().toLowerCase()) {
        categoryData['name'] = category.name;
        categoryData['id'] = category.id;
        break;
      }
    }

    for (UnitModel unit in unitCtl.list) {
      if (unit.value.toLowerCase() ==
          itemData['unit'].toString().toLowerCase()) {
        unitData['value'] = unit.value;
        unitData['id'] = unit.id;
        break;
      }
    }

    if (itemData['company'] != null) {
      for (CompanyModel company in companyCtl.list) {
        if (company.name.toLowerCase() ==
            itemData['company'].toString().toLowerCase()) {
          companyData['name'] = company.name;
          companyData['id'] = company.id;
          break;
        }
      }
    }

    double heightOfDialog = MediaQuery.of(context).size.height * 0.63;

    Get.dialog(
      AlertDialog(
        backgroundColor: primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: heightOfDialog,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    isNull
                        ? '${DisplayTexts.products} ${ButtonTexts.add}'
                        : '${DisplayTexts.products} ${ButtonTexts.edit}',
                    style: textStyleBlack18.copyWith(fontSize: 22),
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // Company Dropdown
                      Expanded(
                        child: Column(
                          children: [
                            Obx(
                              () => SizedBox(
                                height: 60,
                                child: MultiSelectDropDown<int>(
                                  selectedOptions: companyData['id'] != null
                                      ? [
                                          ValueItem(
                                            label: companyData['name'],
                                            value: companyData['id'],
                                          ),
                                        ]
                                      : [],
                                  onOptionSelected: (selectedOptions) {
                                    setState(() {
                                      companyData['id'] =
                                          selectedOptions.first.value;
                                      companyData['name'] =
                                          selectedOptions.first.label;
                                    });
                                  },
                                  options: companyCtl.list
                                      .map((e) =>
                                          ValueItem(label: e.name, value: e.id))
                                      .toList(),
                                  selectionType: SelectionType.single,
                                  searchEnabled: true,
                                  searchLabel:
                                      "${ButtonTexts.search} | ${DisplayTexts.company}",
                                  hint: DisplayTexts.company,
                                  hintStyle: textStyleBlack18.copyWith(
                                      color: Colors.grey),
                                  selectedOptionTextColor: Colors.white,
                                  selectedOptionBackgroundColor: bgButtonColor,
                                  dropdownBackgroundColor: primary,
                                  fieldBackgroundColor: primary,
                                  optionsBackgroundColor: primary,
                                  singleSelectItemStyle: textStyleBlack18,
                                  optionTextStyle: textStyleBlack14.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            if (isCategoryNull)
                              Text(
                                "Iltimos kompaniyani tanlang",
                                style: textStyleBlack14.copyWith(
                                    color: Colors.red, fontSize: 16),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      // Category Dropdown
                      Expanded(
                        child: Column(
                          children: [
                            Obx(
                              () => SizedBox(
                                height: 60,
                                child: MultiSelectDropDown<int>(
                                  selectedOptions: categoryData['id'] != null
                                      ? [
                                          ValueItem(
                                            label: categoryData['name'],
                                            value: categoryData['id'],
                                          ),
                                        ]
                                      : [],
                                  onOptionSelected: (selectedOptions) {
                                    setState(() {
                                      categoryData['id'] =
                                          selectedOptions.first.value;
                                      categoryData['name'] =
                                          selectedOptions.first.label;
                                    });
                                  },
                                  options: categoryCtl.list
                                      .map((e) =>
                                          ValueItem(label: e.name, value: e.id))
                                      .toList(),
                                  selectionType: SelectionType.single,
                                  searchEnabled: true,
                                  searchLabel:
                                      "${ButtonTexts.search} | ${DisplayTexts.categories}",
                                  hint: ProductViewTexts.category,
                                  hintStyle: textStyleBlack18.copyWith(
                                      color: Colors.grey),
                                  selectedOptionTextColor: Colors.white,
                                  selectedOptionBackgroundColor: bgButtonColor,
                                  dropdownBackgroundColor: primary,
                                  fieldBackgroundColor: primary,
                                  optionsBackgroundColor: primary,
                                  singleSelectItemStyle: textStyleBlack18,
                                  optionTextStyle: textStyleBlack14.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            if (isCategoryNull)
                              Text(
                                "Iltimos bo'limni tanlang",
                                style: textStyleBlack14.copyWith(
                                    color: Colors.red, fontSize: 16),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Name and Barcode Fields
                  Form(
                    key: formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: itemNameController,
                            validator: (value) {
                              if (value == "") {
                                return validField(
                                    DisplayTexts.name_of_product.toLowerCase());
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter
                            ],
                            style: textStyleBlack18,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: DisplayTexts.name_of_product,
                              hintStyle: textStyleBlack18.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: TextFormField(
                            controller: barcodeController,
                            validator: (value) {
                              if (value == "") {
                                return validField('barcode kiriting');
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter
                            ],
                            style: textStyleBlack18,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: "CODE 0123456789012",
                              hintStyle:
                                  textStyleBlack18.copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Barcode Generation Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Barcode nom asosida', style: textStyleWhite18),
                    onPressed: () {
                      if (itemNameController.text.isNotEmpty) {
                        String barCode = itemNameController.text
                            .trim()
                            .replaceAll(RegExp(r'[ ()]'), '')
                            .toLowerCase();
                        setState(() {
                          barcodeController.text = barCode;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  // Unit Selection
                  Obx(() {
                    final options = unitCtl.list
                        .map((unit) =>
                            ValueItem<int>(label: unit.value, value: unit.id))
                        .toList();

                    ValueItem<int>? selected;
                    if (unitData['id'] != null) {
                      selected = options.firstWhereOrNull(
                        (item) => item.value == unitData['id'],
                      );
                    }

                    return SizedBox(
                      height: 60,
                      child: MultiSelectDropDown<int>(
                        selectedOptions: selected != null ? [selected] : [],
                        onOptionSelected: (selectedOptions) {
                          if (selectedOptions.isNotEmpty) {
                            setState(() {
                              unitData['id'] = selectedOptions.first.value;
                              unitData['value'] = selectedOptions.first.label;
                            });
                          }
                        },
                        options: options,
                        selectionType: SelectionType.single,
                        searchEnabled: true,
                        searchLabel:
                            "${ButtonTexts.search} | ${DisplayTexts.unit}",
                        hint: ProductViewTexts.unit,
                        hintStyle:
                            textStyleBlack18.copyWith(color: Colors.grey),
                        selectedOptionTextColor: Colors.white,
                        selectedOptionBackgroundColor: bgButtonColor,
                        dropdownBackgroundColor: primary,
                        fieldBackgroundColor: primary,
                        optionsBackgroundColor: primary,
                        singleSelectItemStyle: textStyleBlack18,
                        optionTextStyle: textStyleBlack14.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DialogTextButton(
                        text: ButtonTexts.cancel,
                        onClick: () => Navigator.of(context).pop(),
                        textStyle: textStyleBlack14,
                        isNegative: true,
                      ),
                      DialogTextButton(
                        text: actionText,
                        textStyle: textStyleBlack14,
                        onClick: () {
                          bool isValid = formKey.currentState!.validate();

                          if (isValid && categoryData['id'] != 0) {
                            String itemName = itemNameController.text.trim();
                            String barCode = barcodeController.text.trim();

                            itemData = {
                              'name': itemName.capitalize,
                              'barcode': barCode,
                              'category_id': categoryData['id'],
                              'unit_id': unitData['id'],
                              'company_id': companyData['id'],
                            };

                            if (isNull) {
                              addItem(itemData);
                            } else {
                              Item item = selectedItem.value.copyWith(
                                name: itemData['name'],
                                barcode: itemData['barcode'],
                                category: categoryData['name'],
                                unit: unitData['value'],
                                company: companyData['name'],
                              );
                              updateItem(item);
                            }

                            Navigator.of(context).pop();
                          } else {
                            setState(() {
                              isCategoryNull = true;
                              heightOfDialog += 50;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
