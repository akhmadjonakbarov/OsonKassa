import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/customer_detail/models/purchase.dart';

import '../../../../styles/text_styles.dart';
import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../../utils/texts/table_texts.dart';
import '../../../dashboard_views/document/models/document_item.dart';
import '../../../shared/widgets/center_text.dart';
import '../../../shared/widgets/delete_dialog.dart';
import '../../../shared/widgets/dialogs.dart';

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
      final selling = docItem.sellingPrice ?? 0;

      totalQty += qty;
      totalIncomePrice += income * qty;
      totalSellingPrice += selling * qty;
      totalProfit += (selling - income) * qty;
    }
  }

  @override
  Widget build(BuildContext context) {
    calculateTotalValues();
    final Size screenSize = getScreenSize(context);
    return DialogTable(
      products: purchase.products!,
      onClick: () => Navigator.of(context).pop(),
      margin: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.1,
        vertical: screenSize.height * 0.05,
      ),
      title: DisplayTexts.full_info_about_products,
      columns: _columns(),
      rows: [
        ...purchase.products!.asMap().entries.map(
          (docItemData) {
            int index = docItemData.key;
            DocumentItem docItem = docItemData.value;

            return DataRow(
              cells: [
                DataCell(Container(
                  alignment: Alignment.center,
                  child: Text("${index + 1}"),
                )),
                DataCell(Container(
                  alignment: Alignment.center,
                  child: Text(docItem.item!.name.toString()),
                )),
                DataCell(Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${PriceFomatter.formatPrice(docItem.incomePrice!)} ${docItem.incomeCurrency}",
                  ),
                )),
                DataCell(Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${PriceFomatter.formatPrice(docItem.sellingPrice!)} ${docItem.sellingCurrency}",
                  ),
                )),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      docItem.qty.toString(),
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
              text: "${PriceFomatter.formatPrice(totalIncomePrice)} usd",
            )),
            DataCell(CenterText(
              text: "${PriceFomatter.formatPrice(totalSellingPrice)} uzs",
            )),
            DataCell(CenterText(
              text: totalQty.toStringAsFixed(2),
            )),
          ],
        ),
      ],
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
