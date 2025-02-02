import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/app_paths.dart';
import 'features/auth/logic/bindings/auth_binding.dart';
import 'features/auth/view/auth_screen.dart';
import 'features/client_detail/views/client_detail_screen.dart';
import 'features/dashboard/logic/bindings/dashboard_binding.dart';
import 'features/dashboard/view/dashboard_screen.dart';
import 'features/manage_store/manage_store_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/report_docs/logic/report_binding.dart';
import 'features/report_docs/views/report_docs_screen.dart';
import 'features/report_store/views/store_report_screen.dart';
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
      getPages: [
        GetPage(
          name: AppPaths.auth,
          page: () => const AuthScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: AppPaths.manageStore,
          page: () => const ManageStoreScreen(),

        ),
        GetPage(
          name: AppPaths.dashboard,
          page: () => const DashboardScreen(),
          binding: DashboardBinding(),
        ),
        GetPage(
          name: AppPaths.storeStatistic,
          page: () => const StoreReportScreen(),
        ),
        GetPage(
          name: AppPaths.reportDocs,
          page: () => const ReportDocsScreen(),
          binding: ReportBinding(),
        ),
        GetPage(
          name: AppPaths.profile,
          page: () => const ProfileScreen(), // Add your logout screen here
        ),
        GetPage(
          name: AppPaths.clientDetail,
          page: () => const ClientDetailScreen(),
        )
      ],
    );
  }
}
