import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/shared/widgets/content_view.dart';

import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../shared/export_commons.dart';
import '../logic/debt_ctl.dart';
import '../table/debt_table.dart';

class DebtView extends StatefulWidget {
  const DebtView({super.key});

  @override
  State<DebtView> createState() => _DebtViewState();
}

class _DebtViewState extends State<DebtView> {
  DebtCtl debtCtl = Get.find<DebtCtl>();

  @override
  void initState() {
    debtCtl.fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return ContentView(
      pagination: debtCtl.pagination,
      onChangePage: (p0) {},
      title: "Qarzlar",
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenSize.width * 0.15,
              child: SearchTextField(
                hintText: ButtonTexts.search,
                onChanged: (value) => debtCtl.searchDebt(value),
              ),
            ),
          ],
        ),
        Obx(
          () => DataList(
              isLoading: debtCtl.isLoading.value,
              isNotEmpty: debtCtl.list.isNotEmpty,
              child: DebtTable(debtCtl: debtCtl)),
        ),
      ],
    );
  }
}
