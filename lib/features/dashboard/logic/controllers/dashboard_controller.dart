import 'package:get/get.dart';

import '../../../../config/app_views.dart';

class DashboardCtl extends GetxController {
  var selectedView = AppViews.dashboard.obs;

  void changeView(String view) {
    selectedView.value = view;
  }

  bool isSelected(String view) {
    return selectedView.value == view;
  }
}
