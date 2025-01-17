import 'package:flutter/material.dart';

import '../../../../utils/texts/table_texts.dart';
import '../../../shared/widgets/center_text.dart';
import '../../../shared/widgets/grid_box.dart';
import '../../models/report_model.dart';

class ReportBox extends StatelessWidget {
  const ReportBox({
    super.key,
    required this.report,
  });

  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    return GridBox(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(report.name),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columns: columns(),
                rows: rows(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> columns() {
    return const [
      DataColumn(
        label: Text(TableTexts.index),
        headingRowAlignment: MainAxisAlignment.center,
      ),
      DataColumn(
        label: Text(TableTexts.name),
        headingRowAlignment: MainAxisAlignment.center,
      ),
      DataColumn(
        label: Text("Sotilgan soni"),
        headingRowAlignment: MainAxisAlignment.center,
      ),
      DataColumn(
        label: Text(TableTexts.selling_price),
        headingRowAlignment: MainAxisAlignment.center,
      ),
      DataColumn(
        label: Text(TableTexts.total_profit),
        headingRowAlignment: MainAxisAlignment.center,
      ),
    ];
  }

  List<DataRow> rows() {
    return report.value.asMap().entries.map((entry) {
      int index = entry.key;
      ReportItemModel reportItem = entry.value;
      return DataRow(
        cells: [
          DataCell(Text("${index + 1}")),
          DataCell(CenterText(text: reportItem.item_name)),
          DataCell(
            CenterText(
              text: reportItem.total_qty.toString(),
            ),
          ),
          DataCell(
            CenterText(
              text: "${reportItem.selling_price} ${reportItem.currency_type}",
            ),
          ),
          DataCell(
            CenterText(
              text: "${reportItem.total_profit} ${reportItem.currency_type}",
            ),
          ),
        ],
      );
    }).toList();
  }
}
