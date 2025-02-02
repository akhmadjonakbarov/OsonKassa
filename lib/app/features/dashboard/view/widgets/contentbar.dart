import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/computer/logic/display/display_controller.dart';

import '../../../../config/app_views.dart';
import '../../../action/logic/action_ctl.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../dashboard_views/category/view/category_view.dart';
import '../../../dashboard_views/computer/logic/computer_ctl.dart';
import '../../../dashboard_views/computer/view/computer_view.dart';
import '../../../dashboard_views/currency/view/currency_view.dart';
import '../../../dashboard_views/customer/logic/client_ctl.dart';
import '../../../dashboard_views/customer/view/customer_view.dart';
import '../../../dashboard_views/debt/view/debt_view.dart';
import '../../../dashboard_views/document/logic/document/document_ctl.dart';
import '../../../dashboard_views/document/view/edit_screen/edit_product_doc_item_screen.dart';
import '../../../dashboard_views/document/view/main_screen/document_view.dart';
import '../../../dashboard_views/item/view/item_view.dart';
import '../../../dashboard_views/note/view/note_view.dart';
import '../../../dashboard_views/statistics/logic/statistics_ctl.dart';
import '../../../dashboard_views/statistics/view/statistics_view.dart';
import '../../../dashboard_views/store/logic/store_ctl.dart';
import '../../../dashboard_views/store/view/store_view.dart';
import '../../../dashboard_views/trade/views/trade_view.dart';
import '../../../report_docs/logic/report_ctl.dart';
import '../../logic/controllers/dashboard_controller.dart';
import 'header.dart';

class ContentBar extends StatefulWidget {
  final DashboardCtl dashboardCtl;

  const ContentBar({
    super.key,
    required this.dashboardCtl,
    required this.sizeScreen,
  });

  final Size sizeScreen;

  @override
  State<ContentBar> createState() => _ContentBarState();
}

class _ContentBarState extends State<ContentBar> {
  final StoreCtl storeCtl = Get.find<StoreCtl>();
  final StatisticsCtl statisticsCtl = Get.find<StatisticsCtl>();
  final ReportCtl reportCtl = Get.find<ReportCtl>();
  final AuthCtl authCtl = Get.find<AuthCtl>();
  final ActionCtl actionCtl = Get.find<ActionCtl>();
  final DocumentCtl documentCtl = Get.find<DocumentCtl>();
  final ClientCtl clientCtl = Get.find<ClientCtl>();
  final ComputerCtl computerCtl = Get.find<ComputerCtl>();
  final DisplayController displayController = Get.find<DisplayController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.sizeScreen.width * 0.805,
      alignment: Alignment.center,
      child: Column(
        children: [
          Header(
            authCtl: authCtl,
            dashboardCtl: widget.dashboardCtl,
            reportCtl: reportCtl,
            statisticsCtl: statisticsCtl,
            storeCtl: storeCtl,
          ),
          Expanded(
            child: Obx(
              () {
                reportCtl.fetchItems();
                switch (widget.dashboardCtl.selectedView.value) {
                  case AppViews.dashboard:
                    return StatisticsView(
                      staticticsCtl: statisticsCtl,
                    );
                  case AppViews.trade:
                    return const TradeView();
                  case AppViews.product:
                    return ItemtView(
                      actionCtl: actionCtl,
                      authCtl: authCtl,
                    );
                  case AppViews.computer:
                    return ComputerView(
                      displayController: displayController,
                      authCtl: authCtl,
                      computerCtl: computerCtl,
                    );
                  case AppViews.document:
                    return DocumentView(
                      authCtl: authCtl,
                      documentCtl: documentCtl,
                    );
                  case AppViews.category:
                    return CategoryView(
                      authCtl: authCtl,
                    );
                  case AppViews.client:
                    return CustomerView(
                      authCtl: authCtl,
                      clientCtl: clientCtl,
                    );
                  case AppViews.spiska:
                    return const NoteView();
                  case AppViews.currency:
                    return CurrencyView(
                      authCtl: authCtl,
                    );
                  case AppViews.debt:
                    return const DebtView();
                  case AppViews.addProduct:
                    return const EditProductDocItemScreen();
                  case AppViews.store:
                    return StoreView(
                      storeCtl: storeCtl,
                    );
                  default:
                    return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
