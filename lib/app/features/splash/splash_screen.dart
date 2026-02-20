import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/config/app_paths.dart';
import 'package:osonkassa/app/features/dashboard_views/currency/logic/currency_controller.dart';
import 'package:osonkassa/app/features/dashboard_views/item/logic/item_ctl.dart';

import '../action/logic/action_ctl.dart';
import '../auth/logic/controllers/auth_ctl.dart';
import '../dashboard_views/customer/logic/customer_ctl.dart';
import '../report_docs/logic/report_ctl.dart';
import '../shared/token_controller/token_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthCtl authCtl = Get.find<AuthCtl>();
  final TokenCtl tokenCtl = Get.find<TokenCtl>();
  final ActionCtl actionCtl = Get.find<ActionCtl>();
  final ReportCtl reportCtl = Get.find<ReportCtl>();
  final ItemCtl productController = Get.find<ItemCtl>();
  final CustomerCtl customerController = Get.find<CustomerCtl>();
  final CurrencyCtl currencyController = Get.find<CurrencyCtl>();

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    await productController.fetchItems();
    await reportCtl.fetchItems();
    await customerController.fetchItems();
    await currencyController.fetchItems();
    await Future.delayed(const Duration(seconds: 4));
    Get.toNamed(AppPaths.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text("Loading...")
          ],
        ),
      ),
    );
  }
}
