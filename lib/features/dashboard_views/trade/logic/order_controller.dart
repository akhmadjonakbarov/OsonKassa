import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:osonkassa/features/dashboard_views/store/models/store_item.dart';
import 'package:osonkassa/features/dashboard_views/trade/models/order_item.dart';
import 'package:osonkassa/features/dashboard_views/trade/services/order_service.dart';
import 'package:osonkassa/features/shared/widgets/buttons.dart';

import '../../../../styles/text_styles.dart';
import '../../../../utils/helper/log_helper.dart';
import '../models/order.dart';

class OrderController extends GetxController {
  RxList<Order> orders = RxList<Order>([]);
  Rxn<Order> selectedOrder = Rxn(null);
  Rxn<OrderItem> selectedOrderItem = Rxn(null);

  RxDouble amount = RxDouble(0.0);
  RxDouble returnedMoney = RxDouble(0.0);
  RxDouble remainMoney = RxDouble(0.0);

  TextEditingController amountByPriceController = TextEditingController();

  @override
  onInit() {
    createOrder();
    super.onInit();
  }

  createOrder() {
    int orderId;
    bool exists;

    do {
      orderId = Random().nextInt(90) + 10;
      exists = orders.any((order) => order.id == orderId);
    } while (exists);

    if (orders.length < 5) {
      Order order = Order(
          createdAt: DateTime.now().toString(),
          id: orderId,
          items: [],
          discount: 0.0,
          totalPrice: 0.0,
          discountPrice: 0.0,
          customerId: -1,
          isDebt: false);
      orders.add(order);
      selectedOrder.value = order;
    }
  }

  selectOrder(Order order) {
    selectedOrder.value = order;
    selectedOrder.refresh;
    updateTotals();
  }

  selectOrderItem(OrderItem orderItem) {
    selectedOrderItem.value = orderItem;
  }

  calculateAmountByPrice() {
    if (selectedOrderItem.value != null) {
      amount.value = double.parse(amountByPriceController.text) /
          selectedOrderItem.value!.salePrice!;
    }
  }

  saveAmount() {
    if (selectedOrderItem.value != null) {
      selectedOrderItem.value = selectedOrderItem.value!.copyWith(
        qty: amount.value,
      );
    }

    final orderItem = selectedOrder.value!.items!.firstWhereOrNull(
      (element) {
        return element.barcode == selectedOrderItem.value!.barcode;
      },
    );
    if (orderItem != null) {
      int index = selectedOrder.value!.items!.indexOf(orderItem);
      selectedOrder.value!.items![index] = selectedOrderItem.value!;
    }
    selectedOrder.refresh();
    amount.value = 0.0;
    amountByPriceController.clear();

    updateTotals();
  }

  addProduct(StoreItem item) {
    List<OrderItem> orderItems = selectedOrder.value!.items!;
    int existOrderItemIndex = orderItems.indexWhere(
      (element) =>
          element.barcode!.contains(item.item!.barcode!) &&
          element.itemType == item.itemType,
    );

    if (existOrderItemIndex > -1) {
      OrderItem existedOrderItem = orderItems[existOrderItemIndex];
      existedOrderItem =
          existedOrderItem.copyWith(qty: existedOrderItem.qty! + 1);
      orderItems[existOrderItemIndex] = existedOrderItem;
    } else {
      OrderItem orderItem = OrderItem(
          itemType: item.itemType,
          id: DateTime.now().millisecondsSinceEpoch % 100,
          name: item.item!.name,
          barcode: item.item!.barcode,
          unit: item.item!.unit,
          itemId: item.item!.id,
          qty: 1,
          incomePrice: item.item!.currencyType == 'usd'
              ? item.incomePrice! * item.currencyRateValue!
              : item.incomePrice!,
          salePrice: item.item!.currencyType == 'usd'
              ? item.salePrice! * item.currencyRateValue!
              : item.salePrice!);

      orderItems.insert(0, orderItem);
    }
    selectedOrder.value = selectedOrder.value!.copyWith(items: orderItems);
    updateTotals();
  }

  removeOrderItem(OrderItem orderItem) {
    final updatedItems = selectedOrder.value!.items!
      ..removeWhere(
        (element) =>
            element.barcode == orderItem.barcode &&
            element.itemType == orderItem.itemType,
      );

    if (updatedItems.isEmpty) {
      reOrder();
    } else {
      selectedOrder.value = selectedOrder.value!.copyWith(items: updatedItems);
    }
    updateTotals();
  }

  void reOrder() {
    orders.removeWhere(
      (element) => element.id == selectedOrder.value!.id,
    );
    orders.refresh();

    if (orders.isEmpty) {
      createOrder();
    } else {
      selectedOrder.value = orders.first;
    }
  }

  void editProduct(BuildContext context, OrderItem orderItem) {
    List<OrderItem> orderItems = selectedOrder.value!.items!;

    final TextEditingController qtyController = TextEditingController(
      text: orderItem.qty!.toStringAsFixed(3),
    );

    final FocusNode focusNode = FocusNode();

    void updateItem() {
      int index =
          orderItems.indexWhere((item) => item.barcode == orderItem.barcode);
      if (index != -1) {
        orderItems[index] = orderItems[index].copyWith(
          qty: double.tryParse(qtyController.text.trim()) ?? 0.0,
        );
      }
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: 250,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            orderItem.name ?? "Mahsulot",
                            style: textStyleBlack20.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.close, color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Barcode & price info
                    if (orderItem.barcode != null)
                      Row(
                        children: [
                          const Icon(Icons.qr_code,
                              size: 20, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            orderItem.barcode!,
                            style: textStyleBlack14.copyWith(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 16),

                    // Qty input
                    Focus(
                      focusNode: focusNode,
                      onKey: (node, event) {
                        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                          updateItem();
                          Get.back();
                          return KeyEventResult.handled;
                        }
                        return KeyEventResult.ignored;
                      },
                      child: TextField(
                        controller: qtyController,
                        style: textStyleBlack20,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText: "Miqdori (${orderItem.unit ?? ''})",
                          labelStyle: textStyleBlack18,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon:
                              const Icon(Icons.edit, color: Colors.blueAccent),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          child: const Text("Bekor qilish"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            updateItem();
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: const Text(
                            "Saqlash",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ).then(
      (_) => updateTotals(),
    );
  }

  updateTotals() {
    double? discountPrice = 0.0;
    if (selectedOrder.value!.items!.isNotEmpty) {
      double totalPrice = selectedOrder.value!.items!.fold(
          0.0,
          (previousValue, element) =>
              previousValue + element.qty! * element.salePrice!);
      if (selectedOrder.value!.discount! > 0.0) {
        discountPrice = totalPrice - selectedOrder.value!.discount!;

        selectedOrder.value =
            selectedOrder.value!.copyWith(discountPrice: discountPrice);
      }
      selectedOrder.value =
          selectedOrder.value!.copyWith(totalPrice: totalPrice);
      remainMoney.value = selectedOrder.value!.totalPrice!;
    }
  }

  void editTotalDiscount() {
    double discountPrice = 0.0;
    double totalPrice = selectedOrder.value!.totalPrice!;

    final TextEditingController discountController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "discount".tr,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: discountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: "enter discount".tr,
                  border: const OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  final input = discountController.text;
                  final discountValue = double.tryParse(input);
                  if (discountValue != null && discountValue >= 0) {
                    discountPrice = totalPrice - discountValue;

                    selectedOrder.value = selectedOrder.value!.copyWith(
                      discount: discountValue,
                      discountPrice: discountPrice,
                    );
                    Get.back();
                  } else {
                    Get.snackbar(
                      "Invalid input",
                      "Please enter a valid discount amount.",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DialogTextButton(
                    isNegative: true,
                    textStyle: textStyleWhite18,
                    text: "cancel".tr,
                    onClick: () => Get.back(),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  DialogTextButton(
                    textStyle: textStyleWhite18,
                    text: "save".tr,
                    onClick: () {
                      final input = discountController.text;
                      final discountValue = double.tryParse(input);
                      if (discountValue != null && discountValue >= 0) {
                        discountPrice = totalPrice - discountValue;

                        selectedOrder.value = selectedOrder.value!.copyWith(
                          discount: discountValue,
                          discountPrice: discountPrice,
                        );
                        Get.back();
                      } else {
                        Get.snackbar(
                          "Invalid input",
                          "Please enter a valid discount amount.",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ).then(
      (value) {
        updateOrder();
      },
    );
  }

  Future<void> closeOrder() async {
    OrderService.removeOrder(orders, selectedOrder.value!);
    reOrder();
  }

  updateOrder() {
    if (orders.length == 1) {
      orders.first = selectedOrder.value!;
    } else {
      Order order = orders.firstWhere(
        (element) => element.id == selectedOrder.value!.id,
      );
      int indexOfOrder = orders.indexOf(order);

      orders[indexOfOrder] = selectedOrder.value!;
    }
  }

  calculateReturnedMoney(String value) {
    try {
      returnedMoney.value =
          double.parse(value) - selectedOrder.value!.totalPrice!;

      remainMoney.value =
          selectedOrder.value!.totalPrice! - double.parse(value);
    } catch (e) {
      LogHelper.logError(e.toString());
    }
  }
}
