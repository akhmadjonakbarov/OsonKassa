import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../../../utils/texts/display_texts.dart';
import '../../../../item/models/item.dart';
import 'expanded_dop_down.dart';

class ExpandedProducts extends StatelessWidget {
  final List<Item> items;
  final MultiSelectController multiSelectController;
  final Function(Item) getSelectedProduct;

  const ExpandedProducts({
    super.key,
    required this.items,
    required this.getSelectedProduct,
    required this.multiSelectController,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandedDropDown<Item>(
      multiSelectController: multiSelectController,
      items: items,
      getSelectedItem: getSelectedProduct,
      searchLabel: DisplayTexts.name_of_product,
      hint: DisplayTexts.select_product,
      getLabel: (item) => item.name.toString(),
      getValue: (item) => int.parse(item.id.toString()),
    );
  }
}
