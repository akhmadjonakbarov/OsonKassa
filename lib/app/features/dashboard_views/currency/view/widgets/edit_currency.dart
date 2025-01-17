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
import '../../models/models.dart';

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
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrencyCtl>(
      builder: (ctl) {
        final TextEditingController currencyNameController =
            TextEditingController(
          text: ctl.selectedCurrency.value.value != 0
              ? ctl.selectedCurrency.value.value.toString()
              : "",
        );

        void reset() {
          Get.back();
          currencyNameController.clear();
        }

        void submit() {
          final String currencyValue = currencyNameController.text.trim();
          if (currencyValue.isEmpty) {
            UserNotifier.showSnackBar(
              type: TypeOfSnackBar.alert,
              label: "Iltimos kursni kiriting",
            );
            return;
          }

          if (NumberValidator.isNumber(currencyValue)) {
            if (ctl.selectedCurrency.value.id == -1) {
              ctl.addItem(
                {'value': double.parse(currencyValue)},
              );
            } else {
              final CurrencyModel currency = ctl.selectedCurrency.value
                  .copyWith(value: double.parse(currencyValue));

              ctl.updateItem(currency);
            }
            reset();
          } else {
            UserNotifier.showSnackBar(
              type: TypeOfSnackBar.alert,
              label: "Iltimos, raqam kiriting",
            );
            return;
          }
        }

        final String actionText = ctl.selectedCurrency.value.id == -1
            ? ButtonTexts.add
            : ButtonTexts.edit;

        return Container(
          margin: EdgeInsets.symmetric(
              vertical: widget.height, horizontal: widget.width),
          decoration: containerDecoration,
          child: Material(
            borderRadius: BorderRadius.circular(15),
            color: primary,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    actionText,
                    style: textStyleBlack20,
                  ),
                  const Divider(),
                  const SizedBox(height: 15),
                  TextField(
                    controller: currencyNameController,
                    style: textStyleBlack18,
                    decoration: const InputDecoration(
                      labelText: PlaceholderTexts.usd_value,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SmallButtonText(
                        text: actionText,
                        onClick: submit,
                        buttonSize: const Size(125, 45),
                        textStyle: textStyleBlack14,
                      ),
                      SmallButtonText(
                        text: ButtonTexts.cancel,
                        onClick: reset,
                        buttonSize: const Size(125, 45),
                        textStyle: textStyleBlack14,
                        isNegative: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
