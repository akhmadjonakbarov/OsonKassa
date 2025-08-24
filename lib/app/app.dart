import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/app_paths.dart';
import 'core/init/initial_bindings.dart';
import 'core/routes/page_creator.dart';
import 'styles/colors.dart';
import 'translation/translations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Oson Kassa',
      translations: AppTranslations(),
      locale: const Locale('uz', 'Uz'),
      fallbackLocale: const Locale('uz', 'Uz'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: secondary,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPaths.auth,
      initialBinding: InitialBindings(),
      getPages: PageCreator.pages,
    );
  }
}
