import 'package:get/get.dart';

import '../../config/app_paths.dart';
import '../../features/auth/view/auth_screen.dart';
import '../../features/customer_detail/views/customer_detail_screen.dart';
import '../../features/dashboard/logic/bindings/dashboard_binding.dart';
import '../../features/dashboard/view/dashboard_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/report_docs/views/report_docs_screen.dart';
import '../../features/report_store/views/store_report_screen.dart';
import '../../features/splash/splash_screen.dart';

class PageCreator {
  static List<GetPage> pages = [
    GetPage(
      name: AppPaths.auth,
      page: () => const AuthScreen(),
    ),
    GetPage(
      name: AppPaths.dashboard,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: AppPaths.storeStatistic,
      page: () => const StoreReportScreen(),
    ),
    GetPage(
      name: AppPaths.reportDocs,
      page: () => const ReportDocsScreen(),
    ),
    GetPage(
      name: AppPaths.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppPaths.clientDetail,
      page: () => const CustomerDetailScreen(),
    ),
    GetPage(
      name: AppPaths.splash,
      page: () => const SplashScreen(),
      binding: DashboardBinding(),
    ),
  ];
}
