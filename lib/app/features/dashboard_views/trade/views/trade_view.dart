import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/logic/order_controller.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/views/widgets/order_item_list.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/views/widgets/product_search_bar.dart';

import 'package:osonkassa/design_system/themes/responsive_font_size.dart';
import 'package:osonkassa/design_system/themes/text_styles.dart';
import '../../../../core/printer/pos_printer_manager.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../customer/logic/customer_ctl.dart';
import '../../customer/domain/models/customer.dart';
import '../../note/logic/note_controller.dart';
import '../../store/logic/store_ctl.dart';
import '../logic/trade_ctl.dart';
import 'widgets/dialog_widgets/list_products_dialog.dart';

import 'widgets/dialog_widgets/payment_dialog.dart';

import 'widgets/total_calculator.dart';

class TradeView extends StatefulWidget {
  const TradeView({super.key});

  @override
  _TradeViewState createState() => _TradeViewState();
}

class _TradeViewState extends State<TradeView> {
  final TradeCtl tradeCtl = Get.find<TradeCtl>();
  final CustomerCtl clientCtl = Get.find<CustomerCtl>();
  final StoreCtl storeCtl = Get.find<StoreCtl>();
  final NoteCtl noteCtl = Get.find<NoteCtl>();
  final CustomerCtl customerCtl = Get.find<CustomerCtl>();
  final OrderController orderController = Get.find<OrderController>();

  TextEditingController barCodeController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  FocusNode addressFocusNode = FocusNode();
  late final PosPrinterManager _printer;

  @override
  void initState() {
    _initPrinter();
    fetch();
    super.initState();
  }

  fetch() {
    clientCtl.fetchItems();
    storeCtl.fetchProductInStore();
    noteCtl.fetchItems();
    customerCtl.fetchItems();
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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  child: ProductSearchBar(
                    barCodeController: barCodeController,
                    addressFocusNode: addressFocusNode,
                    storeCtl: storeCtl,
                    searchProductDialog: searchProductDialog,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => fetch(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  elevation: 3,
                ),
                child: const Icon(CupertinoIcons.refresh_bold, size: 20),
              )
            ],
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
                  childAspectRatio: screenSize.width <= 1370 ? 1.8 : 2.2,
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
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${product.item!.name!}${product.itemType != null ? ' (${product.itemType})' : ''}",
                            style: textStyleBlack20.copyWith(
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Text(
                              "📦 ${product.item!.barcode!}",
                              style: context.labelSmall.copyWith(
                                  fontSize: context.rfs(13, min: 11, max: 15)),
                              textAlign: TextAlign.center,
                            ),
                          )
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
          Container(
            height: 45,
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

                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => orderController.selectOrder(order),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.grey[200],
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (isSelected)
                            const BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "N${order.id}",
                          style: context.labelSmall.copyWith(
                            fontSize: context.rfs(15, min: 13, max: 18),
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
            backgroundColor: Colors.green,
            onPressed: orderController.createOrder,
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

          OrderItemList(constraints: constraints),

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
                  width: 250,
                  child: PrimaryButton(
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
                      'pay'.tr,
                      style: context.bodyMedium.copyWith(
                          fontSize: context.rfs(
                            14,
                            min: 12,
                            max: 18,
                          ),
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
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
