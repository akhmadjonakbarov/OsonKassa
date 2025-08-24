import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../styles/text_styles.dart';
import '../../../../../../utils/texts/table_texts.dart';
import '../../../../../shared/export_commons.dart';
import '../../../logic/view_controller/manage_product_doc_item_ctl.dart';

class CachedProductsTable extends StatefulWidget {
  final ManageProductDocItemCtl manageProductDocItemCtl;

  const CachedProductsTable({super.key, required this.manageProductDocItemCtl});

  @override
  State<CachedProductsTable> createState() => _ProviderTableState();
}

class _ProviderTableState extends State<CachedProductsTable> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.manageProductDocItemCtl.productDocItems.isNotEmpty
          ? BasicContainer(
              padding: EdgeInsets.zero,
              child: DataTable(
                sortColumnIndex: 0,
                border:
                    TableBorder.all(borderRadius: BorderRadius.circular(16)),
                headingTextStyle: textStyleBlack18.copyWith(fontSize: 16),
                dataTextStyle: textStyleBlack14.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                columns: const <DataColumn>[
                  DataColumn(label: Text(TableTexts.index)),
                  DataColumn(label: Text(TableTexts.product)),
                  DataColumn(label: Text(TableTexts.qty)),
                  DataColumn(label: Text(TableTexts.income_price)),
                  DataColumn(label: Text(TableTexts.selling_price)),
                  DataColumn(label: Text(TableTexts.buttons)),
                ],
                rows: List.generate(
                  widget.manageProductDocItemCtl.productDocItems.length,
                  (index) {
                    final product =
                        widget.manageProductDocItemCtl.productDocItems[index];

                    return DataRow(
                      cells: <DataCell>[
                        DataCell(CenterText(text: "${index + 1}")),
                        DataCell(CenterText(text: product.itemName)),
                        DataCell(
                            CenterText(text: "${product.qty} ${product.unit}")),
                        DataCell(
                            CenterText(text: product.incomePrice.toString())),
                        DataCell(
                            CenterText(text: product.sellingPrice.toString())),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.manageProductDocItemCtl
                                        .editProductDocItem(product);
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget
                                        .manageProductDocItemCtl.productDocItems
                                        .remove(product);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
