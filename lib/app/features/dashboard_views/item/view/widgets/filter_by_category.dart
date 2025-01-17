// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:osonkassa/app/utils/texts/button_texts.dart';
import 'package:osonkassa/app/utils/texts/display_texts.dart';

import '../../../../../styles/colors.dart';
import '../../../../../styles/text_styles.dart';
import '../../../category/models/category_models.dart';

class FilterByCategory extends StatelessWidget {
  final MultiSelectController? multiSelectController;
  final Function(int) onSearchByCategory;
  final Function()? onClearSelectedCategory;
  final List<CategoryModel> categories;
  bool isSearchEnabled;
  Icon? isClearIcon;
  String text;

  FilterByCategory({
    super.key,
    this.isClearIcon,
    this.multiSelectController,
    required this.categories,
    required this.onSearchByCategory,
    this.onClearSelectedCategory,
    this.isSearchEnabled = false,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MultiSelectDropDown(
        controller: multiSelectController,
        onOptionSelected: (List<ValueItem> selectedOptions) {
          if (selectedOptions.isNotEmpty) {
            onSearchByCategory(
              selectedOptions.first.value,
            );
          }
        },
        options: categories.asMap().entries.map(
          (e) {
            return ValueItem(
              label: e.value.name,
              value: e.value.id,
            );
          },
        ).toList(),
        selectionType: SelectionType.single,
        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
        searchEnabled: isSearchEnabled,
        clearIcon: isClearIcon,
        searchLabel:
            text.isEmpty ? ButtonTexts.search : "${ButtonTexts.search} | $text",
        hintStyle: textStyleBlack18,
        selectedOptionBackgroundColor: bgButtonColor,
        dropdownBackgroundColor: primary,
        fieldBackgroundColor: primary,
        optionsBackgroundColor: primary,
        singleSelectItemStyle: textStyleBlack18,
        hint: DisplayTexts.categories,
        optionTextStyle: textStyleBlack18.copyWith(fontSize: 17),
      ),
    );
  }
}
