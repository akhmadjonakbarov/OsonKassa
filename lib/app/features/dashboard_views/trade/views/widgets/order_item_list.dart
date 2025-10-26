import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/logic/order_controller.dart';

import '../../../../../styles/text_styles.dart';
import 'sell_trade_item.dart';

class OrderItemList extends StatelessWidget {
  OrderItemList({super.key, required this.constraints});
  final BoxConstraints constraints;

  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedOrder = orderController.selectedOrder.value;

      if (selectedOrder == null) {
        return Expanded(
          child: Center(
            child: Text("Buyurtma tanlanmagan", style: textStyleBlack20),
          ),
        );
      }

      if (selectedOrder.items?.isEmpty ?? true) {
        return Expanded(
          child: Center(
            child: Text("Buyurtmalar mavjud emas", style: textStyleBlack18),
          ),
        );
      }

      return Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: selectedOrder.items!.length,
            separatorBuilder: (_, __) =>
                Divider(color: Colors.grey.shade200, height: 1),
            itemBuilder: (context, index) {
              final orderItem = selectedOrder.items![index];
              return SellProductItem(
                onEdit: () => orderController.editProduct(context, orderItem),
                cheapenClick: () {},
                decrementQty: () {},
                incrementQty: () {},
                calculateAmountByPrice: () {
                  orderController.selectOrderItem(orderItem);
                  if (orderController.selectedOrderItem.value == null) {
                    return;
                  }
                  Get.dialog(Dialog(
                    insetPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 24),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxWidth: 420, minHeight: 280),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Title + Close
                                Row(
                                  children: [
                                    const Icon(Icons.calculate_outlined,
                                        color: Colors.blue),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Miqdorini hisoblash',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                    IconButton(
                                      tooltip: 'cancel'.tr,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),
                                // >>> ADD THIS BLOCK — Product name pill
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.orange.shade200),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.inventory_2_outlined,
                                          color: Colors.orange),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Mahsulot',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                    color:
                                                        Colors.orange.shade800,
                                                  ),
                                            ),
                                            const SizedBox(height: 2),
                                            // Use whatever field you already have on the controller:
                                            // e.g., orderController.selectedProductName / product?.name / productName
                                            Tooltip(
                                              message: orderController
                                                      .selectedOrderItem
                                                      .value!
                                                      .name ??
                                                  '—',
                                              child: Text(
                                                orderController
                                                        .selectedOrderItem
                                                        .value!
                                                        .name ??
                                                    '—',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 14),

                                // Price input (no Form)
                                TextField(
                                  controller:
                                      orderController.amountByPriceController,
                                  autofocus: true,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9,.]')),
                                  ],
                                  onChanged: (v) {
                                    orderController.calculateAmountByPrice();
                                  },
                                  onSubmitted: (_) {},
                                  decoration: InputDecoration(
                                    labelText: 'price'.tr,
                                    hintText: '12000',
                                    border: const OutlineInputBorder(),
                                    prefixIcon:
                                        const Icon(Icons.payments_outlined),
                                    suffix: const Text("UZS"),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                // Total preview
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.green.shade200),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.summarize_outlined,
                                          color: Colors.green),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Jami (narx × miqdor)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                color: Colors.green.shade800,
                                              ),
                                        ),
                                      ),
                                      Obx(
                                        () => Text(
                                          "${orderController.amount.value.toStringAsFixed(2)} ${orderController.selectedOrderItem.value!.unit}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: Colors.green.shade800,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 16),
                                const Divider(height: 1),
                                const SizedBox(height: 12),

                                // Actions (Colors only)
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          minimumSize:
                                              const Size.fromHeight(45),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('cancel'.tr),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(Icons.check),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                          minimumSize:
                                              const Size.fromHeight(45),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {
                                          orderController.saveAmount();
                                          Navigator.of(context).pop();
                                        },
                                        label: Text('save'.tr),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ));
                },
                deleteItem: () => orderController.removeOrderItem(orderItem),
                product: orderItem,
                height: constraints.maxHeight * 0.1,
              );
            },
          ),
        ),
      );
    });
  }
}
