import 'package:flutter/material.dart';

import '../../../styles/text_styles.dart';

class CustomDataTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;

  const CustomDataTable({super.key, required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DataTable(
        border: TableBorder.all(
          color: Colors.grey,
        ),
        showCheckboxColumn: false,
        sortColumnIndex: 0,
        columnSpacing: 9,
        headingTextStyle: textStyleBlack18Bold,
        dataTextStyle: textStyleBlack14.copyWith(
            fontSize: 16, fontWeight: FontWeight.w600),
        columns: columns,
        rows: rows,
      ),
    );
  }
}
