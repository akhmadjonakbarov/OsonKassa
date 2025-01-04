import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../styles/text_styles.dart';
import '../enums/type_of_snackbar.dart';

class UserNotifier {
  static void showSnackBar({
    String label = "Xatolik!",
    String text = "",
    TypeOfSnackBar type = TypeOfSnackBar.delete,
    Duration duration = const Duration(seconds: 5),
    EdgeInsets margin =
        const EdgeInsets.symmetric(vertical: 5, horizontal: 300),
  }) {
    Color snackBarColor = Colors.green;

    switch (type) {
      case TypeOfSnackBar.error:
        snackBarColor = Colors.red;
        break;
      case TypeOfSnackBar.success:
        snackBarColor = Colors.green;
        break;
      case TypeOfSnackBar.delete:
        snackBarColor = Colors.blue;
        break;
      case TypeOfSnackBar.update:
        snackBarColor = Colors.orange;
        break;
      case TypeOfSnackBar.alert:
        snackBarColor = Colors.deepOrange;
        break;
    }
    // Close the currently open snackbar, if any
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.snackbar(
      '', // Leave empty if you're using a styled Text widget for the label
      '', // Leave empty if you're using a styled Text widget for the message
      snackPosition: SnackPosition.TOP,
      backgroundColor: snackBarColor,
      colorText: Colors.white,
      // Will be ignored if you're using custom Text widgets
      duration: duration,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
      onTap: (snack) => Get.back(),
      margin: margin,
      forwardAnimationCurve: Curves.easeInOut,
      reverseAnimationCurve: Curves.easeInOut,
      titleText: Text(label,
          style: textStyleWhite18.copyWith(
            fontSize: 22,
          )),
      messageText: Text(text, style: textStyleWhite18.copyWith(fontSize: 20)),
    );
  }
}
