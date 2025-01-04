import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../styles/container_decoration.dart';
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
          ? AppContainer(
              decoration: containerDecoration,
              child: DataTable(
                sortColumnIndex: 0,
                headingTextStyle: textStyleBlack18.copyWith(fontSize: 16),
                dataTextStyle: textStyleBlack14.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                columns: const <DataColumn>[
                  DataColumn(label: Text(TableTexts.index)),
                  DataColumn(label: Text("Mahsulot")),
                  DataColumn(label: Text("Soni")),
                  DataColumn(label: Text(TableTexts.income_price)),
                  DataColumn(label: Text(TableTexts.selling_price)),
                  DataColumn(label: Text(TableTexts.buttons)),
                ],
                rows: widget.manageProductDocItemCtl.productDocItems
                    .asMap()
                    .entries
                    .map(
                  (entry) {
                    int index = entry.key;
                    Map<String, dynamic> product = entry.value;
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text("${index + 1}")),
                        DataCell(Text(product['item']['name'])),
                        DataCell(Text(product['qty'].toString())),
                        DataCell(Text(product['income_price'].toString())),
                        DataCell(Text(product['selling_price'].toString())),
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
                ).toList(),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
