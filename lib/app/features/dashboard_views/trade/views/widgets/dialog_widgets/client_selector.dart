import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../../../core/display/user_notifier.dart';
import '../../../../../../core/enums/type_of_snackbar.dart';
import '../../../../../../styles/colors.dart';
import '../../../../../../styles/text_styles.dart';
import '../../../../../../utils/texts/button_texts.dart';
import '../../../../../../utils/texts/display_texts.dart';
import '../../../../../shared/widgets/buttons.dart';
import '../../../../customer/logic/client_ctl.dart';
import '../../../../customer/models/client_model.dart';

class ClientSelector extends StatefulWidget {
  final ClientCtl builderCtl;

  final Function(CustomerModel) selectBuilder;

  const ClientSelector(
      {super.key, required this.builderCtl, required this.selectBuilder});

  @override
  State<ClientSelector> createState() => _ClientSelectorState();
}

class _ClientSelectorState extends State<ClientSelector> {
  CustomerModel? selectedClient;
  String text = "Klientni tanlang";

  @override
  Widget build(BuildContext context) {
    double width = 0;
    double height = 0;
    if (MediaQuery.sizeOf(context).width <= 1370) {
      width = MediaQuery.of(context).size.width * 0.25;
      height = MediaQuery.of(context).size.height * 0.25;
    } else {
      width = MediaQuery.of(context).size.width * 0.2;
      height = MediaQuery.of(context).size.height * 0.2;
    }
    return AlertDialog(
      backgroundColor: primary,
      content: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              DisplayTexts.select_builder,
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            const SizedBox(height: 5),
            Obx(
              () => SizedBox(
                height: 60,
                child: MultiSelectDropDown<int>(
                  onOptionSelected: (List<ValueItem> selectedOptions) {
                    setState(() {
                      selectedClient = widget.builderCtl.list.firstWhere(
                        (e) => e.id == selectedOptions[0].value,
                      );
                      text = selectedClient!.full_name;

                      widget.selectBuilder(selectedClient!);
                    });
                  },
                  options: widget.builderCtl.list.asMap().entries.map(
                    (e) {
                      return ValueItem(
                        label: e.value.full_name,
                        value: e.value.id,
                      );
                    },
                  ).toList(),
                  selectionType: SelectionType.single,
                  hintStyle: textStyleBlack18,
                  selectedOptionBackgroundColor: bgButtonColor,
                  dropdownBackgroundColor: primary,
                  fieldBackgroundColor: primary,
                  optionsBackgroundColor: primary,
                  singleSelectItemStyle: textStyleBlack18,
                  hint: text,
                  optionTextStyle: textStyleBlack14,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DialogTextButton(
                  onClick: () {
                    setState(() {
                      selectedClient = null;
                    });
                    Navigator.of(context).pop();
                  },
                  isNegative: true,
                  text: ButtonTexts.cancel,
                  textStyle: textStyleBlack18,
                ),
                DialogTextButton(
                  onClick: () {
                    if (selectedClient != null) {
                      Navigator.of(context).pop();
                      UserNotifier.showSnackBar(
                        label: "Klient belgilandi",
                        type: TypeOfSnackBar.success,
                      );
                    } else {
                      UserNotifier.showSnackBar(
                        label: "Klientni tanlang yoki bekor qiling!",
                        type: TypeOfSnackBar.alert,
                      );
                    }
                  },
                  text: "Belgilash",
                  textStyle: textStyleBlack18,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
