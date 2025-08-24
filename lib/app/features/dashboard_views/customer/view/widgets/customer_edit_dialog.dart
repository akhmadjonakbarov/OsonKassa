import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../styles/colors.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../translation/translated_texts.dart';
import '../../../../shared/widgets/buttons.dart' show DialogTextButton;
import '../../../../shared/widgets/custom_textfields.dart';
import '../../logic/customer_ctl.dart';
import '../../models/customer.dart';

class CustomerEditDialog extends StatelessWidget {
  CustomerEditDialog({super.key, required this.customerCtl});
  final CustomerCtl customerCtl;
  String buttonText = '';

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
        child: Form(
          key: customerCtl.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () {
                  buttonText = customerCtl.selectedCustomer.value == null
                      ? TranslatedTexts.buttons.save
                      : TranslatedTexts.buttons.edit;
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
              CustomDialogTextField(
                controller: customerCtl.nameController,
                label: TranslatedTexts.textFields.fullName.tr,
              ),
              CustomDialogTextField(
                controller: customerCtl.phoneNumberController,
                label: TranslatedTexts.textFields.phoneNumber.tr,
              ),
              CustomDialogTextField(
                canBeNull: true,
                controller: customerCtl.phoneNumber2Controller,
                label: TranslatedTexts.textFields.phoneNumber2.tr,
              ),
              CustomDialogTextField(
                controller: customerCtl.addressController,
                label: TranslatedTexts.textFields.address.tr,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DialogTextButton(
                    text: TranslatedTexts.buttons.cancel.tr,
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    textStyle: textStyleGrey14,
                    isNegative: true,
                  ),
                  const SizedBox(width: 8),
                  DialogTextButton(
                    bgColor: isNull ? null : Colors.green,
                    onClick: () {
                      bool isValid =
                          customerCtl.formKey.currentState!.validate();
                      if (isValid) {
                        // Handle save action
                        String name = customerCtl.nameController.text.trim();
                        String phoneNumber =
                            customerCtl.phoneNumberController.text.trim();
                        String phoneNumber2 =
                            customerCtl.phoneNumber2Controller.text.trim();
                        String address =
                            customerCtl.addressController.text.trim();
                        Map<String, dynamic> clientData = {
                          'full_name': name,
                          'phoneNumber': phoneNumber,
                          'phoneNumber2': phoneNumber2,
                          'address': address,
                        };

                        if (customerCtl.selectedCustomer.value == null) {
                          customerCtl.addItem(clientData);
                        } else {
                          // Update existing provider
                          Customer updatedClient =
                              customerCtl.selectedCustomer.value!.copyWith(
                            fullName: name,
                            phoneNumber: phoneNumber,
                            phoneNumber2: phoneNumber2,
                            address: address,
                          );
                          customerCtl.updateItem(updatedClient);
                        }
                      }
                    },
                    textStyle: textStyleBlack14,
                    text: buttonText.tr,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
