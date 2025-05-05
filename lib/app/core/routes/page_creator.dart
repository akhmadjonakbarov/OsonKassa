import 'package:get/get.dart';

import '../../config/app_paths.dart';
import '../../features/auth/view/auth_screen.dart';
import '../../features/client_detail/views/client_detail_screen.dart';
import '../../features/dashboard/logic/bindings/dashboard_binding.dart';
import '../../features/dashboard/view/dashboard_screen.dart';
import '../../features/manage_store/manage_store_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/report_docs/views/report_docs_screen.dart';
import '../../features/report_store/views/store_report_screen.dart';

class PageCreator {
  static List<GetPage> pages = [
    GetPage(
      name: AppPaths.auth,
      page: () => const AuthScreen(),
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
    ),
    GetPage(
      name: AppPaths.profile,
      page: () => const ProfileScreen(), // Add your logout screen here
    ),
    GetPage(
      name: AppPaths.clientDetail,
      page: () => const ClientDetailScreen(),
    ),
  ];
}
