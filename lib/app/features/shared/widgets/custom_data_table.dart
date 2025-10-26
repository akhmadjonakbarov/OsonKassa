import 'package:flutter/material.dart';

import '../../../styles/text_styles.dart';
import '../../../utils/media/get_screen_size.dart';

class CustomDataTable extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> rows;
  final EdgeInsets? padding;

  const CustomDataTable(
      {super.key, required this.columns, required this.rows, this.padding});

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DataTable(
        border: TableBorder.all(
          borderRadius: BorderRadius.circular(10),
        ),
        showCheckboxColumn: false,
        headingTextStyle:
            screenSize.width <= 1370 ? null : textStyleBlack18Bold,
        dataTextStyle: textStyleBlack14.copyWith(
          fontWeight: FontWeight.w600,
        ),
        columnSpacing: 20,
        columns: columns
            .map(
              (e) => DataColumn(
                  label: Expanded(
                      child: Text(
                    e,
                    textAlign: TextAlign.center,
                  )),
                  headingRowAlignment: MainAxisAlignment.center),
            )
            .toList(),
        rows: rows,
      ),
    );
  }
}
