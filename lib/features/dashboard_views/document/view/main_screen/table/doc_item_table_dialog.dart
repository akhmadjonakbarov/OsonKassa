import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/printer/pos_printer_manager.dart';
import '../../../../../../styles/text_styles.dart';
import '../../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../../../utils/media/get_screen_size.dart';
import '../../../../../../utils/texts/table_texts.dart';
import '../../../../../shared/export_commons.dart';
import '../../../../../shared/widgets/delete_dialog.dart';
import '../../../../note/logic/note_controller.dart';
import '../../../logic/doc_item/doc_item_ctl.dart';
import '../../../models/document_item.dart';

//
// class DocItemTableDialog extends StatefulWidget {
//   final PosPrinterManager printerManager;
//   final NoteCtl spiskaCtl;
//   final DocItemCtl docItemCtl;
//   final Size size;
//
//   const DocItemTableDialog({
//     super.key,
//     required this.printerManager,
//     required this.size,
//     required this.spiskaCtl,
//     required this.docItemCtl,
//   });
//
//   @override
//   State<DocItemTableDialog> createState() => _DocItemTableDialogState();
// }
//
// class _DocItemTableDialogState extends State<DocItemTableDialog> {
//   double totalQty = 0.0;
//
//   double totalProfit = 0.0;
//
//   double totalSalePrice = 0.0;
//
//   double totalIncomePrice = 0.0;
//
//   void calculateTotalValues() {
//     totalQty = 0.0;
//     totalIncomePrice = 0.0;
//     totalSalePrice = 0.0;
//     totalProfit = 0.0;
//
//     for (var docItem in widget.docItemCtl.docItemsByDoc) {
//       final qty = docItem.qty ?? 0;
//       final income = docItem.incomePrice ?? 0;
//       final sale = docItem.salePrice ?? 0;
//
//       totalQty += qty;
//
//       if (docItem.currency != null) {
//         totalSalePrice += sale * qty * docItem.currency!.value!;
//         totalIncomePrice += income * qty * docItem.currency!.value!;
//       } else {
//         totalSalePrice += sale * qty;
//         totalIncomePrice += income * qty;
//       }
//       totalProfit += (sale - income) * qty;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = getScreenSize(context);
//
//     return Obx(
//       () {
//         calculateTotalValues();
//
//         if (widget.docItemCtl.isLoading.value) {
//           return Dialog(
//             child: Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: widget.size.width * 0.1,
//                 vertical: widget.size.height * 0.05,
//               ),
//               child: const Loading(
//                 hasPadding: false,
//               ),
//             ),
//           );
//         } else {
//           calculateTotalValues();
//
//           return DialogTable(
//             printer: widget.printerManager,
//             products: widget.docItemCtl.docItemsByDoc,
//             onClick: () => Navigator.of(context).pop(),
//             margin: EdgeInsets.symmetric(
//               horizontal: widget.size.width * 0.1,
//               vertical: widget.size.height * 0.05,
//             ),
//             title: DisplayTexts.full_info_about_products,
//             columns: _columns(),
//             rows: [
//               ...widget.docItemCtl.docItemsByDoc.asMap().entries.map(
//                 (docItemData) {
//                   int index = docItemData.key;
//                   DocumentItem docItem = docItemData.value;
//
//                   double income = 0.0;
//                   double sale = 0.0;
//
//                   if (docItem.currency != null) {
//                     income = docItem.incomePrice! * docItem.currency!.value!;
//                     sale = docItem.salePrice! * docItem.currency!.value!;
//                   } else {
//                     income = docItem.incomePrice!;
//                     sale = docItem.salePrice!;
//                   }
//
//                   return DataRow(
//                     cells: [
//                       DataCell(Container(
//                         alignment: Alignment.center,
//                         child: Text("${index + 1}"),
//                       )),
//                       DataCell(Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                             "${docItem.item!.name!}${docItem.itemType != null ? ' (${docItem.itemType})' : ''}"),
//                       )),
//                       DataCell(Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "${PriceFormatter.formatPrice(income)} ",
//                         ),
//                       )),
//                       DataCell(Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "${PriceFormatter.formatPrice(sale)} ",
//                         ),
//                       )),
//                       DataCell(
//                         Container(
//                           alignment: Alignment.center,
//                           child: Text(
//                             "${docItem.qty.toString()} ${docItem.item!.unit}",
//                             style: screenSize.width <= 1366
//                                 ? textStyleBlack15
//                                 : textStyleBlack18Bold,
//                           ),
//                         ),
//                       ),
//                       DataCell(
//                         Container(
//                           alignment: Alignment.center,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(
//                                   Icons.delete,
//                                   color: Colors.red,
//                                 ),
//                                 onPressed: () {
//                                   Get.dialog(
//                                     DeleteDialog(
//                                       title: docItem.item!.name!,
//                                       onConfirmDelete: () {
//                                         widget.docItemCtl
//                                             .removeItem(docItem.id!);
//                                         Navigator.of(context).pop();
//                                       },
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//               DataRow(
//                 cells: [
//                   const DataCell(CenterText(text: "Jami")),
//                   const DataCell(SizedBox.shrink()),
//                   DataCell(CenterText(
//                     text: "${PriceFormatter.formatPrice(totalIncomePrice)} uzs",
//                   )),
//                   DataCell(CenterText(
//                     text: "${PriceFormatter.formatPrice(totalSalePrice)} uzs",
//                   )),
//                   DataCell(CenterText(
//                     text: '',
//                   )),
//                   const DataCell(SizedBox.shrink()),
//                 ],
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
//
//   List<DataColumn> _columns() {
//     return <DataColumn>[
//       const DataColumn(
//           label: Text(TableTexts.index),
//           headingRowAlignment: MainAxisAlignment.center),
//       const DataColumn(
//           label: Text(TableTexts.name),
//           headingRowAlignment: MainAxisAlignment.center),
//       const DataColumn(
//           label: Text(TableTexts.income_price),
//           headingRowAlignment: MainAxisAlignment.center),
//       const DataColumn(
//           label: Text(TableTexts.selling_price),
//           headingRowAlignment: MainAxisAlignment.center),
//       const DataColumn(
//           label: Text(TableTexts.total_of_product),
//           headingRowAlignment: MainAxisAlignment.center),
//       const DataColumn(
//           label: Text(TableTexts.buttons),
//           headingRowAlignment: MainAxisAlignment.center),
//     ];
//   }
// }




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
  double get _totalIncomePrice => widget.docItemCtl.docItemsByDoc.fold(
        0.0,
        (sum, item) =>
            sum +
            (item.incomePrice ?? 0) *
                (item.qty ?? 0) *
                (item.currency?.value ?? 1),
      );

  double get _totalSalePrice => widget.docItemCtl.docItemsByDoc.fold(
        0.0,
        (sum, item) =>
            sum +
            (item.salePrice ?? 0) *
                (item.qty ?? 0) *
                (item.currency?.value ?? 1),
      );

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    final padding = EdgeInsets.symmetric(
      horizontal: widget.size.width * 0.2,
      vertical: widget.size.height * 0.1,
    );

    return Obx(() {
      if (widget.docItemCtl.isLoading.value) {
        return Dialog(
          child: Container(
            margin: padding,
            child: const Loading(hasPadding: false),
          ),
        );
      }

      final items = widget.docItemCtl.docItemsByDoc;

      return DialogTable(
        printer: widget.printerManager,
        products: items,
        title: 'full info about products'.tr,
        margin: padding,
        onClick: () => Navigator.of(context).pop(),
        columns: _buildColumns(),
        rows: [
          ...items.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final item = entry.value;
            final income =
                (item.incomePrice ?? 0) * (item.currency?.value ?? 1);
            final sale = (item.salePrice ?? 0) * (item.currency?.value ?? 1);

            return DataRow(cells: [
              _cell(Text('$index')),
              _cell(Text(
                  "${item.item!.name!}${item.itemType != null ? ' (${item.itemType})' : ''}")),
              _cell(Text(PriceFormatter.formatPrice(income))),
              _cell(Text(PriceFormatter.formatPrice(sale))),
              _cell(
                Text(
                  "${item.qty} ${item.item!.unit}",
                  style: screenSize.width <= 1366
                      ? textStyleBlack15
                      : textStyleBlack18Bold,
                ),
              ),
              _cell(_buildActionButton(item)),
            ]);
          }),
          DataRow(cells: [
            const DataCell(CenterText(text: "Jami")),
            const DataCell(SizedBox.shrink()),
            _cell(Text("${PriceFormatter.formatPrice(_totalIncomePrice)} uzs")),
            _cell(Text("${PriceFormatter.formatPrice(_totalSalePrice)} uzs")),
            const DataCell(SizedBox.shrink()),
            const DataCell(SizedBox.shrink()),
          ]),
        ],
      );
    });
  }

  Widget _buildActionButton(DocumentItem item) => IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => Get.dialog(
          DeleteDialog(
            title: item.item!.name!,
            onConfirmDelete: () {
              widget.docItemCtl.removeItem(item.id!);
              Navigator.of(context).pop();
            },
          ),
        ),
      );

  DataCell _cell(Widget child) => DataCell(
        Container(alignment: Alignment.center, child: child),
      );

  List<DataColumn> _buildColumns() => const [
        DataColumn(label: Text(TableTexts.index)),
        DataColumn(label: Text(TableTexts.name)),
        DataColumn(label: Text(TableTexts.income_price)),
        DataColumn(label: Text(TableTexts.selling_price)),
        DataColumn(label: Text(TableTexts.total_of_product)),
        DataColumn(label: Text(TableTexts.buttons)),
      ];
}
