import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/utils/globals.dart';
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
      scaffoldMessengerKey: messengerKey,
      title: 'Oson Kassa',
      translations: AppTranslations(),
      locale: const Locale('uz', 'Uz'),
      fallbackLocale: const Locale('uz', 'Uz'),
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

// import 'package:flutter/material.dart'
//     as m; // Prefixing Material to avoid conflicts
// import 'package:get/get.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(m.BuildContext context) {
//     return GetMaterialApp(
//       title: 'Oson Kassa',
//       translations: AppTranslations(),
//       locale: const Locale('uz', 'Uz'),
//       fallbackLocale: const Locale('uz', 'Uz'),
//       theme: _buildLightTheme(context),
//       darkTheme: _buildDarkTheme(context),
//       themeMode: m.ThemeMode.light,
//       debugShowCheckedModeBanner: false,
//       initialRoute: AppPaths.auth,
//       initialBinding: InitialBindings(),
//       getPages: PageCreator.pages,

//       // --- SHADCN INTEGRATION START ---
//       builder: (context, child) {
//         return ShadcnApp(
//           debugShowCheckedModeBanner: false,
//           // We pass the GetMaterialApp's navigator (child) into ShadcnApp
//           home: child,
//           theme: ThemeData(
//             colorScheme: ColorSchemes.lightZinc(),
//             radius: 0.5,
//           ),
//           darkTheme: ThemeData(
//             colorScheme: ColorSchemes.darkZinc(),
//             radius: 0.5,
//           ),
//         );
//       },
//       // --- SHADCN INTEGRATION END ---
//     );
//   }
// }

// m.ThemeData _buildLightTheme(m.BuildContext context) {
//   final base = m.ThemeData(
//     useMaterial3: true,
//     colorScheme: m.ColorScheme.fromSeed(seedColor: m.Colors.deepPurple),
//     scaffoldBackgroundColor: secondary,
//   );

//   return base.copyWith(
//     textTheme: AppTextStyle.textTheme(context),
//     elevatedButtonTheme: m.ElevatedButtonThemeData(
//       style: m.ElevatedButton.styleFrom(
//           textStyle: AppTextStyle.textTheme(context).labelLarge),
//     ),
//   );
// }

// m.ThemeData _buildDarkTheme(m.BuildContext context) {
//   final base = m.ThemeData(
//     brightness: m.Brightness.dark,
//     useMaterial3: true,
//     colorScheme: m.ColorScheme.fromSeed(
//       seedColor: m.Colors.deepPurple,
//       brightness: m.Brightness.dark,
//     ),
//     scaffoldBackgroundColor: m.Colors.black,
//   );

//   return base.copyWith(
//     textTheme:
//         AppTextStyle.textTheme(context, color: base.colorScheme.onSurface),
//     elevatedButtonTheme: m.ElevatedButtonThemeData(
//       style: m.ElevatedButton.styleFrom(
//           textStyle: AppTextStyle.textTheme(context).labelLarge),
//     ),
//   );
// }
