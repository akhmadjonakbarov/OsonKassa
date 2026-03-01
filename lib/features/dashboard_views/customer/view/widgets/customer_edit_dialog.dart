import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../../styles/colors.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../translation/translated_texts.dart';
import '../../../../shared/widgets/buttons.dart' show DialogTextButton;

import '../controllers/customer_controller/customer_controller.dart';
import '../../domain/models/customer.dart';

class CustomerEditDialog extends StatefulWidget {
  const CustomerEditDialog({
    super.key,
  });

  @override
  State<CustomerEditDialog> createState() => _CustomerEditDialogState();
}

class _CustomerEditDialogState extends State<CustomerEditDialog> {
  void save() {
    String name = nameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim().replaceAll(' ', '');
    String? phoneNumber2 = phoneNumber2Controller.text.isEmpty
        ? null
        : phoneNumber2Controller.text.trim().replaceAll(' ', '');
    String? address =
        addressController.text.isEmpty ? null : addressController.text.trim();
    Map<String, dynamic> clientData = {
      'full_name': name,
      'phone_number': phoneNumber,
      'phone_number2': phoneNumber2,
      'address': address,
    };

    if (customerCtl.selectedCustomer.value == null) {
      customerCtl.addItem(clientData);
    } else {
      // Update existing provider
      Customer updatedClient = customerCtl.selectedCustomer.value!.copyWith(
        fullName: name,
        phoneNumber: phoneNumber,
        phoneNumber2: phoneNumber2,
        address: address,
      );
      customerCtl.updateItem(updatedClient);
    }
    Navigator.of(context).pop();
  }

  void clearFields() {
    nameController.clear();
    phoneNumberController.clear();
    phoneNumber2Controller.clear();
    addressController.clear();
  }

  final nameController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final phoneNumber2Controller = TextEditingController();

  final addressController = TextEditingController();

  final markPhone = MaskTextInputFormatter(
      mask: '## ### ## ##', filter: {"#": RegExp(r'[0-9]')});

  final customerCtl = Get.find<CustomerCtl>();

  @override
  void initState() {
    super.initState();
    final selected = customerCtl.selectedCustomer.value;
    if (selected != null) {
      nameController.text = selected.fullName ?? '';
      phoneNumberController.text = selected.phoneNumber ?? '';
      phoneNumber2Controller.text = selected.phoneNumber2 ?? '';
      addressController.text = selected.address ?? '';
    } else {
      clearFields();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    phoneNumber2Controller.dispose();
    addressController.dispose();
    customerCtl.selectCustomer(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width *
            0.2, // Set the desired width here
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () {
                return Text(
                  customerCtl.selectedCustomer.value == null
                      ? TranslatedTexts.customer.add.tr
                      : TranslatedTexts.customer.edit.tr,
                  style: textStyleBlack18.copyWith(fontSize: 22),
                );
              },
            ),
            const Divider(),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              style: textStyleBlack18,
              decoration: InputDecoration(
                errorStyle: textStyleBlack18.copyWith(color: Colors.red),
                labelStyle: textStyleBlack18,
                labelText: TranslatedTexts.textFields.name.tr,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              inputFormatters: [markPhone],
              controller: phoneNumberController,
              style: textStyleBlack18,
              decoration: InputDecoration(
                errorStyle: textStyleBlack18.copyWith(color: Colors.red),
                labelStyle: textStyleBlack18,
                labelText: TranslatedTexts.textFields.phoneNumber.tr,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              inputFormatters: [markPhone],
              controller: phoneNumber2Controller,
              style: textStyleBlack18,
              decoration: InputDecoration(
                errorStyle: textStyleBlack18.copyWith(color: Colors.red),
                labelStyle: textStyleBlack18,
                labelText: TranslatedTexts.textFields.phoneNumber2.tr,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: addressController,
              style: textStyleBlack18,
              decoration: InputDecoration(
                errorStyle: textStyleBlack18.copyWith(color: Colors.red),
                labelStyle: textStyleBlack18,
                labelText: TranslatedTexts.textFields.address.tr,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DialogTextButton(
                    text: TranslatedTexts.buttons.cancel.tr,
                    onClick: () {
                      customerCtl.selectCustomer(null);
                      clearFields();
                      Navigator.of(context).pop();
                    },
                    textStyle: textStyleGrey14,
                    isNegative: true,
                  ),
                  const SizedBox(width: 8),
                  DialogTextButton(
                    bgColor: Colors.green,
                    onClick: save,
                    textStyle: textStyleBlack14,
                    text: customerCtl.selectedCustomer.value == null
                        ? TranslatedTexts.customer.add.tr
                        : TranslatedTexts.customer.edit.tr,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
