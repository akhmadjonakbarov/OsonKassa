import 'package:osonkassa/app/features/dashboard_views/item/models/item_model.dart';
import 'package:flutter/material.dart';

import '../../../../shared/export_commons.dart';
import '../../../../shared/widgets/delete_dialog.dart';
import '../../logic/item_ctl.dart';

class ItemDataSource extends DataTableSource {
  final ItemCtl itemCtl;
  final bool isSeller;
  final BuildContext context;
  ItemDataSource(this.itemCtl, this.isSeller, this.context);

  @override
  DataRow? getRow(int index) {
    final ItemModel item = itemCtl.list[index];

    return DataRow(
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(CenterText(text: item.name)),
        DataCell(CenterText(text: item.barcode)),
        DataCell(CenterText(text: item.category.name)),
        DataCell(CenterText(
            text: item.company != null ? item.company!.name : "Belgilanmagan")),
        if (isSeller != true)
          DataCell(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EditIconButton(
                  onEdit: () => itemCtl.selectItem(item, context: context),
                ),
                DeleteIconButton(
                  onDelete: () => showDialog(
                    context: context,
                    builder: (context) => DeleteDialog(
                      title: item.name,
                      onConfirmDelete: () => itemCtl.removeItem(item.id),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => itemCtl.list.length;

  @override
  int get selectedRowCount => 0;
}
