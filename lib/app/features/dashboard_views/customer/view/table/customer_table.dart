import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/styles/text_styles.dart';
import 'package:osonkassa/app/utils/formatter_functions/formatter_currency.dart';

import '../../../../../config/app_paths.dart';
import '../../../../../translation/translated_texts.dart';
import '../../../../../utils/formatter_functions/format_phone_number.dart';
import '../../../../../utils/texts/display_texts.dart';
import '../../../../customer_detail/logic/customer_detail_ctl.dart';
import '../../../../shared/export_commons.dart';
import '../../../../shared/widgets/delete_dialog.dart';
import '../../logic/customer_ctl.dart';
import '../../models/customer.dart';
import '../widgets/customer_edit_dialog.dart';

class CustomerTable extends StatefulWidget {
  final CustomerCtl controller;

  const CustomerTable({super.key, required this.controller});

  @override
  State<CustomerTable> createState() => _CustomerTableState();
}

class _CustomerTableState extends State<CustomerTable> {
  CustomerDetailCtl customerDetailCtl = Get.find<CustomerDetailCtl>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BasicContainer(
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(),
        child: CustomDataTable(
          columns: [
            TranslatedTexts.table.index.tr,
            TranslatedTexts.table.name.tr,
            TranslatedTexts.table.phoneNumber.tr,
            TranslatedTexts.table.phoneNumber2.tr,
            TranslatedTexts.table.address.tr,
            TranslatedTexts.table.debt.tr,
            TranslatedTexts.table.buttons.tr
          ],
          rows: widget.controller.customers.asMap().entries.map((entry) {
            int index = entry.key;
            Customer customer = entry.value;
            return DataRow(
              onSelectChanged: (_) {
                Get.toNamed(
                  AppPaths.clientDetail,
                  arguments: customer,
                );
              },
              cells: <DataCell>[
                DataCell(CenterText(text: "${index + 1}")),
                DataCell(CenterText(text: customer.fullName!)),
                DataCell(
                    CenterText(text: formatPhoneNumber(customer.phoneNumber!))),
                DataCell(CenterText(
                    text: customer.phoneNumber2 != null &&
                            customer.phoneNumber2!.isNotEmpty
                        ? formatPhoneNumber(customer.phoneNumber2!)
                        : DisplayTexts.no_extra_number)),
                DataCell(CenterText(text: customer.address ?? "-")),
                DataCell(CenterText(
                  text: PriceFormatter.formatPrice(customer.debtCost!),
                  style: textStyleBlack18Bold,
                )),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          widget.controller.selectCustomer(customer);
                          Get.dialog(CustomerEditDialog());
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => DeleteDialog(
                            title: customer.fullName!,
                            onConfirmDelete: () =>
                                widget.controller.removeItem(customer.id!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
