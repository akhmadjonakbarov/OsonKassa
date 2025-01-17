import 'package:flutter/material.dart';

import '../../../styles/text_styles.dart';

class CustomDataTable extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> rows;
  final EdgeInsets? padding;
  const CustomDataTable(
      {super.key, required this.columns, required this.rows, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DataTable(
        border: TableBorder.all(
          borderRadius: BorderRadius.circular(10),
        ),
        showCheckboxColumn: false,
        headingTextStyle: textStyleBlack18Bold,
        dataTextStyle: textStyleBlack14.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        columns: columns
            .map(
              (e) => DataColumn(
                  label: Text(e),
                  headingRowAlignment: MainAxisAlignment.center),
            )
            .toList(),
        rows: rows,
      ),
    );
  }
}
