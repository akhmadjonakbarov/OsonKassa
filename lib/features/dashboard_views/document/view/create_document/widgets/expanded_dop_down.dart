import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../../../styles/colors.dart';
import '../../../../../../styles/text_styles.dart';

class ExpandedDropDown<T> extends StatelessWidget {
  final List<T> items;
  final Function(T) getSelectedItem;
  final String searchLabel;
  final String hint;
  final String Function(T) getLabel;
  final dynamic Function(T) getValue;
  final MultiSelectController multiSelectController;

  const ExpandedDropDown({
    super.key,
    required this.items,
    required this.getSelectedItem,
    required this.searchLabel,
    required this.hint,
    required this.getLabel,
    required this.getValue,
    required this.multiSelectController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MultiSelectDropDown(
        controller: multiSelectController,
        onOptionSelected: (List<ValueItem> selectedOptions) {
          T selectedItem = items.firstWhere(
            (item) => getValue(item) == selectedOptions.first.value,
          );
          getSelectedItem(selectedItem);
        },
        options: items
            .map((item) => ValueItem(
                  label: getLabel(item),
                  value: getValue(item),
                ))
            .toList(),
        borderRadius: 5,
        searchEnabled: true,
        searchLabel: searchLabel,
        searchBackgroundColor: Colors.white70,
        selectionType: SelectionType.single,
        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
        selectedOptionTextColor: Colors.white,
        hintStyle:
            textStyleBlack18.copyWith(color: Colors.black.withOpacity(0.7)),
        selectedOptionBackgroundColor: bgButtonColor,
        dropdownBackgroundColor: primary,
        fieldBackgroundColor: primary,
        optionsBackgroundColor: primary,
        singleSelectItemStyle: textStyleBlack18,
        hint: hint,
        animateSuffixIcon: true,
        optionTextStyle: textStyleBlack14,
      ),
    );
  }
}
