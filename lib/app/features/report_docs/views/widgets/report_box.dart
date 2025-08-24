import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/translation/translated_texts.dart';

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
    return [
      DataColumn(
        label: Text(TableTexts.index),
        headingRowAlignment: MainAxisAlignment.center,
      ),
      DataColumn(
        label: Text(TableTexts.name),
        headingRowAlignment: MainAxisAlignment.center,
      ),
      DataColumn(
        label: Text('total_qty'.tr),
        headingRowAlignment: MainAxisAlignment.center,
      ),
      DataColumn(
        label: Text('total_sale_price'.tr),
        headingRowAlignment: MainAxisAlignment.center,
      ),
      DataColumn(
        label: Text('total_income_price'.tr),
        headingRowAlignment: MainAxisAlignment.center,
      ),
      DataColumn(
        label: Text(TranslatedTexts.table.totalProfit.tr),
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
          DataCell(CenterText(text: reportItem.name!)),
          DataCell(
            CenterText(
              text: reportItem.totalQty.toString(),
            ),
          ),
          DataCell(
            CenterText(
              text: "${reportItem.totalSale} ",
            ),
          ),
          DataCell(
            CenterText(
              text: "${reportItem.totalIncome} ",
            ),
          ),
          DataCell(
            CenterText(
              text: "${reportItem.totalProfit} ",
            ),
          ),
        ],
      );
    }).toList();
  }
}
