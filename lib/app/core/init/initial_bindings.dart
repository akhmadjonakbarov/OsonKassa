import 'package:get/get.dart';

import '../../features/auth/logic/controllers/auth_ctl.dart';
import '../../features/customer_detail/logic/customer_detail_ctl.dart';
import '../../features/report_docs/logic/report_ctl.dart';
import '../../features/shared/export_commons.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenCtl(), fenix: true);
    Get.lazyPut(() => AuthCtl(), fenix: true);
    Get.lazyPut(() => ReportCtl(), fenix: true);
    Get.lazyPut(() => CustomerDetailCtl(), fenix: true);
  }
}
