import 'package:flutter/material.dart';

import '../../../styles/text_input_styles.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/texts/alert_texts.dart';
import '../../../utils/texts/button_texts.dart';
import '../../../utils/texts/display_texts.dart';

class CustomTextField extends StatefulWidget {
  final Function(String) onChanged;
  final Function(String?) validator;
  final String labelText;

  const CustomTextField({
    super.key,
    required this.onChanged,
    required this.labelText,
    required this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: (value) {
        return widget.validator(value);
      },
      style: textStyleBlack18,
      decoration: customInputDecoration(widget.labelText),
    );
  }
}

class CustomDialogTextField extends StatelessWidget {
  final String label;
  final bool canBeNull;
  final TextEditingController controller;

  const CustomDialogTextField(
      {super.key,
      required this.label,
      required this.controller,
      this.canBeNull = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (!canBeNull && value!.isEmpty) {
              return AlertTexts.fill_field;
            }
            return null;
          },
          controller: controller,
          style: textStyleBlack18,
          decoration: InputDecoration(
            errorStyle: textStyleBlack18.copyWith(color: Colors.red),
            labelStyle: textStyleBlack18,
            labelText: label,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class SearchTextField extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;

  const SearchTextField({
    super.key,
    required this.onChanged,
    this.hintText =
        "${ButtonTexts.search} | ${DisplayTexts.name_of_product} | BARCODE",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => onChanged(value),
      style: textStyleBlack14,
      decoration: InputDecoration(
        hintStyle: textStyleBlack14,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
