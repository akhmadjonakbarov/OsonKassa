import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../export_commons.dart';
import '../../../utils/helper/button_size_manager.dart';

import '../../../core/printer/pos_printer_manager.dart';
import '../../../styles/container_decoration.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/media/get_screen_size.dart';
import '../../../utils/texts/table_texts.dart';
import '../../dashboard_views/document/models/doc_item_model.dart';
import 'custom_data_table.dart';
import 'custom_textfields.dart';

class DialogTable extends StatelessWidget {
  final String title;
  final EdgeInsets margin;
  final List<DataRow> rows;
  final Function() onClick;
  final List<DataColumn> columns;
  final List<DocItemModel> products;
  final PosPrinterManager? printer;

  const DialogTable({
    super.key,
    required this.onClick,
    required this.title,
    required this.columns,
    required this.rows,
    required this.margin,
    this.products = const [],
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
                      if (products.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blue,
                            child: IconButton(
                              onPressed: () async {
                                if (printer != null) {
                                  await printer!.printProductDoc(products);
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



class BasicDialog extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;

  const BasicDialog({super.key, this.height, this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}

class ManageDetailDialogView extends StatelessWidget {
  final String title;
  final Function(String value) onSearch;
  final String searchHintText;
  final List<Widget> children;
  Function()? onAdd;

  ManageDetailDialogView(
      {super.key,
      required this.title,
      required this.onSearch,
      required this.searchHintText,
      required this.children,
      this.onAdd});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    return AlertDialog(
      content: SizedBox(
        width: screenSize.width * 0.6,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenSize.width * 0.15,
                  child: SearchTextField(
                    hintText: searchHintText,
                    onChanged: (value) => onSearch(value),
                  ),
                ),
                Row(
                  children: [
                    if (onAdd != null)
                      BasicButton(
                        onClick: onAdd,
                        text: "Qo'shish",
                        textStyle: TextStyles.white(
                          screenSize.height / 55,
                        ),
                        height:
                            ButtonSizeManager.height(context, height: 0.1 / 3),
                        width: ButtonSizeManager.width(context),
                      ),
                    SizedBox(
                      width: screenSize.width * 0.1 / 9,
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      hoverColor: Colors.red,
                    )
                  ],
                )
              ],
            ),
            ...children
          ],
        ),
      ),
    );
  }
}
