import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../styles/text_styles.dart';
import '../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../utils/texts/display_texts.dart';
import '../../../../../utils/texts/table_texts.dart';
import '../../../../shared/export_commons.dart';
import '../../../../shared/widgets/delete_dialog.dart';
import '../../../document/models/doc_item_model.dart';
import '../../logic/store_ctl.dart';

class StoreTable extends StatefulWidget {
  final StoreCtl storeCtl;

  const StoreTable({super.key, required this.storeCtl});

  @override
  State<StoreTable> createState() => _DebtTableState();
}

class _DebtTableState extends State<StoreTable> {
  Color deleteIconColor = Colors.red;
  Color editIconColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      decoration: const BoxDecoration(),
      padding: EdgeInsets.zero,
      child: CustomDataTable(
        columns: const [
          TableTexts.index,
          TableTexts.name,
          TableTexts.category,
          TableTexts.income_price,
          TableTexts.income_price_usd,
          TableTexts.selling_price,
          TableTexts.remainder,
          TableTexts.total_of_product,
          TableTexts.buttons
        ],
        rows: widget.storeCtl.list.asMap().entries.map(
          (entry) {
            int index = entry.key;
            DocItemModel product = entry.value;

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
                    text:
                        "${formatUZSNumber(double.parse((product.qty).toString()))} ",
                    style: textStyleBlack18Bold,
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      EditIconButton(
                        iconColor: Colors.green,
                        onEdit: () =>
                            widget.storeCtl.selectStoreProduct(product),
                      ),
                      DeleteIconButton(
                        iconColor: Colors.red,
                        onDelete: () => Get.dialog(
                          DeleteDialog(
                            title: product.item.name,
                            onConfirmDelete: () =>
                                widget.storeCtl.removeItem(product.id),
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
      ),
    );
  }
}
