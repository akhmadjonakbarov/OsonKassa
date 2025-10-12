import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../translation/translated_texts.dart';
import '../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../shared/widgets/buttons.dart';
import '../../../../shared/widgets/center_text.dart';
import '../../../../shared/widgets/custom_data_table.dart';
import '../../../../shared/widgets/delete_dialog.dart';
import '../../logic/item_ctl.dart';
import '../../models/item.dart';
import '../widgets/item_edit_dialog.dart';

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
      columns: [
        TranslatedTexts.table.index.tr,
        TranslatedTexts.table.product.tr,
        TranslatedTexts.table.barcode.tr,
        TranslatedTexts.table.salePrice.tr,
        TranslatedTexts.table.incomePrice.tr,
        TranslatedTexts.table.currency.tr,
        TranslatedTexts.table.category.tr,
        TranslatedTexts.table.company.tr,
        TranslatedTexts.table.unit.tr,
        TranslatedTexts.table.buttons.tr
      ],
      rows: widget.itemCtl.list.asMap().entries.map(
        (entry) {
          int index = entry.key;
          final Item item = widget.itemCtl.list[index];

          return DataRow(
            cells: <DataCell>[
              DataCell(Text('${index + 1}')),
              DataCell(CenterText(text: item.name!)),
              DataCell(CenterText(text: item.barcode!)),
              DataCell(
                CenterText(
                  text: PriceFomatter.formatPrice(
                    item.salePrice!,
                  ),
                ),
              ),
              DataCell(
                CenterText(
                  text: PriceFomatter.formatPrice(
                    item.incomePrice!,
                  ),
                ),
              ),
              DataCell(CenterText(text: item.currencyType!)),
              DataCell(CenterText(text: item.category!)),
              DataCell(CenterText(
                  text:
                      item.company != null ? item.company! : "Belgilanmagan")),
              DataCell(CenterText(text: item.unit!)),
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EditIconButton(onEdit: () {
                      widget.itemCtl.selectItem(
                        item,
                      );
                      Get.dialog(const ItemEditDialog()).then(
                        (value) {
                          widget.itemCtl.selectItem(null);
                        },
                      );
                    }),
                    DeleteIconButton(
                      onDelete: () => showDialog(
                        context: context,
                        builder: (context) => DeleteDialog(
                          title: item.name!,
                          onConfirmDelete: () =>
                              widget.itemCtl.removeItem(item.id!),
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
