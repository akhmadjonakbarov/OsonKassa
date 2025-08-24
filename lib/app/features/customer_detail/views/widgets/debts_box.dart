import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/customer_detail/views/widgets/purchase_item_dialog.dart';
import 'package:osonkassa/app/translation/translated_texts.dart';

import '../../../../styles/text_styles.dart';
import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/formatter_functions/formatter_date.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../dashboard_views/customer/models/customer.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/grid_box.dart';
import '../../logic/customer_detail_ctl.dart';
import '../../models/purchase.dart';

class DebtsBox extends StatelessWidget {
  const DebtsBox({
    super.key,
    required this.customerDetailCtl,
    required this.client,
  });

  final CustomerDetailCtl customerDetailCtl;
  final Customer? client;

  @override
  Widget build(BuildContext context) {
    return GridBox(
      child: Obx(
        () {
          // observe isLoading and list directly within Obx
          if (customerDetailCtl.isLoadingDebts.value) {
            return const Loading(hasPadding: false);
          } else {
            if (customerDetailCtl.debts.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: buildDebtList(context),
              );
            } else {
              return const NoData(
                hasPadding: false,
              );
            }
          }
        },
      ),
    );
  }

  Widget buildDebtList(BuildContext context) {
    return ListView(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(
            TranslatedTexts.debt.debts.tr,
            style: textStyleBlack28.copyWith(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: double.infinity,
          child: CustomDataTable(
            columns: [
              TranslatedTexts.table.index.tr,
              TranslatedTexts.table.date.tr,
              'total_price'.tr,
              'discount'.tr,
              TranslatedTexts.table.buttons.tr
            ], // Your columns here
            rows: customerDetailCtl.debts
                .asMap()
                .entries
                .map(
                  (e) => buildDebtRow(context, e.key, e.value),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  DataRow buildDebtRow(BuildContext context, int index, Purchase purchase) {
    return DataRow(
      onSelectChanged: (value) {
        Get.dialog(PurchaseItemDialog(purchase: purchase));
      },
      cells: [
        DataCell(CenterText(text: "${index + 1}")),
        DataCell(CenterText(
          text: formatDateToUzbek(purchase.createdAt.toString()),
        )),
        DataCell(CenterText(
          text: formatPriceAtUZS(purchase.products!
              .fold(
                0.0,
                (previousValue, element) => previousValue =
                    previousValue + (element.salePrice! * element.qty!),
              )
              .toDouble()),
        )),
        DataCell(CenterText(
          text: formatPriceAtUZS(purchase.discount ?? 0.0),
        )),
        DataCell(
          Center(
            child: DialogTextButton(
              text: ButtonTexts.pay,
              onClick: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(TranslatedTexts.payment.confirmPayment.tr),
                    content: Text(TranslatedTexts.payment.areYouSureToPay.tr),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        // Cancel
                        child: Text(TranslatedTexts.buttons.cancel.tr),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                          customerDetailCtl.pay(
                            context,
                            customerId: client!.id!,
                            purchaseId: purchase.id!,
                          );
                        },
                        child: Text(TranslatedTexts.buttons.confirm.tr),
                      ),
                    ],
                  ),
                );
              },
              textStyle: textStyleBlack18,
            ),
          ),
        ),
      ],
    );
  }
}
