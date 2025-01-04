import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../styles/text_styles.dart';
import '../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../utils/texts/display_texts.dart';
import '../../../../shared/widgets/buttons.dart';
import '../../../../shared/widgets/center_text.dart';
import '../../../../shared/widgets/delete_dialog.dart';
import '../../../document/models/doc_item_model.dart';
import '../../logic/store_ctl.dart';

class StoreTableDataSource extends DataTableSource {
  final StoreCtl storeCtl;
  StoreTableDataSource(this.storeCtl);

  @override
  DataRow? getRow(int index) {
    final DocItemModel product = storeCtl.list[index];

    return DataRow(
      cells: <DataCell>[
        DataCell(CenterText(
          text: "${index + 1}",
          style: textStyleBlack18Bold.copyWith(fontSize: 14),
        )),
        DataCell(
          CenterText(
            text: product.item.name,
          ),
        ),
        DataCell(
          CenterText(
            text: product.item.category.name,
          ),
        ),
        DataCell(CenterText(
          text: "${product.income_price} ",
          style: textStyleBlack18Bold,
        )),
        DataCell(
          CenterText(
            text: "${product.income_price_usd}",
            style: textStyleBlack18Bold,
          ),
        ),
        DataCell(CenterText(
          text: "${product.selling_price}",
          style: textStyleBlack18Bold,
        )),
        DataCell(
          CenterText(
            text: "${product.qty.toString()} ${DisplayTexts.stay}",
            style: textStyleBlack18Bold,
          ),
        ),
        DataCell(
          CenterText(
            text: "${formatUZSNumber(double.parse((product.qty).toString()))} ",
            style: textStyleBlack18Bold,
          ),
        ),
        DataCell(
          Row(
            children: [
              EditIconButton(
                iconColor: Colors.green,
                onEdit: () => storeCtl.selectStoreProduct(product),
              ),
              DeleteIconButton(
                iconColor: Colors.red,
                onDelete: () => Get.dialog(
                  DeleteDialog(
                    title: product.item.name,
                    onConfirmDelete: () => storeCtl.removeItem(product.id),
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
  int get rowCount => storeCtl.list.length;

  @override
  int get selectedRowCount => 0;
}
