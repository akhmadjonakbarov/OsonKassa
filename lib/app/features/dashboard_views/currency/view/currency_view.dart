import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/content_view.dart';
import '../logic/currency_controller.dart';
import 'table/currency_table.dart';
import 'widgets/edit_currency.dart';

class CurrencyView extends StatefulWidget {
  final AuthCtl authCtl;
  const CurrencyView({super.key, required this.authCtl});

  @override
  State<CurrencyView> createState() => _CurrencyViewState();
}

class _CurrencyViewState extends State<CurrencyView> {
  final CurrencyCtl currencyCtl = Get.find<CurrencyCtl>();

  @override
  void initState() {
    currencyCtl.fetchItems();
    super.initState();
  }

  void showCurrencyEditDialog({double height = 0, double width = 0}) {
    Get.dialog(CurrencyEditDialog(
      height: height,
      width: width,
    )).then(
      (value) => currencyCtl.resetCurrency(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);

    return ContentView(
      onChangePage: (pageNumber) {
        currencyCtl.selectPage(pageNumber);
      },
      title: "Valyuta",
      pagination: currencyCtl.pagination,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenSize.width * 0.15,
              child: SearchTextField(
                hintText:
                    " ${ButtonTexts.search} | ${formatUZSNumber((12600))}",
                onChanged: (value) => currencyCtl.searchCurrency(value),
              ),
            ),
            CheckedAddButton(
              onClick: () {
                showCurrencyEditDialog(
                  width: screenSize.width * 0.4,
                  height: screenSize.height * 0.39,
                );
              },
              permission: 'create_currency',
              roles: widget.authCtl.userModel.value.roles,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenSize.height / 60,
          ),
          child: Obx(
            () => DataList(
              isLoading: currencyCtl.isLoading.value,
              isNotEmpty: currencyCtl.list.isNotEmpty,
              child: CurrencyTable(
                onSelect: () => showCurrencyEditDialog(
                  width: screenSize.width * 0.4,
                  height: screenSize.height * 0.39,
                ),
                currencyCtl: currencyCtl,
              ),
            ),
          ),
        )
      ],
    );
  }
}
