import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/app_colors.dart';
import '../../../utils/media/get_screen_size.dart';
import '../../action/logic/action_ctl.dart';
import '../../auth/logic/controllers/auth_ctl.dart';
import '../../shared/export_commons.dart';
import '../logic/controllers/dashboard_controller.dart';
import 'widgets/contentbar.dart';
import 'widgets/sidebar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardCtl dashboardCtl = Get.find<DashboardCtl>();
  final AuthCtl authCtl = Get.find<AuthCtl>();
  final TokenCtl tokenCtl = Get.find<TokenCtl>();
  final ActionCtl actionCtl = Get.find<ActionCtl>();

  @override
  void didChangeDependencies() {
    tokenCtl.setToken(authCtl.userModel.value.token);
    actionCtl.fetchItems();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = getScreenSize(context);
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SideBar(
              dashboardController: dashboardCtl,
              sizeScreen: sizeScreen,
            ),
            ContentBar(
              dashboardCtl: dashboardCtl,
              sizeScreen: sizeScreen,
            )
          ],
        ),
      ),
    );
  }
}
