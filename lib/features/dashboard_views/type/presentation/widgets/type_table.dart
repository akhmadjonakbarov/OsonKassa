import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/features/dashboard_views/type/domain/models/type.dart';
import 'package:osonkassa/features/dashboard_views/type/presentation/controller/type_controller.dart';
import 'package:osonkassa/features/shared/widgets/app_container.dart';

import '../../../../../translation/translated_texts.dart';
import '../../../../shared/widgets/buttons.dart';
import '../../../../shared/widgets/center_text.dart';
import '../../../../shared/widgets/custom_data_table.dart';

class TypeTable extends StatefulWidget {
  final TypeController typeController;
  final List<Type_> types;

  TypeTable({
    super.key,
    required this.typeController,
    required this.types,
  });

  @override
  State<TypeTable> createState() => _CategoryTableState();
}

class _CategoryTableState extends State<TypeTable> {
  @override
  Widget build(BuildContext context) {
    return BasicContainer(
      padding: const EdgeInsets.only(bottom: 10),
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(),
      child: CustomDataTable(
        columns: [
          TranslatedTexts.table.index.tr,
          TranslatedTexts.table.category.tr,
          TranslatedTexts.table.buttons.tr,
        ],
        rows: widget.types.asMap().entries.map(
          (entry) {
            int index = entry.key;
            Type_ category = entry.value;
            return DataRow(
              cells: <DataCell>[
                DataCell(Text("${index + 1}")),
                DataCell(CenterText(text: category.name!)),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EditIconButton(
                        onEdit: () =>
                            widget.typeController.selectType(category),
                      ),
                      DeleteIconButton(
                        onDelete: () =>
                            widget.typeController.deleteType(category.id!),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
