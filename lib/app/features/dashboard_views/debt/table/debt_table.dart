import 'package:flutter/material.dart';

import '../../../../styles/container_decoration.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/table_texts.dart';
import '../../../shared/export_commons.dart';
import '../logic/debt_ctl.dart';
import '../models/debt_model.dart';

class DebtTable extends StatefulWidget {
  final DebtCtl debtCtl;
  const DebtTable({super.key, required this.debtCtl});

  @override
  State<DebtTable> createState() => _DebtTableState();
}

class _DebtTableState extends State<DebtTable> {
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.zero,
      decoration: containerDecoration,
      child: CustomDataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text("№")),
          DataColumn(label: Text(TableTexts.fish)),
          DataColumn(label: Text(TableTexts.phone_number)),
          DataColumn(label: Text(TableTexts.phone_number2)),
          DataColumn(label: Text(TableTexts.address)),
          DataColumn(label: Text(TableTexts.total)),
          DataColumn(label: Text(TableTexts.buttons)),
        ],
        rows: widget.debtCtl.list.asMap().entries.map((entry) {
          int index = entry.key;
          DebtModel debt = entry.value;
          return DataRow(
            cells: <DataCell>[
              DataCell(Text("${index + 1}")),
              DataCell(Text(debt.name)),
              DataCell(Text(debt.phone_number)),
              DataCell(Text(debt.phone_number2 ?? "")),
              DataCell(Text(debt.address)),
              DataCell(Text(formatUZSCurrency(debt.amount))),
              DataCell(
                DialogTextButton(
                  onClick: () => widget.debtCtl.pay(debt.id),
                  text: ButtonTexts.pay,
                  textStyle: textStyleBlack18,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
