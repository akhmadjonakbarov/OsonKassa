import 'package:get/get.dart';

import '../../../shared/token_controller/token_controller.dart';
import '../controllers/auth_ctl.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthCtl());
    Get.lazyPut(() => TokenCtl());
  }
}
