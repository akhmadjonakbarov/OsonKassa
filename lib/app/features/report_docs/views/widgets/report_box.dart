import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/utils/formatter_functions/formatter_currency.dart';
import '../../../../translation/translated_texts.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 10,
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
      const DataColumn(
        label: Text(TableTexts.index),
        headingRowAlignment: MainAxisAlignment.center,
      ),
      DataColumn(
        label: Text('product'.tr),
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
              text: "${reportItem.totalQty} ${reportItem.unit}",
            ),
          ),
          DataCell(
            CenterText(
              text: "${PriceFormatter.formatPrice(reportItem.totalSale ?? 0)} ",
            ),
          ),
          DataCell(
            CenterText(
              text:
                  "${PriceFormatter.formatPrice(reportItem.totalIncome ?? 0)} ",
            ),
          ),
          DataCell(
            CenterText(
              text:
                  "${PriceFormatter.formatPrice(reportItem.totalProfit ?? 0)} ",
            ),
          ),
        ],
      );
    }).toList();
  }
}
