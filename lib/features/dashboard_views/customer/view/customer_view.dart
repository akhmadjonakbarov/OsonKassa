// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/features/dashboard_views/customer/view/controllers/transaction_controller.dart';
import 'package:osonkassa/styles/app_colors.dart';
import 'package:osonkassa/design_system/buttons/primary_button.dart';
import 'package:osonkassa/design_system/themes/text_styles.dart';

import '../../../../core/enums/filter_field.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/helper/button_size_manager.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';

import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../customer_detail/logic/customer_detail_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/content_view.dart';

import 'controllers/customer_controller/customer_controller.dart';
import 'table/customer_table.dart';
import 'widgets/customer_edit_dialog.dart';
import 'widgets/customer_statistics.dart';

class CustomerView extends StatefulWidget {
  final CustomerCtl customerCtl;
  final AuthCtl authCtl;

  const CustomerView({
    super.key,
    required this.customerCtl,
    required this.authCtl,
  });

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  final GlobalKey _sortButtonKey = GlobalKey();
  late CustomerDetailCtl customerDetailCtl;
  TransactionController transactionController =
      Get.find<TransactionController>();

  final TextEditingController transactionEditingController =
      TextEditingController();
  final payDebtFormKey = GlobalKey<FormState>();
  String? selectedCustomer;
  int? selectedCustomerId;

  @override
  void didChangeDependencies() {
    customerDetailCtl = Get.find<CustomerDetailCtl>();
    customerDetailCtl.calculateTotalDebtsPrice(context);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    widget.customerCtl.fetchItems();
  }

  void _showPopupMenu(BuildContext context) async {
    final RenderBox button =
        _sortButtonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
        button.localToGlobal(Offset.zero) & button.size,
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem<String>(
          value: FilterField.name.name,
          child: const Text(ButtonTexts.sort_by_name),
        ),
        // PopupMenuItem<String>(
        //   value: FilterField.created_at.name,
        //   child: const Text(ButtonTexts.sort_by_adding_time),
        // ),
      ],
    );
    // if (selected != null) {
    //   if (selected == FilterField.created_at.name) {
    //     widget.customerCtl.sortByCreatedAt();
    //   } else if (selected == FilterField.name.name) {
    //     widget.customerCtl.sortByName();
    //   }
    // }
  }

  void _payDebt() {
    final isValid = payDebtFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    double amount = double.tryParse(transactionEditingController.text) ?? 0;
    // print("Money: $amount");
    // print("Customer ID: $selectedCustomerId");
    if (selectedCustomerId != null) {
      transactionController.payDebt(transactionData: {
        "customer_id": selectedCustomerId,
        "amount": amount,
      });
    }
  }

  void _payTransaction() {
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                // FIX 1: Add ScrollView to prevent keyboard/content overflow
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: payDebtFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("pay debt".tr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 15,
                        ),

                        // FIX 2: Explicitly set width to fill the dialog
                        DropdownMenu(
                          width: MediaQuery.of(context).size.width > 400
                              ? 360
                              : MediaQuery.of(context).size.width * 0.7,
                          label: Text('select customer'.tr),
                          onSelected: (value) =>
                              setDialogState(() => selectedCustomerId = value),
                          dropdownMenuEntries:
                              widget.customerCtl.customers.map((customer) {
                            return DropdownMenuEntry(
                              value: customer.id!,
                              label: customer.fullName!,
                              // FIX 3: Prevent long text overflow inside the menu
                              labelWidget: Text(
                                customer.fullName!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: transactionEditingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "enter amount of money".tr,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter amount of money".tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: Text("cancel".tr)),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: () {
                                  _payDebt();
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("pay".tr)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return ContentView(
      onChangePage: (p0) {
        widget.customerCtl.selectPage(p0);
      },
      title: 'customers'.tr,
      pagination: widget.customerCtl.pagination,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // IconButton(
                //   key: _sortButtonKey, // Assign the key to the button
                //   onPressed: () => _showPopupMenu(context),
                //   icon: const Icon(
                //     Icons.sort_sharp,
                //     color: Colors.black,
                //   ), variance: null,
                // ),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                SizedBox(
                  width: screenSize.width * 0.15,
                  child: SearchTextField(
                    hintText: "search".tr,
                    onChanged: (value) =>
                        widget.customerCtl.searchBuilder(value),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
              ],
            ),
            Row(
              children: [
                PButton(
                  height: ButtonSizeManager.height(context, height: 0.1 / 2.5),
                  width: ButtonSizeManager.width(context, width: 0.1 / 1.1),
                  backgroundColor: ButtonColors.primary,
                  onClick: _payTransaction,
                  child: Text(
                    "payment".tr,
                    style: context.titleMedium.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CheckedAddButton(
                  onClick: () {
                    Get.dialog(const CustomerEditDialog());
                  },
                  permission: "create_customer",
                  roles: widget.authCtl.userModel.value.roles,
                )
              ],
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 256),
          height: screenSize.height * 0.13,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Statistics",
                style: textStyleBlack20.copyWith(fontSize: 25),
              ),
              CustomerStatistics(
                  screenSize: screenSize,
                  widget: widget,
                  customerDetailCtl: customerDetailCtl),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomerTable(
          controller: widget.customerCtl,
        ),
      ],
    );
  }
}
