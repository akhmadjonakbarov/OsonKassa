import 'package:flutter/material.dart';

import '../../../core/printer/pos_printer_manager.dart';
import '../../../styles/container_decoration.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/media/get_screen_size.dart';
import '../../dashboard_views/document/models/doc_item_model.dart';

class DialogTable extends StatelessWidget {
  final String title;
  final EdgeInsets margin;
  final List<DataRow> rows;
  final Function() onClick;
  final List<DataColumn> columns;
  final List<DocItemModel> products_list;
  final PosPrinterManager? printer;

  const DialogTable({
    super.key,
    required this.onClick,
    required this.title,
    required this.columns,
    required this.rows,
    required this.margin,
    this.products_list = const [],
    this.printer,
  });

  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);
    return Container(
      width: double.infinity,
      margin: margin,
      padding: EdgeInsets.zero,
      decoration: containerDecoration,
      child: Material(
        borderRadius: BorderRadius.circular(16),
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: textStyleBlack18.copyWith(
                        fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onClick,
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                      if (products_list.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blue,
                            child: IconButton(
                              onPressed: () async {
                                if (printer != null) {
                                  await printer!.printProductDoc(products_list);
                                }
                              },
                              icon: const Icon(
                                Icons.print,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
            DataTable(
              border: TableBorder.all(color: Colors.grey),
              headingTextStyle: textStyleBlack18Bold.copyWith(fontSize: 14),
              dataTextStyle: textStyleBlack18.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              columnSpacing: size.width * 0.005,
              dividerThickness: 2,
              // dataRowMaxHeight: size.width * 0.028,
              columns: columns,
              rows: rows,
            ),
          ],
        ),
      ),
    );
  }
}
