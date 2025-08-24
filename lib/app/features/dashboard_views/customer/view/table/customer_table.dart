import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../config/app_paths.dart';
import '../../../../../translation/translated_texts.dart';
import '../../../../../utils/formatter_functions/format_phone_number.dart';
import '../../../../../utils/texts/display_texts.dart';
import '../../../../customer_detail/logic/customer_detail_ctl.dart';
import '../../../../shared/export_commons.dart';
import '../../../../shared/widgets/delete_dialog.dart';
import '../../logic/customer_ctl.dart';
import '../../models/customer.dart';

class CustomerTable extends StatefulWidget {
  final CustomerCtl builderController;

  const CustomerTable({super.key, required this.builderController});

  @override
  State<CustomerTable> createState() => _CustomerTableState();
}

class _CustomerTableState extends State<CustomerTable> {
  CustomerDetailCtl customerDetailCtl = Get.find<CustomerDetailCtl>();

  @override
  Widget build(BuildContext context) {
    return BasicContainer(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(),
      child: CustomDataTable(
        columns: [
          TranslatedTexts.table.index.tr,
          TranslatedTexts.table.name.tr,
          TranslatedTexts.table.phoneNumber.tr,
          TranslatedTexts.table.phoneNumber2.tr,
          TranslatedTexts.table.address.tr,
          TranslatedTexts.table.buttons.tr
        ],
        rows: widget.builderController.list.asMap().entries.map((entry) {
          int index = entry.key;
          Customer client = entry.value;
          return DataRow(
            onSelectChanged: (_) {
              Get.toNamed(
                AppPaths.clientDetail,
                arguments: client,
              );
            },
            cells: <DataCell>[
              DataCell(CenterText(text: "${index + 1}")),
              DataCell(CenterText(text: client.fullName!)),
              DataCell(
                  CenterText(text: formatPhoneNumber(client.phoneNumber!))),
              DataCell(CenterText(
                  text: client.phoneNumber2 != ""
                      ? formatPhoneNumber(client.phoneNumber2!)
                      : DisplayTexts.no_extra_number)),
              DataCell(CenterText(text: client.address!)),
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                      onPressed: () => widget.builderController
                          .selectCustomer(client, context),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => DeleteDialog(
                          title: client.fullName!,
                          onConfirmDelete: () =>
                              widget.builderController.removeItem(client.id!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
