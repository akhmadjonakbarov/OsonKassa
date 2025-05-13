import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/printer/pos_printer_manager.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/alert_texts.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../shared/export_commons.dart';
import '../../customer/logic/customer_ctl.dart';
import '../../customer/models/customer.dart';
import '../../note/logic/note_controller.dart';
import '../../store/logic/store_ctl.dart';
import '../../store/view/widgets/card_button.dart';
import '../logic/trade_ctl.dart';
import 'widgets/dialog_widgets/add_debt_form.dart';
import 'widgets/dialog_widgets/client_selector.dart';
import 'widgets/dialog_widgets/list_products_dialog.dart';
import 'widgets/dialog_widgets/show_debt_option.dart';
import 'widgets/list_product.dart';
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

  // TextEditingController
  TextEditingController barCodeController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  FocusNode addressFocusNode = FocusNode();
  late final PosPrinterManager _printer;
  Customer? selectedClient;
  bool is_first = true;
  bool is_debt = false;

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
  }

  @override
  void didChangeDependencies() {
    if (is_first) {
      FocusScope.of(context).requestFocus(addressFocusNode);
    }
    setState(() {
      is_first = false;
    });
    super.didChangeDependencies();
  }

  void _initPrinter() async {
    _printer = PosPrinterManager(printerIp: '192.168.123.100');
    await _printer.initPrinter();
  }

  sell() async {
    if (tradeCtl.sellProducts.isNotEmpty) {
      // await _printer.printSoldReceipt(
      //   tradeCtl.sellProductDocItems,
      // );
      if (is_debt && selectedClient != null) {
        await tradeCtl.sell(
          customer_id: selectedClient!.id,
          isDebt: true,
        );
      } else {
        if (selectedClient != null) {
          await tradeCtl.sell(
            customer_id: selectedClient!.id,
          );
        } else {
          await tradeCtl.sell();
        }
      }

      storeCtl.fetchItems();
      reset();
    } else {
      UserNotifier.showSnackBar(
        label: AlertTexts.no_product_selected,
        type: TypeOfSnackBar.alert,
      );
    }
  }

  reset() async {
    setState(() {
      selectedClient = null;
      is_debt = false;
    });
    storeCtl.clearList();
    noteCtl.fetchItems();

    tradeCtl.clearData();
  }

  showCustomers() {
    Get.dialog(
      ClientSelector(
        builderCtl: clientCtl,
        selectBuilder: (slC) {
          setState(() {
            selectedClient = slC;
          });
        },
      ),
    );
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
      width: constraints.maxWidth * 0.69,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: barCodeController,
                    focusNode: addressFocusNode,
                    onSubmitted: (value) {
                      storeCtl.searchByBarCode(value, isShowAlert: false);
                      barCodeController.clear();
                      FocusScope.of(context).requestFocus(addressFocusNode);
                    },
                    style: textStyleBlack18,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        CupertinoIcons.barcode,
                      ),
                      hintText: "BARCODE",
                      hintStyle: textStyleBlack18.copyWith(color: Colors.grey),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                IconButton(
                  icon: const Icon(CupertinoIcons.search),
                  onPressed: () => searchProductDialog(),
                )
              ],
            ),
          ),
          Obx(() {
            if (tradeCtl.sellProducts.isNotEmpty) {
              return ListSellProduct(
                tradeCtl: tradeCtl,
                constraints: constraints,
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          TotalCalculate(
            tradeCtl: tradeCtl,
            constraints: constraints,
          )
        ],
      ),
    );
  }

  Widget _rightSide(BoxConstraints constraints) {
    return CustomContainer(
      width: constraints.maxWidth * 0.30,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: GridView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
                children: [
                  CardButton(
                    label: ButtonTexts.for_debt,
                    onClick: () {
                      setState(() {
                        is_debt = true;
                      });
                      showCustomers();
                    },
                  ),
                  CardButton(
                    label: ButtonTexts.for_builder,
                    onClick: () {
                      showCustomers();
                    },
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            width: double.infinity,
            height: constraints.maxHeight * 0.08,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      color: Colors.red, // Background color
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                        onTap: () async {
                          await storeCtl.clearList();
                          await tradeCtl.clearData();
                          await reset();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.025,
                          ),
                          height: constraints.maxHeight,
                          alignment: Alignment.center, // To center the text
                          child: Text(
                            ButtonTexts.cancel,
                            style: textStyleBlack18.copyWith(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.green, // Background color
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                        onTap: () async {
                          await sell();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.025,
                          ),
                          height: constraints.maxHeight,
                          alignment: Alignment.center, // To center the text
                          child: Text(
                            ButtonTexts.pay,
                            style: textStyleBlack28.copyWith(
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
