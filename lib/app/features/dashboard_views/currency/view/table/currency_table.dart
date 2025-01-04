import 'package:flutter/material.dart';

import '../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../utils/formatter_functions/formatter_date.dart';
import '../../../../../utils/texts/table_texts.dart';
import '../../../../shared/export_commons.dart';
import '../../../../shared/widgets/delete_dialog.dart';
import '../../logic/currency_controller.dart';
import '../../models/models.dart';

class CurrencyTable extends StatefulWidget {
  final CurrencyCtl currencyCtl;
  final Function() onSelect;

  const CurrencyTable(
      {super.key, required this.currencyCtl, required this.onSelect});

  @override
  State<CurrencyTable> createState() => _CurrencyTableState();
}

class _CurrencyTableState extends State<CurrencyTable> {
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      decoration: const BoxDecoration(),
      padding: EdgeInsets.zero,
      child: CustomDataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text(TableTexts.index)),
          DataColumn(label: Text(TableTexts.currency)),
          DataColumn(label: Text(TableTexts.addingTime)),
          DataColumn(label: Text(TableTexts.buttons)),
        ],
        rows: widget.currencyCtl.list.asMap().entries.map(
          (entry) {
            int index = entry.key;
            CurrencyModel currency = entry.value;

            return DataRow(
              cells: <DataCell>[
                DataCell(Text("${index + 1}")),
                DataCell(Text(formatUZSNumber(currency.value))),
                DataCell(Text(formatDateToUzbek(currency.created_at))),
                DataCell(
                  Row(
                    children: [
                      EditIconButton(
                        onEdit: () {
                          widget.onSelect();
                          widget.currencyCtl.selectCurrency(currency);
                        },
                      ),
                      DeleteIconButton(
                        onDelete: () {
                          return showDialog(
                            builder: (context) => DeleteDialog(
                              title: formatUZSNumber(currency.value),
                              onConfirmDelete: () =>
                                  widget.currencyCtl.removeItem(currency.id),
                            ),
                            context: context,
                          );
                        },
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
