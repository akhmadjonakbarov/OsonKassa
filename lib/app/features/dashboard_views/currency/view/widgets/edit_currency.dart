import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/display/user_notifier.dart';
import '../../../../../core/enums/type_of_snackbar.dart';
import '../../../../../core/validator/number_validator.dart';
import '../../../../../styles/colors.dart';
import '../../../../../styles/container_decoration.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../utils/texts/button_texts.dart';
import '../../../../../utils/texts/placeholder_texts.dart';
import '../../../../shared/widgets/buttons.dart';
import '../../logic/currency_controller.dart';
import '../../models/currency.dart';

class CurrencyEditDialog extends StatefulWidget {
  final double height;
  final double width;

  const CurrencyEditDialog({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<CurrencyEditDialog> createState() => _CurrencyEditDialogState();
}

class _CurrencyEditDialogState extends State<CurrencyEditDialog> {
  late final TextEditingController currencyController;

  @override
  void initState() {
    super.initState();
    final ctl = Get.find<CurrencyCtl>();
    currencyController = TextEditingController(
      text: ctl.selectedCurrency.value.value != 0
          ? ctl.selectedCurrency.value.value.toString()
          : "",
    );
  }

  @override
  void dispose() {
    currencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrencyCtl>(
      builder: (ctl) {
        final bool isEdit = ctl.selectedCurrency.value.id != -1;
        final String actionText = isEdit ? 'edit'.tr : 'add'.tr;

        void submit() {
          final String input = currencyController.text.trim();
          if (input.isEmpty) {
            UserNotifier.showSnackBar(
              type: TypeOfSnackBar.alert,
              label: "Iltimos, kursni kiriting",
            );
            return;
          }

          if (!NumberValidator.isNumber(input)) {
            UserNotifier.showSnackBar(
              type: TypeOfSnackBar.alert,
              label: "Faqat raqam kiriting",
            );
            return;
          }

          final double value = double.parse(input);
          if (isEdit) {
            final Currency updated =
                ctl.selectedCurrency.value.copyWith(value: value);
            ctl.updateItem(updated);
          } else {
            ctl.addItem({'value': value});
          }

          ctl.fetchItems();
          Get.back();
        }

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          insetPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.35,
            vertical: widget.height * 0.05,
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Header ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEdit
                          ? "Valyutani tahrirlash"
                          : "Yangi valyuta qo‘shish",
                      style: textStyleBlack20.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 20),

                // --- Input field ---
                TextField(
                  controller: currencyController,
                  style: textStyleBlack18,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: PlaceholderTexts.usd_value,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),

                const SizedBox(height: 24),

                // --- Buttons ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        foregroundColor: Colors.black87,
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        'cancel'.tr,
                        style: textStyleBlack18.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: submit,
                      child: Text(
                        actionText,
                        style: textStyleBlack18.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
