import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/core/init/initial_bindings.dart';
import 'package:osonkassa/app/core/routes/page_creator.dart';

import 'config/app_paths.dart';
import 'styles/colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Oson Kassa',
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
