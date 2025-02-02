import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/printer/pos_printer_manager.dart';
import '../../../../../../styles/text_styles.dart';
import '../../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../../utils/media/get_screen_size.dart';
import '../../../../../../utils/texts/display_texts.dart';
import '../../../../../../utils/texts/table_texts.dart';
import '../../../../../shared/export_commons.dart';
import '../../../../../shared/widgets/delete_dialog.dart';
import '../../../../note/logic/note_controller.dart';
import '../../../logic/doc_item/doc_item_ctl.dart';
import '../../../models/doc_item_model.dart';

class DocItemTableDialog extends StatefulWidget {
  final PosPrinterManager printerManager;
  final NoteCtl spiskaCtl;
  final DocItemCtl docItemCtl;
  final Size size;
  const DocItemTableDialog({
    super.key,
    required this.printerManager,
    required this.size,
    required this.spiskaCtl,
    required this.docItemCtl,
  });

  @override
  State<DocItemTableDialog> createState() => _DocItemTableDialogState();
}

class _DocItemTableDialogState extends State<DocItemTableDialog> {
  double calculateProfit(
    double selling_price,
    double income_price,
    double qty,
  ) {
    return (qty * (selling_price - income_price));
  }

  // Calculate the totals for Qty, QtyKg, and Profit
  double totalQty = 0.0;

  double totalQtyKg = 0.0;

  double totalProfit = 0.0;

  double totalSellingPrice = 0.0;

  double totalIncomePrice = 0.0;

  void calculateTotalValues() {
    for (var docItem in widget.docItemCtl.docItemsByDoc) {
      totalQty += docItem.qty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    return Obx(
      () {
        if (widget.docItemCtl.isLoading.value) {
          return AlertDialog(
            content: SizedBox(
              height: screenSize.height * 0.3,
              width: screenSize.width * 0.2,
              child: const Loading(
                hasPadding: false,
              ),
            ),
          );
        } else {
          calculateTotalValues();

          return DialogTable(
            printer: widget.printerManager,
            products: widget.docItemCtl.docItemsByDoc,
            onClick: () => Navigator.of(context).pop(),
            margin: EdgeInsets.symmetric(
              horizontal: widget.size.width * 0.1,
              vertical: widget.size.height * 0.05,
            ),
            title: DisplayTexts.full_info_about_products,
            columns: _columns(),
            rows: [
              ...widget.docItemCtl.docItemsByDoc.asMap().entries.map(
                (doc_item_data) {
                  int index = doc_item_data.key;
                  DocItemModel doc_item = doc_item_data.value;
                  double totalPrice = 0;
                  double profit = 0;
                  double totalIncomePriceForItem = 0;

                  profit = calculateProfit(doc_item.selling_price,
                      doc_item.income_price, doc_item.qty);

                  return DataRow(
                    cells: [
                      DataCell(Container(
                        alignment: Alignment.center,
                        child: Text("${index + 1}"),
                      )),
                      DataCell(Container(
                        alignment: Alignment.center,
                        child: Text(doc_item.item.name.toString()),
                      )),
                      DataCell(Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${doc_item.income_price} ${doc_item.currency_type.name}",
                        ),
                      )),
                      if (doc_item.income_price_usd > 0)
                        DataCell(Container(
                          alignment: Alignment.center,
                          child: Text(
                            "${doc_item.income_price_usd.toString()} \$",
                            style: screenSize.width <= 1366
                                ? textStyleBlack15
                                : textStyleBlack18Bold,
                          ),
                        ))
                      else
                        DataCell(Container(
                          alignment: Alignment.center,
                          child: Text(
                            "${formatUZSNumber(totalIncomePriceForItem)} ${doc_item.currency_type.name}",
                            style: screenSize.width <= 1366
                                ? textStyleBlack15
                                : textStyleBlack18Bold,
                          ),
                        )),
                      DataCell(Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${doc_item.selling_price} ${doc_item.currency_type.name}",
                        ),
                      )),
                      DataCell(CenterText(
                        text:
                            "${formatUZSNumber(totalPrice)} ${doc_item.currency_type.name}",
                      )),
                      DataCell(Container(
                        alignment: Alignment.center,
                        child: Text(
                            "${formatUZSNumber(profit)} ${doc_item.currency_type}"),
                      )),
                      DataCell(
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "${doc_item.qty.toString()}",
                            style: screenSize.width <= 1366
                                ? textStyleBlack15
                                : textStyleBlack18Bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "${formatUZSNumber(double.parse((doc_item.qty).toString()))} ",
                            style: screenSize.width <= 1366
                                ? textStyleBlack15
                                : textStyleBlack18Bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  Get.dialog(
                                    DeleteDialog(
                                      title: doc_item.item.name,
                                      onConfirmDelete: () {
                                        widget.docItemCtl
                                            .removeItem(doc_item.id);
                                        widget.spiskaCtl.fetchItems();

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              DataRow(
                cells: [
                  DataCell(Container()), // Empty cell for index
                  DataCell(Container(
                      alignment: Alignment.center,
                      child: Text(DisplayTexts.total_value,
                          style: screenSize.width <= 1366
                              ? textStyleBlack15
                              : textStyleBlack18Bold))),
                  // Empty cell for income price
                  DataCell(Container()), // Empty cell for income price USD

                  DataCell(CenterText(
                    text:
                        "${formatUZSNumber(totalIncomePrice, isAddWord: false)} USD",
                    style: screenSize.width <= 1366
                        ? textStyleBlack15
                        : textStyleBlack18Bold,
                  )),
                  // Empty cell for selling price
                  DataCell(Container()), // Empty cell for total value
                  DataCell(CenterText(
                    text:
                        "${formatUZSNumber(totalSellingPrice, isAddWord: false)} USD",
                    style: screenSize.width <= 1366
                        ? textStyleBlack15
                        : textStyleBlack18Bold,
                  )),
                  DataCell(CenterText(
                    text: "${formatUZSNumber(totalProfit)} USD",
                    style: screenSize.width <= 1366
                        ? textStyleBlack15
                        : textStyleBlack18Bold,
                  )),
                  DataCell(CenterText(
                    text: "$totalQty QOP",
                    style: screenSize.width <= 1366
                        ? textStyleBlack15
                        : textStyleBlack18Bold,
                  )),
                  DataCell(CenterText(
                    text: "${formatUZSNumber(totalQtyKg)} KG",
                    style: screenSize.width <= 1366
                        ? textStyleBlack15
                        : textStyleBlack18Bold,
                  )),
                  DataCell(SizedBox.shrink()), // Empty cell for buttons
                ],
              ),
            ],
          );
        }
      },
    );
  }

  List<DataColumn> _columns() {
    return <DataColumn>[
      const DataColumn(
          label: Text(TableTexts.index),
          headingRowAlignment: MainAxisAlignment.center),
      const DataColumn(
          label: Text(TableTexts.name),
          headingRowAlignment: MainAxisAlignment.center),
      const DataColumn(
          label: Text(TableTexts.income_price),
          headingRowAlignment: MainAxisAlignment.center),
      const DataColumn(
          label: Text(TableTexts.income_price_usd),
          headingRowAlignment: MainAxisAlignment.center),
      const DataColumn(
          label: Text(TableTexts.selling_price),
          headingRowAlignment: MainAxisAlignment.center),
      const DataColumn(
          label: Text(TableTexts.total_value),
          headingRowAlignment: MainAxisAlignment.center),
      const DataColumn(
          label: Text(TableTexts.total_profit),
          headingRowAlignment: MainAxisAlignment.center),
      const DataColumn(
          label: Text(TableTexts.total_of_product),
          headingRowAlignment: MainAxisAlignment.center),
      const DataColumn(
          label: Text(TableTexts.total_kg),
          headingRowAlignment: MainAxisAlignment.center),
      const DataColumn(
          label: Text(TableTexts.buttons),
          headingRowAlignment: MainAxisAlignment.center),
    ];
  }
}
