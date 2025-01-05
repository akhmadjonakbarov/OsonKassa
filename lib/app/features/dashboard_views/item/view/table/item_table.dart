import 'package:osonkassa/app/features/dashboard_views/item/view/table/item_data_source.dart';
import 'package:osonkassa/app/utils/media/get_screen_size.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/texts/table_texts.dart';

import '../../logic/item_ctl.dart';

class ItemTable extends StatefulWidget {
  final ItemCtl itemCtl;

  const ItemTable({
    super.key,
    required this.itemCtl,
  });

  @override
  State<ItemTable> createState() => _ItemTableState();
}

class _ItemTableState extends State<ItemTable> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        switch (screenSize.width) {
          1366 => PaginatedDataTable(
              columns: _columns(),
              dataRowMaxHeight: screenSize.height * 0.07,
              source: ItemDataSource(
                widget.itemCtl,
                true,
                context,
              ),
            ),
          1920 => PaginatedDataTable(
              columns: _columns(),
              dataRowMaxHeight: screenSize.height * 0.06,
              source: ItemDataSource(
                widget.itemCtl,
                true,
                context,
              ),
            ),

          // TODO: Handle this case.
          double() => throw UnimplementedError(),
        }
      ],
    );
  }

  List<DataColumn> _columns() {
    return <DataColumn>[
      const DataColumn(label: Text(TableTexts.index)),
      const DataColumn(label: Text(TableTexts.name)),
      const DataColumn(label: Text(TableTexts.barcode)),
      const DataColumn(label: Text(TableTexts.category)),
      const DataColumn(label: Text(TableTexts.company)),
      const DataColumn(
        label: Text(
          TableTexts.buttons,
        ),
      ),
    ];
  }
}
