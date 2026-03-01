import 'package:flutter/material.dart';

import 'text_styles.dart';

InputDecoration customInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: textStyleBlack18.copyWith(
      fontSize: 16,
      color: Colors.grey,
    ),
    errorStyle: textStyleBlack18.copyWith(
      color: Colors.redAccent,
      fontSize: 17,
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green, // Change the focused border color here
      ),
    ),
    border: const OutlineInputBorder(),
    fillColor: Colors.white,
  );
}
