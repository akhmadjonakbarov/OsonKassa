import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

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
import '../../../shared/widgets/buttons.dart';
import '../../../unit/logic/unit_controller.dart';
import '../../../unit/models/unit_model.dart';
import '../../category/logic/category_controller.dart';
import '../../category/models/category_models.dart';
import '../../company/logic/company_ctl.dart';
import '../../company/models/company_model.dart';
import '../constants/texts.dart';
import '../models/item_model.dart';
import 'item_repo.dart';
import 'item_service.dart';

class ItemCtl extends MainController<ItemModel> {
  var category_id = 0.obs;
  var company_id = 0.obs;

  var selectedItem = ItemModel.empty().obs;

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
      updateRepository: _productRepo as Update<ItemModel>,
      getAllRepository: _productRepo as GetAll<ItemModel>,
    );

    super.onInit();
  }

  @override
  Future<void> fetchItems() async {
    try {
      // Set loading state at the beginning
      setLoading(true);

      // Fetch items only if cache is empty, avoiding unnecessary API calls
      if (cachedList.isEmpty) {
        List<ItemModel> items = await _productRepo.getAll();

        // Cache the items and update observable list if there's a difference in data
        if (items.length != cachedList.length ||
            !areListsEqual(items, cachedList)) {
          cachedList(items);
          list(cachedList); // Only update list if data has changed
        }
      } else {
        list(cachedList); // Use cached list if available
      }
    } catch (e) {
      handleError(e.toString());
    } finally {
      // Ensure loading state is turned off
      setLoading(false);
    }
  }

// Helper function to check list equality
  bool areListsEqual(List<ItemModel> list1, List<ItemModel> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  void selectItem(ItemModel item, {BuildContext? context}) async {
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
    category_id(0);
    fetchItems();
  }

  @override
  void updateItem(ItemModel item) async {
    try {
      bool isSuccess = await _productService.updateItem(item);
      if (isSuccess) {
        UserNotifier.showSnackBar(
          label: AlertTexts.updateAlert(item.name),
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

  void filterByCategory(int id) async {
    List<ItemModel> filteredProducts = [];
    try {
      category_id(id);
      // Fetch all products
      final products = await _productService.getAllItems();

      // Filter products by category ID
      if (categoryIsSelected()) {
        filteredProducts = products
            .where((element) => element.category.id == category_id.value)
            .toList();
      } else {
        filteredProducts =
            products.where((element) => element.category.id == id).toList();
      }

      // Simulate delay if needed

      // Update the observable list with filtered products
      list.assignAll(filteredProducts); // Use assignAll for observable lists
    } catch (e) {
      handleError(e.toString()); // Handle errors
    }
  }

  void searchProduct(String text) async {
    // If text is empty, reset to the cached list without re-fetching
    if (text.isEmpty) {
      list(cachedList);
      return;
    }

    try {
      // Convert search text to lowercase only once
      List<String> searchKeywords = text.toLowerCase().split(' ');

      // Filter products based on barcode or name
      var filteredProducts = cachedList.where((product) {
        // Convert product name and category name to lowercase only once
        final productName = product.name.toLowerCase();
        final categoryName = product.category.name.toLowerCase();

        // Check if all keywords are found in either product name or category name
        return searchKeywords.every((keyword) =>
            productName.contains(keyword) || categoryName.contains(keyword));
      }).toList();

      // Filter by selected category if applicable
      if (categoryIsSelected()) {
        filteredProducts = filteredProducts
            .where((product) => product.category.id == category_id.value)
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
      ItemModel.empty(),
    );
  }

  bool categoryIsSelected() {
    return category_id.value != 0;
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
        fetchItems();
      }
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
        type: TypeOfSnackBar.error,
      );
    }
  }

  void editDialog(BuildContext context) {
    companyCtl.fetchItems();
    categoryCtl.fetchItems();
    unitCtl.fetchItems();

    Map<String, dynamic> itemData = {
      'name': '',
      'barcode': '',
      'category': CategoryModel.empty().toMap(),
      'units': <Map<String, dynamic>>[],
      'company': CompanyModel.empty().toMap(),
    };

    bool is_category_null = false;
    Set<int> selectedUnitIds = {};

    Map<String, dynamic> categoryData = CategoryModel.empty().toMap();
    // Map<String, dynamic> unitData = UnitModel.empty().toMap();
    Map<String, dynamic> companyData = CompanyModel.empty().toMap();

    bool isNull = selectedItem.value.id == 0;

    final TextEditingController item_name_controller = TextEditingController();
    final TextEditingController barcode_controller = TextEditingController();

    final formKey = GlobalKey<FormState>();

    if (!isNull) {
      item_name_controller.text = selectedItem.value.name;
      barcode_controller.text = selectedItem.value.barcode;
      itemData['category'] = selectedItem.value.category.toMap();
      itemData['units'] = selectedItem.value.units;
      itemData['company'] = selectedItem.value.company?.toMap();
      selectedUnitIds.addAll(
        selectedItem.value.units.map((unit) => unit.id),
      );
    }

    final String actionText = isNull ? ButtonTexts.add : ButtonTexts.edit;

    for (CategoryModel category in categoryCtl.list) {
      if (category.id == itemData['category']['id']) {
        categoryData['name'] = category.name;
        categoryData['id'] = category.id;
        break;
      }
    }

    if (itemData['company'] != null) {
      for (CompanyModel company in companyCtl.list) {
        if (company.id == itemData['company']['id']) {
          companyData['name'] = company.name;
          companyData['id'] = company.id;
          break;
        }
      }
    } else {
      itemData['company'] = CompanyModel.empty().toMap();
    }

    double heightOfDialog = MediaQuery.of(context).size.height * 0.63;

    Get.dialog(Dialog(
      backgroundColor: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          if (itemData['category']['id'] != 0) {
            setState(
              () {
                is_category_null = false;
                heightOfDialog = MediaQuery.of(context).size.height * 0.63;
              },
            );
          }

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
                  style: textStyleBlack18.copyWith(
                    fontSize: 22,
                  ),
                ),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Obx(
                            () => SizedBox(
                              height: 60,
                              child: MultiSelectDropDown<int>(
                                selectedOptions:
                                    !isNull || company_id.value != 0
                                        ? [
                                            ValueItem(
                                              label: companyData['name'],
                                              value: companyData['id'],
                                            ),
                                          ]
                                        : [],
                                onOptionSelected:
                                    (List<ValueItem> selectedOptions) {
                                  setState(
                                    () {
                                      itemData['company']['id'] =
                                          company_id.value != 0
                                              ? company_id.value
                                              : selectedOptions.first.value;
                                      itemData['company']['name'] =
                                          selectedOptions.last.label;
                                    },
                                  );
                                },
                                options: companyCtl.list.asMap().entries.map(
                                  (e) {
                                    return ValueItem(
                                      label: e.value.name,
                                      value: e.value.id,
                                    );
                                  },
                                ).toList(),
                                searchEnabled: true,
                                searchLabel:
                                    "${ButtonTexts.search} | ${DisplayTexts.company}",
                                borderRadius: 5,
                                selectionType: SelectionType.single,
                                chipConfig:
                                    const ChipConfig(wrapType: WrapType.wrap),
                                selectedOptionTextColor: Colors.white,
                                hintStyle: textStyleBlack18.copyWith(
                                    color: Colors.grey),
                                selectedOptionBackgroundColor: bgButtonColor,
                                dropdownBackgroundColor: primary,
                                fieldBackgroundColor: primary,
                                optionsBackgroundColor: primary,
                                singleSelectItemStyle: textStyleBlack18,
                                hint: DisplayTexts.company,
                                optionTextStyle: textStyleBlack14.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          if (is_category_null)
                            Text(
                              "Iltimos kompaniyani tanlang",
                              style: textStyleBlack14.copyWith(
                                  color: Colors.red, fontSize: 16),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                        child: Column(
                      children: [
                        Obx(
                          () => SizedBox(
                            height: 60,
                            child: MultiSelectDropDown<int>(
                              selectedOptions: !isNull || category_id.value != 0
                                  ? [
                                      ValueItem(
                                        label: categoryData['name'],
                                        value: categoryData['id'],
                                      ),
                                    ]
                                  : [],
                              onOptionSelected:
                                  (List<ValueItem> selectedOptions) {
                                setState(
                                  () {
                                    itemData['category']['id'] =
                                        category_id.value != 0
                                            ? category_id.value
                                            : selectedOptions.first.value;
                                    itemData['category']['name'] =
                                        selectedOptions.last.label;
                                  },
                                );
                              },
                              options: categoryCtl.list.asMap().entries.map(
                                (e) {
                                  return ValueItem(
                                    label: e.value.name,
                                    value: e.value.id,
                                  );
                                },
                              ).toList(),
                              searchEnabled: true,
                              searchLabel:
                                  "${ButtonTexts.search} | ${DisplayTexts.categories}",
                              borderRadius: 5,
                              selectionType: SelectionType.single,
                              chipConfig:
                                  const ChipConfig(wrapType: WrapType.wrap),
                              selectedOptionTextColor: Colors.white,
                              hintStyle:
                                  textStyleBlack18.copyWith(color: Colors.grey),
                              selectedOptionBackgroundColor: bgButtonColor,
                              dropdownBackgroundColor: primary,
                              fieldBackgroundColor: primary,
                              optionsBackgroundColor: primary,
                              singleSelectItemStyle: textStyleBlack18,
                              hint: ProductViewTexts.category,
                              optionTextStyle: textStyleBlack14.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        if (is_category_null)
                          Text(
                            "Iltimos bo'limni tanlang",
                            style: textStyleBlack14.copyWith(
                                color: Colors.red, fontSize: 16),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  child: Form(
                    key: formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: item_name_controller,
                            validator: (value) {
                              if (value == "") {
                                return validField(
                                  DisplayTexts.name_of_product.toLowerCase(),
                                );
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
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: barcode_controller,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      'Barcode nom asosida',
                      style: textStyleWhite18,
                    ),
                    onPressed: () {
                      if (item_name_controller.text.isNotEmpty) {
                        String bar_code = item_name_controller.text
                            .trim()
                            .replaceAll(' ', '')
                            .replaceAll('(', '')
                            .replaceAll(')', '')
                            .toLowerCase();

                        setState(
                          () {
                            barcode_controller.text = bar_code;
                          },
                        );
                      }
                    },
                  ),
                ),
                Obx(
                  () => Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: unitCtl.list.length,
                      itemBuilder: (context, index) {
                        final unit = unitCtl.list[index];
                        final bool isSelected =
                            selectedUnitIds.contains(unit.id);

                        return Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                            color: isSelected ? bgButtonColor : Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                unit.value.capitalizeFirst.toString(),
                                style: textStyleBlack18,
                              ),
                              Checkbox(
                                value: isSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedUnitIds.add(unit.id);
                                    } else {
                                      selectedUnitIds.remove(unit.id);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                      onClick: () {
                        bool isValid = formKey.currentState!.validate();
                        List units = [];
                        for (var element in unitCtl.list) {
                          for (var unitId in selectedUnitIds) {
                            if (element.id == unitId) {
                              units.add(element);
                              break;
                            }
                          }
                        }
                        if (isValid && itemData['category']['id'] != 0) {
                          String itemName = item_name_controller.text.trim();
                          String barCode = barcode_controller.text.trim();

                          for (var i = 0; i < units.length; i++) {
                            int indexOfUnit = units.indexOf(units[i]);
                            UnitModel unit = units[i];
                            units[indexOfUnit] = unit.toMap();
                          }
                          itemData = {
                            'name': itemName.capitalize,
                            'barcode': barCode,
                            'category': itemData['category'],
                            'units': units,
                            'company': itemData['company'],
                          };
                          if (isNull) {
                            addItem(itemData);
                          } else {
                            ItemModel item = selectedItem.value;
                            List<UnitModel> units = [];
                            for (var element in unitCtl.list) {
                              for (var unitId in selectedUnitIds) {
                                if (element.id == unitId) {
                                  units.add(element);
                                  break;
                                }
                              }
                            }

                            item = item.copyWith(
                              category: CategoryPublicModel.fromMap(
                                  itemData['category']),
                              units: units,
                              name: itemData['name'],
                              barcode: itemData['barcode'],
                              company: itemData['company'] != null
                                  ? CompanyModel.fromMap(itemData['company'])
                                  : CompanyModel.empty(),
                            );
                            updateItem(item);
                          }

                          Navigator.of(context).pop();
                        } else {
                          setState(
                            () {
                              is_category_null = true;
                              heightOfDialog = heightOfDialog + 50;
                            },
                          );
                        }
                      },
                      textStyle: textStyleBlack14,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    )).then((value) {
      resetItem();
      fetchItems();
    });
  }
}
