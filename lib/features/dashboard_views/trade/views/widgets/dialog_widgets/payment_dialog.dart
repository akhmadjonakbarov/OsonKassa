import 'package:osonkassa/features/dashboard_views/customer/domain/models/customer.dart';
import 'package:osonkassa/features/shared/widgets/buttons.dart';
import 'package:osonkassa/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/features/dashboard_views/trade/logic/order_controller.dart';
import 'package:osonkassa/features/dashboard_views/trade/logic/pay_controller.dart';
import 'package:osonkassa/features/dashboard_views/trade/models/order.dart';

import '../../../../../../utils/formatter_functions/formatter_currency.dart';

class PaymentDialog extends StatefulWidget {
  final Order order;
  final List<Customer> customers;

  const PaymentDialog(
      {super.key, required this.customers, required this.order});

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  Customer? selectedCustomer;
  bool isDebt = false;

  final PayController payController = Get.find<PayController>();
  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("payment_info".tr, style: textStyleBlack28),
            const SizedBox(height: 12),

            /// Customer selection (always visible)
            DropdownButtonFormField<Customer>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: isDebt
                    ? "select_customer_required".tr
                    : "select_customer_optional".tr,
                border: const OutlineInputBorder(),
              ),
              value: selectedCustomer,
              items: widget.customers
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(c.fullName ?? ""),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                setState(() => selectedCustomer = val);
              },
            ),

            const SizedBox(height: 12),

            /// Debt switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("debt".tr, style: textStyleBlack18Bold),
                Switch(
                  value: isDebt,
                  onChanged: (val) {
                    setState(() => isDebt = val);
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Totals & discounts
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _row("${"total".tr}:", widget.order.totalPrice!),
                _row("${"discount".tr}:", widget.order.discount!),
                if (widget.order.discount! > 0)
                  _row("${"discount_price".tr}:", widget.order.discountPrice!),
              ],
            ),

            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.payments_outlined),
                  border: const OutlineInputBorder(),
                  hint: Text("enter sum".tr)),
              onChanged: (value) {
                orderController.calculateReturnedMoney(value);
              },
            ),
            const SizedBox(height: 5),
            Obx(
              () => _row('return'.tr, orderController.returnedMoney.value),
            ),
            const SizedBox(height: 20),

            /// Confirm button
            DialogTextButton(
              onClick: () async {
                final navigator = Navigator.of(context);
                if (isDebt && selectedCustomer == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("please_select_customer".tr)),
                  );
                  return;
                }
                bool isSuccess = await payController.pay(widget.order,
                    customer: selectedCustomer,
                    isDebt: isDebt,
                    remainMoney: orderController.remainMoney.value);
                if (isSuccess) {
                  await orderController.closeOrder();
                  navigator.pop();
                }
              },
              textStyle: textStyleWhite20,
              text: "pay".tr,
            )
          ],
        ),
      ),
    );
  }

  Widget _row(String title, num value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: textStyleBlack18Bold),
        Text(
          PriceFormatter.formatPrice(value.toDouble()),
          style: textStyleBlack18Bold.copyWith(fontSize: 20),
        ),
      ],
    );
  }
}
