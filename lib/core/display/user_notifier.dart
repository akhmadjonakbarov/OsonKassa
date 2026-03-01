import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/utils/globals.dart';

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
      instantInit: false,
      titleText: Text(label,
          style: textStyleWhite18.copyWith(
            fontSize: 22,
          )),
      messageText: Text(text, style: textStyleWhite18.copyWith(fontSize: 20)),
    );
  }

  static void showFlutterSnackBar({
    required BuildContext context,
    String label = "Xatolik!",
    String text = "",
    TypeOfSnackBar type = TypeOfSnackBar.delete,
    Duration duration = const Duration(seconds: 3),
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

    // Close the current snackbar if open
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: snackBarColor,
      duration: duration,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textStyleWhite18.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: textStyleWhite18.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Color _getDarkColor(TypeOfSnackBar type) {
    switch (type) {
      case TypeOfSnackBar.error:
        return const Color(0xFFB71C1C); // Dark Red
      case TypeOfSnackBar.success:
        return const Color(0xFF1B5E20); // Dark Green
      case TypeOfSnackBar.delete:
        return const Color(0xFF0D47A1); // Dark Blue
      case TypeOfSnackBar.update:
        return const Color(0xFFE65100); // Dark Orange
      case TypeOfSnackBar.alert:
        return const Color(0xFFE64A19); // Dark Deep Orange
    }
  }

  static void snackbar({
    required String label,
    String text = "",
    TypeOfSnackBar type = TypeOfSnackBar.success,
  }) {
    final Color baseColor = _getDarkColor(type);

    // Clear existing snacks to prevent stacking
    messengerKey.currentState?.clearSnackBars();

    messengerKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: baseColor,
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
              color: Colors.white24, width: 1), // High contrast border
        ),
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            _getIcon(type),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (text.isNotEmpty)
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => messengerKey.currentState?.hideCurrentSnackBar(),
              icon: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _getIcon(TypeOfSnackBar type) {
    IconData iconData;
    switch (type) {
      case TypeOfSnackBar.error:
        iconData = Icons.report_gmailerrorred;
        break;
      case TypeOfSnackBar.success:
        iconData = Icons.check_circle_outline;
        break;
      case TypeOfSnackBar.delete:
        iconData = Icons.delete_outline;
        break;
      case TypeOfSnackBar.update:
        iconData = Icons.update;
        break;
      case TypeOfSnackBar.alert:
        iconData = Icons.warning_amber_rounded;
        break;
    }
    return Icon(iconData, color: Colors.white, size: 28);
  }
}
