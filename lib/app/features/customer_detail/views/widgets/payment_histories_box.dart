import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/customer_detail/models/payment_history.dart';
import 'package:osonkassa/app/features/shared/widgets/center_text.dart';
import 'package:osonkassa/app/features/shared/widgets/custom_data_table.dart';
import 'package:osonkassa/app/styles/text_styles.dart';
import 'package:osonkassa/app/translation/translated_texts.dart';
import 'package:osonkassa/app/utils/formatter_functions/formatter_currency.dart';
import 'package:osonkassa/app/utils/formatter_functions/formatter_date.dart';

import '../../../dashboard_views/customer/domain/models/customer.dart';
import '../../../shared/widgets/grid_box.dart';
import '../../../shared/widgets/loading.dart';
import '../../../shared/widgets/no_data.dart';
import '../../logic/customer_detail_ctl.dart';

class PaymentHistoriesBox extends StatelessWidget {
  const PaymentHistoriesBox({
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
          if (customerDetailCtl.isPaymentHistoriesLoading.value) {
            return const Loading(hasPadding: false);
          } else {
            if (customerDetailCtl.paymentHistories.isNotEmpty) {
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
              'payment'.tr,
              'note'.tr,
              TranslatedTexts.table.date.tr,
            ], // Your columns here
            rows: customerDetailCtl.paymentHistories
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

  DataRow buildDebtRow(int index, PaymentHistory history) {
    return DataRow(
      cells: [
        DataCell(CenterText(text: "${index + 1}")),
        DataCell(
          CenterText(
            text: formatPriceAtUZS(history.amount!),
          ),
        ),
        DataCell(
          CenterText(
            text: history.note!,
          ),
        ),
        DataCell(CenterText(
          text: formatDateToUzbek(history.createdAt.toString()),
        )),
      ],
    );
  }
}
