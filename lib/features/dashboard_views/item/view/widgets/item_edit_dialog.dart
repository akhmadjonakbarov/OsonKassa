import 'package:flutter/material.dart';
import 'package:osonkassa/features/dashboard_views/type/presentation/controller/type_controller.dart';
import 'package:osonkassa/features/shared/export_commons.dart';

import '../../../category/logic/category_controller.dart';
import '../../../company/logic/company_ctl.dart';
import '../../../document/models/document_item.dart';
import '../../logic/item_ctl.dart';
import '../../../../unit/logic/unit_controller.dart';

import '../../../../../styles/colors.dart';
import '../../../../../styles/text_styles.dart';

import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class ItemEditDialog extends StatefulWidget {
  const ItemEditDialog({super.key});

  @override
  State<ItemEditDialog> createState() => _ItemEditDialogState();
}

class _ItemEditDialogState extends State<ItemEditDialog> {
  final ItemCtl itemCtl = Get.find<ItemCtl>();
  final CategoryCtl categoryCtl = Get.find<CategoryCtl>();
  final UnitCtl unitCtl = Get.find<UnitCtl>();
  final CompanyCtl companyCtl = Get.find<CompanyCtl>();
  final TypeController typeCtl = Get.find<TypeController>();

  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController barcodeController;
  late TextEditingController salePriceController;
  late TextEditingController incomePriceController;

  String selectedCurrency = "uzs";

  Map<String, dynamic> categoryData = {};
  Map<String, dynamic> companyData = {};
  Map<String, dynamic> unitData = {};
  List<Map<String, dynamic>> typeData =
      []; // Changed to List for multiple types

  @override
  void initState() {
    super.initState();

    // Fetch dropdown data
    companyCtl.fetchItems();
    categoryCtl.fetchItems();
    unitCtl.fetchItems();
    typeCtl.getTypes();

    if (itemCtl.selectedItem.value != null) {
      final item = itemCtl.selectedItem.value!;
      nameController = TextEditingController(text: item.name ?? "");
      barcodeController = TextEditingController(text: item.barcode ?? "");
      salePriceController =
          TextEditingController(text: item.salePrice?.toString() ?? "");
      incomePriceController =
          TextEditingController(text: item.incomePrice?.toString() ?? "");

      selectedCurrency = item.currencyType ?? "uzs";

      itemCtl.calculateSellPercentage(
        incomePrice: item.incomePrice?.toString() ?? "",
        salePrice: item.salePrice?.toString() ?? "",
      );

      // Preselect existing relations
      final t = typeCtl.types
          .where((e) => item.type != null && item.type!.contains(e.name!))
          .toList();
      if (t.isNotEmpty) {
        typeData = t
            .map((e) => {'id': e.id, 'name': e.name})
            .toList(); // Populate selected types
      }

      final cat = categoryCtl.list.firstWhereOrNull(
        (e) => e.name.toLowerCase() == item.category?.toLowerCase(),
      );
      if (cat != null) categoryData = {'id': cat.id, 'name': cat.name};

      final un = unitCtl.list.firstWhereOrNull(
        (e) => e.value.toLowerCase() == item.unit?.toLowerCase(),
      );
      if (un != null) unitData = {'id': un.id, 'value': un.value};
    } else {
      nameController = TextEditingController();
      barcodeController = TextEditingController();
      salePriceController = TextEditingController();
      incomePriceController = TextEditingController();
    }
  }

  void _save() {
    if (!formKey.currentState!.validate()) return;

    final selectedProduct = itemCtl.selectedItem.value;

    if (selectedProduct != null) {
      // final updatedItem = itemCtl.selectedItem.value!.copyWith(
      //   name: nameController.text.trim(),
      //   barcode: barcodeController.text.trim(),
      //   salePrice: double.tryParse(salePriceController.text) ?? 0.0,
      //   incomePrice: double.tryParse(incomePriceController.text) ?? 0.0,
      //   currencyType: selectedCurrency,
      //   category: categoryData['name'],
      //   unit: unitData['value'],
      //   company: companyData['name'],
      //   type: typeData.map((e) => e['name']).join(','),
      //   // Join names for multiple types
      //   updatedAt: DateTime.now(),
      // );
      // itemCtl.updateItem(updatedItem);
      final Item newProduct = Item(
        name: nameController.text.trim(),
        barcode: barcodeController.text.trim(),
        salePrice: double.tryParse(salePriceController.text) ?? 0.0,
        incomePrice: double.tryParse(incomePriceController.text) ?? 0.0,
        currencyType: selectedCurrency,
        category: categoryData['name'],
        unit: unitData['name'],
        company: companyData['name'],
        type: typeData
            .map((e) => e['name'])
            .join(','), // Join names for multiple types
      );
      itemCtl.updateProduct(newProduct.toMapForCreate(
        itemId: selectedProduct.id!,
        categoryId: categoryData['id'],
        unitId: unitData['id'],
        typeIds: typeData.map((e) => int.parse(e['id'].toString())).toList(),
        name: nameController.text.trim(),
        barcode: barcodeController.text.trim(),
        salePrice: double.tryParse(salePriceController.text) ?? 0.0,
        incomePrice: double.tryParse(incomePriceController.text) ?? 0.0,
        currencyType: selectedCurrency,
      ));
    } else {
      final Item newItem = Item(
        name: nameController.text.trim(),
        barcode: barcodeController.text.trim(),
        salePrice: double.tryParse(salePriceController.text) ?? 0.0,
        incomePrice: double.tryParse(incomePriceController.text) ?? 0.0,
        currencyType: selectedCurrency,
        category: categoryData['name'],
        unit: unitData['name'],
        company: companyData['name'],
        type: typeData
            .map((e) => e['name'])
            .join(','), // Join names for multiple types
      );
      itemCtl.addItem(newItem.toMapForCreate(
        categoryId: categoryData['id'],
        unitId: unitData['id'],
        typeIds: typeData.map((e) => int.parse(e['id'].toString())).toList(),
        name: nameController.text.trim(),
        barcode: barcodeController.text.trim(),
        salePrice: double.tryParse(salePriceController.text) ?? 0.0,
        incomePrice: double.tryParse(incomePriceController.text) ?? 0.0,
        currencyType: selectedCurrency,
      ));
    }

    itemCtl.resetItem();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Obx(() => Text(
                      itemCtl.selectedItem.value != null
                          ? "edit_product".tr
                          : "add_product".tr,
                      style: textStyleBlack20,
                    )),
                const Divider(),
                const SizedBox(height: 12),

                // Company, Category & Type Row
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => MultiSelectDropDown<int>(
                            singleSelectItemStyle: textStyleBlack18,
                            optionTextStyle: textStyleBlack18,
                            selectedOptions: companyData['id'] != null
                                ? [
                                    ValueItem(
                                      label: companyData['name'],
                                      value: companyData['id'],
                                    )
                                  ]
                                : [],
                            onOptionSelected: (selectedOptions) {
                              setState(() {
                                companyData['id'] = selectedOptions.first.value;
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
                            hint: "company".tr,
                            hintStyle:
                                textStyleBlack18.copyWith(color: Colors.grey),
                          )),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Obx(() => MultiSelectDropDown<int>(
                            singleSelectItemStyle: textStyleBlack18,
                            optionTextStyle: textStyleBlack18,
                            selectedOptions: categoryData['id'] != null
                                ? [
                                    ValueItem(
                                      label: categoryData['name'],
                                      value: categoryData['id'],
                                    )
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
                            hint: "category".tr,
                            hintStyle:
                                textStyleBlack18.copyWith(color: Colors.grey),
                          )),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Obx(() => MultiSelectDropDown(
                            singleSelectItemStyle: textStyleBlack18,
                            optionTextStyle: textStyleBlack18,
                            selectedOptions: typeData.isNotEmpty
                                ? typeData
                                    .map((type) => ValueItem(
                                          label: type['name'],
                                          value: type['id'],
                                        ))
                                    .toList()
                                : [],
                            onOptionSelected: (selectedOptions) {
                              setState(() {
                                typeData = selectedOptions
                                    .map((option) => {
                                          'id': option.value,
                                          'name': option.label,
                                        })
                                    .toList();
                              });
                            },
                            options: typeCtl.types
                                .map((e) =>
                                    ValueItem(label: e.name!, value: e.id))
                                .toList(),
                            selectionType: SelectionType.multi,
                            // Allow multiple selection
                            searchEnabled: true,
                            hint: "type".tr,
                            hintStyle:
                                textStyleBlack18.copyWith(color: Colors.grey),
                          )),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Name & Barcode
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) =>
                            value!.isEmpty ? "Enter name" : null,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "name".tr,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextFormField(
                        controller: barcodeController,
                        validator: (value) =>
                            value!.isEmpty ? "Enter barcode" : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Barcode",
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Prices & Currency
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: incomePriceController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter income price" : null,
                        onChanged: (value) {
                          itemCtl.calculateSellPercentage(incomePrice: value);
                          print(itemCtl.sellPercentage.value); // ✅ correct
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "income_price".tr,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextFormField(
                        controller: salePriceController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter sale price" : null,
                        onChanged: (value) {
                          itemCtl.calculateSellPercentage(salePrice: value);
                          print(itemCtl.sellPercentage.value); // ✅ correct
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "sale_price".tr,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Obx(
                      () => Text(
                        '${itemCtl.sellPercentage.value.toStringAsFixed(2)}%',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedCurrency,
                        items: ['uzs', 'usd', 'eur']
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value.toUpperCase()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => selectedCurrency = value!);
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "currency".tr,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Unit
                Obx(() {
                  return MultiSelectDropDown<int>(
                    singleSelectItemStyle: textStyleBlack18,
                    optionTextStyle: textStyleBlack18,
                    selectedOptions: unitData['id'] != null
                        ? [
                            ValueItem(
                              label: unitData['value'],
                              value: unitData['id'],
                            )
                          ]
                        : [],
                    onOptionSelected: (selectedOptions) {
                      if (selectedOptions.isNotEmpty) {
                        unitData['id'] = selectedOptions.first.value;
                        unitData['value'] = selectedOptions.first.label;
                      }
                    },
                    options: unitCtl.list
                        .map((unit) =>
                            ValueItem(label: unit.value, value: unit.id))
                        .toList(),
                    selectionType: SelectionType.single,
                    searchEnabled: true,
                    hint: "unit".tr,
                    hintStyle: textStyleBlack18.copyWith(color: Colors.grey),
                  );
                }),

                const SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmallButtonText(
                      bgColor: Colors.red,
                      textStyle: textStyleBlack15.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      buttonSize: const Size(150, 40),
                      onClick: () => Navigator.of(context).pop(),
                      text: "cancel".tr,
                    ),
                    SmallButtonText(
                      bgColor: Colors.green,
                      textStyle: textStyleBlack15.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      buttonSize: const Size(150, 40),
                      onClick: _save,
                      text: "add".tr,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
