import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/features/customer_detail/views/widgets/payment_histories_box.dart';

import '../../dashboard_views/customer/domain/models/customer.dart';
import '../../shared/widgets/app_bar.dart';
import '../logic/customer_detail_ctl.dart';
import 'widgets/debts_box.dart';
import 'widgets/purchases_box.dart';

class CustomerDetailScreen extends StatefulWidget {
  const CustomerDetailScreen({
    super.key,
  });

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  Customer? customer;
  final CustomerDetailCtl customerDetailCtl = Get.find<CustomerDetailCtl>();

  @override
  void didChangeDependencies() {
    customer = Get.arguments as Customer;
    if (customer != null) {
      customerDetailCtl.loadCustomerDetails(customer!.id!);
      customerDetailCtl.getPaymentHistories(customer!.id!);
    }
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
              text: customer!.fullName!,
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
                  DebtsBox(
                      customerDetailCtl: customerDetailCtl, client: customer),
                  PurchasesBox(
                      customerDetailCtl: customerDetailCtl, customer: customer),
                  PaymentHistoriesBox(
                      customerDetailCtl: customerDetailCtl, customer: customer)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
