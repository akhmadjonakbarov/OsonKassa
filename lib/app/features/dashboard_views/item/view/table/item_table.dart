import 'package:osonkassa/app/utils/media/get_screen_size.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/texts/table_texts.dart';

import '../../../../shared/widgets/app_container.dart';
import '../../../../shared/widgets/buttons.dart';
import '../../../../shared/widgets/center_text.dart';
import '../../../../shared/widgets/custom_data_table.dart';
import '../../../../shared/widgets/delete_dialog.dart';
import '../../logic/item_ctl.dart';
import '../../models/item_model.dart';

class ItemTable extends StatefulWidget {
  final ItemCtl itemCtl;

  const ItemTable({
    super.key,
    required this.itemCtl,
  });

  @override
  State<ItemTable> createState() => _ItemTableState();
}

class _ItemTableState extends State<ItemTable> {
  @override
  Widget build(BuildContext context) {
    return CustomDataTable(
      columns: const [
        TableTexts.index,
        TableTexts.name,
        TableTexts.barcode,
        TableTexts.category,
        TableTexts.company,
        TableTexts.buttons
      ],
      rows: widget.itemCtl.list.asMap().entries.map(
        (entry) {
          int index = entry.key;
          final ItemModel item = widget.itemCtl.list[index];

          return DataRow(
            cells: <DataCell>[
              DataCell(Text('${index + 1}')),
              DataCell(CenterText(text: item.name)),
              DataCell(CenterText(text: item.barcode)),
              DataCell(CenterText(text: item.category.name)),
              DataCell(CenterText(
                  text: item.company != null
                      ? item.company!.name
                      : "Belgilanmagan")),
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EditIconButton(
                      onEdit: () =>
                          widget.itemCtl.selectItem(item, context: context),
                    ),
                    DeleteIconButton(
                      onDelete: () => showDialog(
                        context: context,
                        builder: (context) => DeleteDialog(
                          title: item.name,
                          onConfirmDelete: () =>
                              widget.itemCtl.removeItem(item.id),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
