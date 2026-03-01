import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/translation/translated_texts.dart';

import '../../../../../utils/texts/table_texts.dart';
import '../../../../dashboard/logic/controllers/dashboard_controller.dart';
import '../../../../shared/export_commons.dart';
import '../../logic/note_controller.dart';
import '../../models/note.dart';

class NoteTable extends StatefulWidget {
  final NoteCtl noteController;

  const NoteTable({super.key, required this.noteController});

  @override
  State<NoteTable> createState() => _NoteTableState();
}

class _NoteTableState extends State<NoteTable> {
  DashboardCtl dashboardController = Get.find<DashboardCtl>();

  @override
  Widget build(BuildContext context) {
    return BasicContainer(
      decoration: const BoxDecoration(),
      padding: EdgeInsets.zero,
      child: CustomDataTable(
        columns: [
          TableTexts.index,
          TranslatedTexts.table.product.tr,
          TranslatedTexts.table.category.tr,
        ],
        rows: widget.noteController.list.asMap().entries.map(
          (entry) {
            int index = entry.key;
            Note note = entry.value;
            return DataRow(
              cells: <DataCell>[
                DataCell(Text("${index + 1}")),
                DataCell(Text(note.name!)),
                DataCell(Text(note.category!)),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
