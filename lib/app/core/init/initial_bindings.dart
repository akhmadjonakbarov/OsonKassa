import 'package:get/get.dart';
import 'package:osonkassa/app/features/shared/export_commons.dart';

import '../../features/auth/logic/controllers/auth_ctl.dart';
import '../../features/report_docs/logic/report_ctl.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenCtl(), fenix: true);
    Get.lazyPut(() => AuthCtl(), fenix: true);
    Get.lazyPut(() => ReportCtl(), fenix: true);
  }
}
