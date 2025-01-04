import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../../../utils/texts/display_texts.dart';
import '../../../../category/models/category_models.dart';
import 'expanded_dop_down.dart';

class ExpandedCategories extends StatelessWidget {
  final List<CategoryModel> categories;
  final MultiSelectController multiSelectController;
  final Function(CategoryModel) getCategoryProduct;

  const ExpandedCategories({
    super.key,
    required this.categories,
    required this.getCategoryProduct,
    required this.multiSelectController,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandedDropDown<CategoryModel>(
      multiSelectController: multiSelectController,
      items: categories,
      getSelectedItem: getCategoryProduct,
      searchLabel: DisplayTexts.name_of_category,
      hint: DisplayTexts.select_category,
      getLabel: (item) => item.name.toString(),
      getValue: (item) => int.parse(item.id.toString()),
    );
  }
}
