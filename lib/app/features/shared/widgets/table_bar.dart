import 'package:flutter/material.dart';

import '../../../core/permission_checker/permission_checker.dart';
import '../../../utils/texts/button_texts.dart';
import '../export_commons.dart';

class TableBar extends StatelessWidget {
  const TableBar({
    super.key,
    required this.screenSize,
    required this.onEdit,
    required this.onSearch,
    required this.role,
  });

  final Size screenSize;
  final Function(String) onSearch;
  final Function() onEdit;
  final String role;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenSize.width * 0.15,
            child: SearchTextField(
              hintText: ButtonTexts.search,
              onChanged: (value) => onSearch(value),
            ),
          ),
          if (screenSize.width <= 1370)
            SizedBox(
              width: screenSize.width * 0.1,
              child: PermissionCheckerS.addButton(
                role,
                () {
                  onEdit();
                },
                Size(0, screenSize.height * 0.06),
              ),
            )
          else
            SizedBox(
              width: screenSize.width * 0.08,
              child: PermissionCheckerS.addButton(
                role,
                () {
                  onEdit();
                },
                Size(0, screenSize.height * 0.05),
              ),
            ),
        ],
      ),
    );
  }
}
