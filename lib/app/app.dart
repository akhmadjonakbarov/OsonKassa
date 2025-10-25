import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/design_system/themes/text_styles.dart';

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

      // ⚡ Use helper builders so we can pass BuildContext to the theme
      theme: _buildLightTheme(context),
      darkTheme: _buildDarkTheme(context),
      themeMode: ThemeMode.light,

      debugShowCheckedModeBanner: false,
      initialRoute: AppPaths.auth,
      initialBinding: InitialBindings(),
      getPages: PageCreator.pages,
    );
  }
}

ThemeData _buildLightTheme(BuildContext context) {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    scaffoldBackgroundColor: secondary, // your color
  );

  return base.copyWith(
    textTheme: AppTextStyle.textTheme(context),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: AppTextStyle.textTheme(context).labelLarge),
    ),
  );
}

ThemeData _buildDarkTheme(BuildContext context) {
  final base = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.black, // or your dark secondary
  );

  return base.copyWith(
    textTheme:
        AppTextStyle.textTheme(context, color: base.colorScheme.onSurface),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: AppTextStyle.textTheme(context).labelLarge),
    ),
  );
}
