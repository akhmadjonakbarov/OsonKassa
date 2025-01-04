import '../logic/ctl/client_debt_ctl.dart';
import '../../shared/widgets/grid_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/app_bar.dart';
import '../../dashboard_views/customer/models/client_model.dart';
import 'widgets/debts_box.dart';

class ClientDetailScreen extends StatefulWidget {
  const ClientDetailScreen({
    super.key,
  });

  @override
  State<ClientDetailScreen> createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends State<ClientDetailScreen> {
  CustomerModel? client;
  final ClientDebtCtl clientDebtCtl = Get.find<ClientDebtCtl>();

  @override
  void didChangeDependencies() {
    client = Get.arguments as CustomerModel;
    clientDebtCtl.fetchItems(client!.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TopBar(
              text: client!.full_name,
            ),
            Expanded(
              child: GridView(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: [
                  DebtsBox(clientDebtCtl: clientDebtCtl, client: client),
                  GridBox(
                    child: Container(),
                  ),
                  GridBox(
                    child: Container(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
