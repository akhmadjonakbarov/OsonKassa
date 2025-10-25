import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/logic/order_controller.dart';
import 'package:osonkassa/app/styles/app_colors.dart';
import 'package:osonkassa/design_system/buttons/primary_button.dart';
import 'package:osonkassa/design_system/themes/text_styles.dart';

import '../../../../core/printer/pos_printer_manager.dart';
import '../../../../styles/text_styles.dart';
import '../../../../translation/translated_texts.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../shared/export_commons.dart';
import '../../customer/logic/customer_ctl.dart';
import '../../customer/models/customer.dart';
import '../../note/logic/note_controller.dart';
import '../../store/logic/store_ctl.dart';
import '../logic/trade_ctl.dart';
import 'widgets/dialog_widgets/list_products_dialog.dart';

import 'widgets/dialog_widgets/payment_dialog.dart';
import 'widgets/sell_trade_item.dart';
import 'widgets/total_calculator.dart';

class TradeView extends StatefulWidget {
  const TradeView({super.key});

  @override
  _TradeViewState createState() => _TradeViewState();
}

class _TradeViewState extends State<TradeView> {
  // Controllers
  final TradeCtl tradeCtl = Get.find<TradeCtl>();
  final CustomerCtl clientCtl = Get.find<CustomerCtl>();
  final StoreCtl storeCtl = Get.find<StoreCtl>();
  final NoteCtl noteCtl = Get.find<NoteCtl>();
  final CustomerCtl customerCtl = Get.find<CustomerCtl>();
  final OrderController orderController = Get.find<OrderController>();

  // TextEditingController
  TextEditingController barCodeController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  FocusNode addressFocusNode = FocusNode();
  late final PosPrinterManager _printer;

  @override
  void initState() {
    fetch();
    _initPrinter();

    super.initState();
  }

  fetch() {
    clientCtl.fetchItems();
    storeCtl.fetchProductInStore();
    noteCtl.fetchItems();
    customerCtl.fetchItems();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _initPrinter() async {
    _printer = PosPrinterManager(printerIp: '192.168.123.100');
    await _printer.initPrinter();
  }

  reset() async {
    storeCtl.clearList();
    noteCtl.fetchItems();

    tradeCtl.clearData();
  }

  void searchProductDialog() {
    final screenSize = getScreenSize(context);
    Get.dialog(
      ListProductsDialog(
        screenSize: screenSize,
        searchController: searchController,
        storeCtl: storeCtl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _leftSide(constraints, context),
            _rightSide(constraints),
          ],
        );
      },
    );
  }

  Widget _leftSide(BoxConstraints constraints, BuildContext context) {
    final screenSize = getScreenSize(context);
    return CustomContainer(
      width: constraints.maxWidth * 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: barCodeController,
                    focusNode: addressFocusNode,
                    onChanged: (value) =>
                        storeCtl.searchProduct(value, inStore: true),
                    onSubmitted: (value) {
                      storeCtl.searchProduct(value);
                      barCodeController.clear();
                      FocusScope.of(context).requestFocus(addressFocusNode);
                    },
                    style: textStyleBlack18,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        CupertinoIcons.barcode,
                        color: Colors.blueAccent,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(CupertinoIcons.clear_thick_circled,
                            color: Colors.grey),
                        onPressed: () {
                          barCodeController.clear();
                          storeCtl.searchProduct("");
                        },
                      ),
                      hintText: "Scan or Enter Barcode...",
                      hintStyle: textStyleBlack18.copyWith(
                          color: Colors.grey.shade500),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => searchProductDialog(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    elevation: 3,
                  ),
                  icon: const Icon(CupertinoIcons.search, size: 20),
                  label: Text("search".tr),
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// Products Grid
          Expanded(
            child: Obx(() {
              if (storeCtl.productsInStore.isEmpty) {
                return Center(
                  child: Text(
                    "no products found".tr,
                    style: textStyleBlack18.copyWith(color: Colors.grey),
                  ),
                );
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: screenSize.width <= 1370 ? 1.5 : 2.2,
                ),
                itemCount: storeCtl.productsInStore.length,
                itemBuilder: (context, index) {
                  final product = storeCtl.productsInStore[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => orderController.addProduct(product),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blueAccent.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.item!.name!,
                            style: textStyleBlack20.copyWith(
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "📦 ${product.item!.barcode!}",
                            style: textStyleBlack18.copyWith(
                              color: Colors.grey.shade700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _rightSide(BoxConstraints constraints) {
    return CustomContainer(
      padding: const EdgeInsets.all(16),
      width: constraints.maxWidth * 0.33,
      child: Column(
        children: [
          SizedBox(
            height: 65,
            child: Obx(() {
              final orders = orderController.orders;
              final selected = orderController.selectedOrder.value;

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final isSelected = order.id == selected?.id;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        if (isSelected)
                          const BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => orderController.selectOrder(order),
                      child: Center(
                        child: Text(
                          "№${order.id}",
                          style: textStyleBlack20.copyWith(
                            fontSize: 20,
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            width: double.infinity,
            height: 35,
            backgroundColor: Colors.green,
            onClick: orderController.createOrder,
            child: const Icon(Icons.add, size: 28, color: Colors.white),
          ),
          const SizedBox(height: 20),

          /// Header Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nom",
                    style:
                        textStyleBlack18.copyWith(fontWeight: FontWeight.w600)),
                Text("Son",
                    style:
                        textStyleBlack18.copyWith(fontWeight: FontWeight.w600)),
                Text("Narx",
                    style:
                        textStyleBlack18.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(width: 30),
              ],
            ),
          ),

          const SizedBox(height: 6),

          Obx(() {
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
                  child:
                      Text("Buyurtmalar mavjud emas", style: textStyleBlack18),
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
                      onEdit: () =>
                          orderController.editProduct(context, orderItem),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.orange.shade200),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                                Icons.inventory_2_outlined,
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
                                                          color: Colors
                                                              .orange.shade800,
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                            color:
                                                                Colors.black87,
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
                                        controller: orderController
                                            .amountByPriceController,
                                        autofocus: true,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        textInputAction: TextInputAction.done,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9,.]')),
                                        ],
                                        onChanged: (v) {
                                          orderController
                                              .calculateAmountByPrice();
                                        },
                                        onSubmitted: (_) {},
                                        decoration: InputDecoration(
                                          labelText: 'price'.tr,
                                          hintText: '12000',
                                          border: const OutlineInputBorder(),
                                          prefixIcon: const Icon(
                                              Icons.payments_outlined),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                                      color:
                                                          Colors.green.shade800,
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
                                                      color:
                                                          Colors.green.shade800,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                      deleteItem: () =>
                          orderController.removeOrderItem(orderItem),
                      product: orderItem,
                      height: constraints.maxHeight * 0.1,
                    );
                  },
                ),
              ),
            );
          }),

          const SizedBox(height: 16),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              children: [
                TotalCalculate(constraints: constraints),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 4,
                    ),
                    onPressed: () async {
                      await showDialog<Customer>(
                        context: context,
                        builder: (_) => PaymentDialog(
                          order: orderController.selectedOrder.value!,
                          customers: customerCtl.customers,
                        ),
                      );
                    },
                    child: Text(
                      TranslatedTexts.buttons.pay.tr,
                      style: textStyleBlack28.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
