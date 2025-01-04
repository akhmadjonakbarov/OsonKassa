import 'package:flutter/material.dart';

import '../../../../../utils/texts/table_texts.dart';
import '../../../../shared/export_commons.dart';
import '../../logic/category_controller.dart';
import '../../models/category_models.dart';

class CategoryTable extends StatefulWidget {
  final CategoryCtl categoryCtl;
  final List<CategoryModel> categories;
  final bool isSeller;

  const CategoryTable({
    super.key,
    required this.categoryCtl,
    required this.categories,
    required this.isSeller,
  });

  @override
  State<CategoryTable> createState() => _CategoryTableState();
}

class _CategoryTableState extends State<CategoryTable> {
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.only(bottom: 10),
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(),
      child: CustomDataTable(
        columns: <DataColumn>[
          const DataColumn(label: Text(TableTexts.index)),
          const DataColumn(label: Text(TableTexts.category)),
          const DataColumn(label: Text(TableTexts.total_of_product)),
          if (!widget.isSeller)
            const DataColumn(label: Text(TableTexts.buttons)),
        ],
        rows: widget.categories.asMap().entries.map(
          (entry) {
            int index = entry.key;
            CategoryModel category = entry.value;
            return DataRow(
              cells: <DataCell>[
                DataCell(Text("${index + 1}")),
                DataCell(CenterText(text: category.name)),
                DataCell(
                    CenterText(text: category.items_type_count.toString())),
                if (!widget.isSeller)
                  DataCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EditIconButton(
                          onEdit: () => widget.categoryCtl
                              .selectCategory(category, context),
                        ),
                        DeleteIconButton(
                          onDelete: () =>
                              widget.categoryCtl.removeItem(category.id),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
