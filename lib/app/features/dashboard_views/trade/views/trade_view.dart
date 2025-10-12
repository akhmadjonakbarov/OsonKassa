import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/logic/order_controller.dart';

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
    fetchCtls();
    _initPrinter();

    super.initState();
  }

  fetchCtls() {
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
            _leftSide(constraints),
            _rightSide(constraints),
          ],
        );
      },
    );
  }

  Widget _leftSide(BoxConstraints constraints) {
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
                  label: const Text("Search"),
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
                    "No products found",
                    style: textStyleBlack18.copyWith(color: Colors.grey),
                  ),
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.2,
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
                              fontSize: 14,
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
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 65,
                  child: Obx(() {
                    final orders = orderController.orders;
                    final selected = orderController.selectedOrder.value;

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        final isSelected = order.id == selected?.id;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black87,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: orderController.createOrder,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: Colors.greenAccent,
                  fixedSize: const Size(50, 50),
                  elevation: 2,
                ),
                child: const Icon(Icons.add, size: 28, color: Colors.black87),
              )
            ],
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

          /// Items list
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

          /// Bottom totals + pay button
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
            padding: const EdgeInsets.all(18),
            width: double.infinity,
            child: Column(
              children: [
                TotalCalculate(constraints: constraints),
                const SizedBox(height: 18),
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
                          customers: customerCtl.customers.value,
                        ),
                      );
                    },
                    child: Text(
                      TranslatedTexts.buttons.pay.tr,
                      style: textStyleBlack28.copyWith(
                        fontSize: 22,
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
