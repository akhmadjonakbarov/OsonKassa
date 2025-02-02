import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../styles/text_styles.dart';
import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/formatter_functions/formatter_date.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/table_texts.dart';
import '../../../dashboard_views/customer/models/client_model.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/grid_box.dart';
import '../../logic/ctl/client_debt_ctl.dart';
import '../../models/client_debt_model.dart';

class DebtsBox extends StatelessWidget {
  const DebtsBox({
    super.key,
    required this.clientDebtCtl,
    required this.client,
  });

  final ClientDebtCtl clientDebtCtl;
  final CustomerModel? client;

  @override
  Widget build(BuildContext context) {
    return GridBox(
      child: Obx(
        () {
          // observe isLoading and list directly within Obx
          if (clientDebtCtl.isLoading.value) {
            return const Loading(hasPadding: false);
          } else {
            if (clientDebtCtl.list.isNotEmpty) {
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
            "Qarzlar",
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
            columns: const [
              TableTexts.index,
              TableTexts.date,
              TableTexts.total_amount_price,
              TableTexts.buttons
            ], // Your columns here
            rows: clientDebtCtl.list
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

  DataRow buildDebtRow(int index, ClientDebtModel clientDebt) {
    return DataRow(
      cells: [
        DataCell(CenterText(text: "${index + 1}")),
        DataCell(CenterText(
          text: formatDateToUzbek(clientDebt.document.created_at.toString()),
        )),
        DataCell(CenterText(
          text: formatPriceAtUZS(clientDebt.amount),
        )),
        DataCell(
          Center(
            child: DialogTextButton(
              text: ButtonTexts.pay,
              onClick: () {
                clientDebtCtl.pay(clientDebt.id, client!.id);
              },
              textStyle: textStyleBlack18,
            ),
          ),
        ),
      ],
    );
  }
}
