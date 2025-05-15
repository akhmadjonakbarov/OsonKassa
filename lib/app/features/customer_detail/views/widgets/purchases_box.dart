import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/customer_detail/views/widgets/purchase_item_dialog.dart';
import 'package:osonkassa/app/translation/translated_texts.dart';

import '../../../../styles/text_styles.dart';
import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/formatter_functions/formatter_date.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/table_texts.dart';
import '../../../dashboard_views/customer/models/customer.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/grid_box.dart';
import '../../logic/customer_detail_ctl.dart';
import '../../models/purchase.dart';

class PurchasesBox extends StatelessWidget {
  const PurchasesBox({
    super.key,
    required this.customerDetailCtl,
    required this.customer,
  });

  final CustomerDetailCtl customerDetailCtl;
  final Customer? customer;

  @override
  Widget build(BuildContext context) {
    return GridBox(
      child: Obx(
        () {
          // observe isLoading and list directly within Obx
          if (customerDetailCtl.isLoadingPurchases.value) {
            return const Loading(hasPadding: false);
          } else {
            if (customerDetailCtl.purchases.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: buildDebtList(),
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

  Widget buildDebtList() {
    return ListView(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(
            TranslatedTexts.sale.sales.tr,
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
            ], // Your columns here
            rows: customerDetailCtl.purchases
                .asMap()
                .entries
                .map(
                  (e) => buildDebtRow(e.key, e.value),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  DataRow buildDebtRow(int index, Purchase purchase) {
    return DataRow(
      onSelectChanged: (value) {
        Get.dialog(PurchaseItemDialog(purchase: purchase));
      },
      cells: [
        DataCell(CenterText(text: "${index + 1}")),
        DataCell(CenterText(
          text: formatDateToUzbek(purchase.createdAt.toString()),
        )),
        DataCell(
          CenterText(
            text: formatPriceAtUZS(purchase.products!
                .fold(
                  0.0,
                  (previousValue, element) => previousValue =
                      previousValue + element.sellingPrice! * element.qty!,
                )
                .toDouble()),
          ),
        ),
      ],
    );
  }
}
