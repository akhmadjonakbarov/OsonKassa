import 'package:flutter/material.dart';

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
  const ItemEditDialog({
    super.key,
  });

  @override
  State<ItemEditDialog> createState() => _ItemEditDialogState();
}

class _ItemEditDialogState extends State<ItemEditDialog> {
  final ItemCtl itemCtl = Get.find<ItemCtl>();

  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController barcodeController;
  late TextEditingController salePriceController;
  late TextEditingController incomePriceController;

  String selectedCurrency = "uzs";

  Map<String, dynamic> categoryData = {};
  Map<String, dynamic> companyData = {};
  Map<String, dynamic> unitData = {};

  final CategoryCtl categoryCtl = Get.find<CategoryCtl>();
  final UnitCtl unitCtl = Get.find<UnitCtl>();
  final CompanyCtl companyCtl = Get.find<CompanyCtl>();

  @override
  void initState() {
    super.initState();

    // Fetch lists for dropdowns
    companyCtl.fetchItems();
    categoryCtl.fetchItems();
    unitCtl.fetchItems();

    if (itemCtl.selectedItem.value != null) {
      final item = itemCtl.selectedItem.value!;
      nameController = TextEditingController(text: item.name ?? "");
      barcodeController = TextEditingController(text: item.barcode ?? "");
      salePriceController =
          TextEditingController(text: item.salePrice?.toString() ?? "");
      incomePriceController =
          TextEditingController(text: item.incomePrice?.toString() ?? "");
      selectedCurrency = item.currencyType ?? "uzs";

      // if (itemCtl.selectedItem.value.company != null) {
      //   final comp = companyCtl.list.firstWhereOrNull((e) =>
      //       e.name.toLowerCase() ==
      //       widget.item.company.toString().toLowerCase());
      //   if (comp != null) {
      //     companyData = {'id': comp.id, 'name': comp.name};
      //   }
      // }
      final cat = categoryCtl.list.firstWhereOrNull((e) =>
          e.name.toLowerCase() ==
          itemCtl.selectedItem.value!.category!.toLowerCase());
      if (cat != null) {
        categoryData = {'id': cat.id, 'name': cat.name};
      }
      final un = unitCtl.list.firstWhereOrNull((e) =>
          e.value.toLowerCase() ==
          itemCtl.selectedItem.value!.unit!.toLowerCase());
      if (un != null) {
        unitData = {'id': un.id, 'value': un.value};
      }
    } else {
      nameController = TextEditingController();
      barcodeController = TextEditingController();
      salePriceController = TextEditingController();
      incomePriceController = TextEditingController();
    }
  }

  void _save() {
    if (!formKey.currentState!.validate()) return;

    if (itemCtl.selectedItem.value != null) {
      final updatedItem = itemCtl.selectedItem.value!.copyWith(
        name: nameController.text.trim(),
        barcode: barcodeController.text.trim(),
        salePrice: double.tryParse(salePriceController.text) ?? 0.0,
        incomePrice: double.tryParse(incomePriceController.text) ?? 0.0,
        currencyType: selectedCurrency,
        category: categoryData['name'],
        unit: unitData['value'],
        company: companyData['name'],
        updatedAt: DateTime.now(),
      );
      itemCtl.updateItem(updatedItem);
    } else {
      final Item newItem = Item(
        name: nameController.text.trim(),
        barcode: barcodeController.text.trim(),
        salePrice: double.tryParse(salePriceController.text) ?? 0.0,
        incomePrice: double.tryParse(incomePriceController.text) ?? 0.0,
        currencyType: selectedCurrency,
        category: categoryData['name'],
        unit: unitData['value'],
        company: companyData['name'],
      );
      itemCtl.addItem(newItem.toMapForCreate(
        categoryid: categoryData['id'],
        unitId: unitData['id'],
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
    final double dialogHeight = MediaQuery.of(context).size.height * 0.7;

    return AlertDialog(
      backgroundColor: primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        height: dialogHeight,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Obx(() {
                  return Text(
                    itemCtl.selectedItem.value != null
                        ? "Edit Item"
                        : "Add Item",
                    style: textStyleWhite20,
                  );
                }),
                const Divider(),
                const SizedBox(height: 12),

                // Company & Category
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => MultiSelectDropDown<int>(
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
                            hint: "Company",
                            hintStyle:
                                textStyleBlack18.copyWith(color: Colors.grey),
                          )),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Obx(() => MultiSelectDropDown<int>(
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
                            hint: "Category",
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name",
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
                        controller: salePriceController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter sale price" : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Sale Price",
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextFormField(
                        controller: incomePriceController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Enter income price" : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Income Price",
                        ),
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Currency",
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Unit
                Obx(() {
                  return MultiSelectDropDown<int>(
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
                    hint: "Unit",
                    hintStyle: textStyleBlack18.copyWith(color: Colors.grey),
                  );
                }),

                const SizedBox(height: 20),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: _save,
                      child: Obx(
                        () => Text(
                          itemCtl.selectedItem.value != null ? "Update" : "Add",
                          style: textStyleWhite18,
                        ),
                      ),
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
