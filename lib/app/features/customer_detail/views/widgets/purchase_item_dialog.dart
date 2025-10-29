import 'package:flutter/material.dart';

import '../../../../core/printer/pos_printer_manager.dart';
import '../../../../styles/container_decoration.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../../utils/texts/table_texts.dart';
import '../../../shared/widgets/center_text.dart';
import '../../models/purchase.dart';

class PurchaseItemDialog extends StatelessWidget {
  final Purchase purchase;

  PurchaseItemDialog({super.key, required this.purchase});

  double calculateProfit(
    double sellPrice,
    double incomePrice,
    double qty,
  ) {
    return (qty * (sellPrice - incomePrice));
  }

  double totalQty = 0.0;

  double totalProfit = 0.0;

  double totalSellingPrice = 0.0;

  double totalIncomePrice = 0.0;

  void calculateTotalValues() {
    totalQty = 0.0;
    totalIncomePrice = 0.0;
    totalSellingPrice = 0.0;
    totalProfit = 0.0;
    for (var docItem in purchase.products!) {
      final qty = docItem.qty ?? 0;
      final income = docItem.incomePrice ?? 0;
      final selling = docItem.salePrice ?? 0;

      totalQty += qty;
      totalIncomePrice += income * qty;
      totalSellingPrice += selling * qty;
      totalProfit += (selling - income) * qty;
    }
  }

  PosPrinterManager printer = PosPrinterManager(printerIp: 'printerIp');

  @override
  Widget build(BuildContext context) {
    calculateTotalValues();
    final Size screenSize = getScreenSize(context);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.1,
        vertical: screenSize.height * 0.05,
      ),
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
                    DisplayTexts.full_info_about_products,
                    style: textStyleBlack18.copyWith(
                        fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                      // if (purchase.products!.isNotEmpty)
                      //   Padding(
                      //     padding: const EdgeInsets.only(left: 25),
                      //     child: Material(
                      //       borderRadius: BorderRadius.circular(16),
                      //       color: Colors.blue,
                      //       child: IconButton(
                      //         onPressed: () async {
                      //           await printer!.printProductDoc(products);
                      //                                       },
                      //         icon: const Icon(
                      //           Icons.print,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   )
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
              columnSpacing: screenSize.width * 0.005,
              dividerThickness: 2,
              // dataRowMaxHeight: size.width * 0.028,
              columns: _columns(),
              rows: [
                ...purchase.products!.asMap().entries.map(
                  (e) {
                    int index = e.key;
                    PurchaseItem docItem = e.value;

                    return DataRow(
                      cells: [
                        DataCell(Container(
                          alignment: Alignment.center,
                          child: Text("${index + 1}"),
                        )),
                        DataCell(Container(
                          alignment: Alignment.center,
                          child: Text(
                              "${docItem.name!}${docItem.itemType != null ? ' (${docItem.itemType})' : ''}"),
                        )),
                        DataCell(Container(
                          alignment: Alignment.center,
                          child: Text(
                            PriceFormatter.formatPrice(docItem.incomePrice!),
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.center,
                          child: Text(
                            "${PriceFormatter.formatPrice(docItem.salePrice!)} ",
                          ),
                        )),
                        DataCell(
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${docItem.qty} ${docItem.unit!}",
                              style: screenSize.width <= 1366
                                  ? textStyleBlack15
                                  : textStyleBlack18Bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                DataRow(
                  cells: [
                    const DataCell(CenterText(text: "Jami")),
                    const DataCell(SizedBox.shrink()),
                    DataCell(CenterText(
                      text: PriceFormatter.formatPrice(totalIncomePrice),
                    )),
                    DataCell(CenterText(
                      text: PriceFormatter.formatPrice(totalSellingPrice),
                    )),
                    const DataCell(
                      CenterText(
                        text: '',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
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
          label: Text(TableTexts.selling_price),
          headingRowAlignment: MainAxisAlignment.center),
      const DataColumn(
          label: Text(TableTexts.total_of_product),
          headingRowAlignment: MainAxisAlignment.center),
    ];
  }
}
