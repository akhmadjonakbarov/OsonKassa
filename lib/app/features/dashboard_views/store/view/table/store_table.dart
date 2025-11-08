import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../styles/text_styles.dart';
import '../../../../../translation/translated_texts.dart';
import '../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../utils/texts/display_texts.dart';
import '../../../../shared/export_commons.dart';
import '../../logic/store_ctl.dart';
import '../../models/store_item.dart';

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
    return BasicContainer(
      decoration: const BoxDecoration(),
      padding: EdgeInsets.zero,
      child: CustomDataTable(
        columns: [
          TranslatedTexts.table.index.tr,
          TranslatedTexts.table.name.tr,
          "type".tr,
          TranslatedTexts.table.category.tr,
          TranslatedTexts.table.incomePrice.tr,
          TranslatedTexts.table.salePrice.tr,
          TranslatedTexts.table.qty.tr,
        ],
        rows: widget.storeCtl.list.asMap().entries.map(
          (entry) {
            int index = entry.key;
            StoreItem product = entry.value;

            return DataRow(
              cells: <DataCell>[
                DataCell(CenterText(
                  text: "${index + 1}",
                  style: textStyleBlack18Bold.copyWith(fontSize: 14),
                )),
                DataCell(
                  CenterText(
                    text: "${product.item!.name!}",
                  ),
                ),
                DataCell(CenterText(text: product.itemType ?? "--")),
                DataCell(
                  CenterText(
                    text: product.item!.category!,
                  ),
                ),
                DataCell(CenterText(
                  text: PriceFormatter.formatPrice(
                      product.currencyRateValue != null &&
                              product.currencyRateValue! > 0
                          ? product.incomePrice! * product.currencyRateValue!
                          : product.incomePrice!),
                  style: textStyleBlack18Bold,
                )),
                DataCell(CenterText(
                  text:
                      "${PriceFormatter.formatPrice(product.currencyRateValue != null && product.currencyRateValue! > 0 ? product.salePrice! * product.currencyRateValue! : product.salePrice!)} ",
                  style: textStyleBlack18Bold,
                )),
                DataCell(
                  CenterText(
                    text: "${product.qty.toString()} ${DisplayTexts.stay}",
                    style: textStyleBlack18Bold,
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
