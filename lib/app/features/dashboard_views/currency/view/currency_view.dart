import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/shared/widgets/pagination.dart';
import 'package:osonkassa/app/styles/themes.dart';

import '../../../../core/permission_checker/permission_checker.dart';

import '../../../../styles/text_styles.dart';
import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../shared/export_commons.dart';
import '../logic/currency_controller.dart';
import 'table/currency_table.dart';
import 'widgets/edit_currency.dart';

class CurrencyView extends StatefulWidget {
  const CurrencyView({super.key});

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

    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                HeaderTitle(
                  title: "Valyuta List",
                  textStyle: textStyleBlack18.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
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
                    DialogTextButton(
                      onClick: () {},
                      text: "Tafsilotlar",
                      textStyle: textStyleBlack14,
                    ),
                    if (screenSize.width <= 1370)
                      SizedBox(
                        width: screenSize.width * 0.1,
                        child: PermissionCheckerS.addButton(
                          'admin',
                          () {
                            showCurrencyEditDialog(
                              width: screenSize.width * 0.4,
                              height: screenSize.height * 0.39,
                            );
                          },
                          Size(0, screenSize.height * 0.05),
                        ),
                      )
                    else
                      SizedBox(
                        width: screenSize.width * 0.08,
                        child: PermissionCheckerS.addButton(
                          'admin',
                          () {
                            showCurrencyEditDialog(
                              width: screenSize.width * 0.4,
                              height: screenSize.height * 0.39,
                            );
                          },
                          Size(0, screenSize.height * 0.05),
                        ),
                      ),
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
            ),
          ),
          CustomContainer(
            height: screenSize.height * 0.1 / 1.8,
            margin: const EdgeInsets.only(top: 5),
            decoration: Decorations.decoration(),
            child: Obx(
              () => Pagination(
                count: currencyCtl.pagination.value.pages,
                onClick: (index) {
                  currencyCtl.selectPage(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
