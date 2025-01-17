import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/formatter_functions/format_phone_number.dart';
import '../../../../../utils/texts/display_texts.dart';
import '../../../../../utils/texts/table_texts.dart';
import '../../../../client_detail/logic/ctl/client_debt_ctl.dart';
import '../../../../client_detail/views/client_detail_screen.dart';
import '../../../../shared/export_commons.dart';
import '../../../../shared/widgets/delete_dialog.dart';
import '../../logic/client_ctl.dart';
import '../../models/client_model.dart';

class ClientTable extends StatefulWidget {
  final ClientCtl builderController;

  const ClientTable({super.key, required this.builderController});

  @override
  State<ClientTable> createState() => _ClientTableState();
}

class _ClientTableState extends State<ClientTable> {
  ClientDebtCtl clientDebtCtl = Get.find<ClientDebtCtl>();

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(),
      child: CustomDataTable(
        columns: const [
          TableTexts.index,
          TableTexts.fish,
          TableTexts.phone_number,
          TableTexts.phone_number2,
          TableTexts.address,
          TableTexts.buttons
        ],
        rows: widget.builderController.list.asMap().entries.map((entry) {
          int index = entry.key;
          CustomerModel client = entry.value;
          return DataRow(
            onSelectChanged: (_) {
              Get.to(
                () => const ClientDetailScreen(),
                arguments: client,
              );
            },
            cells: <DataCell>[
              DataCell(CenterText(text: "${index + 1}")),
              DataCell(CenterText(text: client.full_name)),
              DataCell(
                  CenterText(text: formatPhoneNumber(client.phone_number))),
              DataCell(CenterText(
                  text: client.phone_number2 != ""
                      ? formatPhoneNumber(client.phone_number2)
                      : DisplayTexts.no_extra_number)),
              DataCell(CenterText(text: client.address)),
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
                          .selectBuilder(client, context),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => DeleteDialog(
                          title: client.full_name,
                          onConfirmDelete: () =>
                              widget.builderController.removeItem(client.id),
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
