import 'package:get/get.dart';

import 'report_ctl.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportCtl());
  }
}
