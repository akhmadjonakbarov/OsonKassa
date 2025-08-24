// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/core/enums/product_doc_type.dart';
import 'package:osonkassa/app/core/printer/pos_printer_manager.dart';
import 'package:osonkassa/app/features/dashboard_views/document/logic/document/document_ctl.dart';
import 'package:osonkassa/app/features/dashboard_views/document/view/main_screen/table/doc_item_table_dialog.dart';
import 'package:osonkassa/app/features/dashboard_views/note/logic/note_controller.dart';
import 'package:osonkassa/app/features/shared/export_commons.dart';
import 'package:osonkassa/app/styles/text_styles.dart';
import 'package:osonkassa/app/translation/translated_texts.dart';
import 'package:osonkassa/app/utils/formatter_functions/formatter_date.dart';
import 'package:osonkassa/app/utils/media/get_screen_size.dart';
import 'package:osonkassa/app/utils/texts/display_texts.dart';

import '../../../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../logic/doc_item/doc_item_ctl.dart';
import '../../../models/document_model.dart';

class DocumentTable extends StatefulWidget {
  final DocumentCtl documentCtl;

  const DocumentTable({super.key, required this.documentCtl});

  @override
  State<DocumentTable> createState() => _DebtTableState();
}

class _DebtTableState extends State<DocumentTable> {
  final DocItemCtl doc_item_ctl = Get.find<DocItemCtl>();
  final NoteCtl spiskaCtl = Get.find<NoteCtl>();
  late final PosPrinterManager _printer;

  @override
  void initState() {
    _initPrinter();

    super.initState();
  }

  void _initPrinter() async {
    _printer = PosPrinterManager(printerIp: '192.168.123.100');
    await _printer.initPrinter();
  }

  showDialogWindow() {
    Size size = getScreenSize(context);

    Get.dialog(
      DocItemTableDialog(
        printerManager: _printer,
        size: size,
        docItemCtl: doc_item_ctl,
        spiskaCtl: spiskaCtl,
      ),
    ).then(
      (value) => widget.documentCtl.fetchItems(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicContainer(
      decoration: const BoxDecoration(),
      padding: EdgeInsets.zero,
      child: CustomDataTable(
        columns: [
          TranslatedTexts.table.number.tr,
          TranslatedTexts.table.date.tr,
          TranslatedTexts.table.typeOfProduct.tr,
          TranslatedTexts.table.totalOfProduct.tr,
          'price'.tr,
          'discount'.tr,
          TranslatedTexts.table.documentType.tr,
          TranslatedTexts.table.seeDetail.tr
        ],
        rows: widget.documentCtl.list.asMap().entries.map(
          (entry) {
            int index = entry.key;
            Document document = entry.value;

            bool isSold = document.docType == DocumentType.sell.name;

            return DataRow(
              color: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  // Check the condition here
                  if (isSold) {
                    return Colors.teal;
                  }

                  return null;
                },
              ),
              cells: <DataCell>[
                DataCell(
                  CenterText(
                    text: document.id.toString(),
                    style: textStyleBlack18.copyWith(
                      color: isSold ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                DataCell(
                  CenterText(
                    text: formatDate(document.createdAt.toString(),
                        hasHour: true),
                    style: textStyleBlack18.copyWith(
                      color: isSold ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                DataCell(
                  CenterText(
                    text: "${document.typeOfItems} xil",
                    style: textStyleBlack18.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isSold ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                DataCell(
                  CenterText(
                    text: "${document.countOfItems.toString()} ta",
                    style: textStyleBlack18.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isSold ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                DataCell(
                  CenterText(
                    text: PriceFomatter.formatPrice(document.price ?? 0.0),
                    style: textStyleBlack18.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isSold ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                DataCell(
                  CenterText(
                    text: PriceFomatter.formatPrice(document.discount ?? 0.0),
                    style: textStyleBlack18.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isSold ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                DataCell(Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CenterText(
                        text:
                            isSold ? DisplayTexts.sold : DisplayTexts.received,
                        style: textStyleBlack18.copyWith(
                          color: isSold ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Icon(
                      isSold ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isSold ? Colors.black : Colors.green,
                    ),
                  ],
                )),
                DataCell(Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.list,
                        color: isSold ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        doc_item_ctl.fetchByProductId(document.id!);
                        showDialogWindow();
                      },
                    ),
                  ],
                )),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
