import 'package:flutter/material.dart';

class AppRoutes {
  static goToLoginScreen() {}
  static goToHomeScreen() {}
  static goToStatisticsScreen() {}
  static goToSettingsScreen() {}
  static goToProfileScreen() {}
  static goToAboutScreen() {}
  static goToCreateDocumentScreen() {}

  static pop(BuildContext ctx) {
    Navigator.pop(ctx);
  }
}
