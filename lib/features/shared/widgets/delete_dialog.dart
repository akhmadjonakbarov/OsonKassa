import 'package:flutter/material.dart';

import '../../../styles/text_styles.dart';
import '../../../utils/texts/alert_texts.dart';
import '../../../utils/texts/button_texts.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function onConfirmDelete;

  const DeleteDialog({
    super.key,
    required this.title,
    this.content = AlertTexts.delete_info,
    required this.onConfirmDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: textStyleBlack20.copyWith(
            fontSize: 22, fontWeight: FontWeight.w700),
      ),
      content: Text(
        content,
        style: textStyleBlack20,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            ButtonTexts.cancel,
            style: textStyleBlack18,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Customize delete button color
          ),
          child: Text(
            ButtonTexts.delete,
            style: textStyleWhite18,
          ),
          onPressed: () {
            onConfirmDelete(); // Call the delete action
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}
