import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';

import 'app/app.dart';

class AppLogger {
  static final Logger _logger = Logger('OsonKassa');

  static Logger get instance => _logger;

  static void setupLogging() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the date formatting for the Uzbek locale
  await initializeDateFormatting('uz_UZ', null);

  // Initialize the logging system
  AppLogger.setupLogging();

  runApp(const App());
}
