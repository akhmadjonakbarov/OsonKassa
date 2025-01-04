import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/texts/table_texts.dart';
import '../../../../shared/export_commons.dart';
import '../../../../dashboard/logic/controllers/dashboard_controller.dart';
import '../../logic/note_controller.dart';
import '../../models/note_model.dart';

class SpiskaTable extends StatefulWidget {
  final NoteCtl providerController;

  const SpiskaTable({super.key, required this.providerController});

  @override
  State<SpiskaTable> createState() => _SpiskaTableState();
}

class _SpiskaTableState extends State<SpiskaTable> {
  DashboardCtl dashboardController = Get.find<DashboardCtl>();

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      decoration: const BoxDecoration(),
      padding: EdgeInsets.zero,
      child: CustomDataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text(TableTexts.index)),
          DataColumn(label: Text(TableTexts.name)),
          DataColumn(label: Text(TableTexts.category)),
          DataColumn(label: Text(TableTexts.company)),
        ],
        rows: widget.providerController.list.asMap().entries.map(
          (entry) {
            int index = entry.key;
            NoteModel spiska = entry.value;
            return DataRow(
              cells: <DataCell>[
                DataCell(Text("${index + 1}")),
                DataCell(Text(spiska.item.name)),
                DataCell(Text(spiska.item.category.name)),
                DataCell(Text(spiska.item.company!.name)),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
