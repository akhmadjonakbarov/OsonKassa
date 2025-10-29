import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/type/presentation/type_view.dart';

import '../../../../config/app_views.dart';
import '../../../action/logic/action_ctl.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../dashboard_views/category/view/category_view.dart';
import '../../../dashboard_views/computer/logic/computer_ctl.dart';
import '../../../dashboard_views/computer/logic/display/display_controller.dart';
import '../../../dashboard_views/computer/view/computer_view.dart';
import '../../../dashboard_views/currency/view/currency_view.dart';
import '../../../dashboard_views/customer/logic/customer_ctl.dart';
import '../../../dashboard_views/customer/view/customer_view.dart';
import '../../../dashboard_views/document/logic/document/document_ctl.dart';
import '../../../dashboard_views/document/view/create_document/create_document_view.dart';
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
  final CustomerCtl clientCtl = Get.find<CustomerCtl>();
  final ComputerCtl computerCtl = Get.find<ComputerCtl>();
  final DisplayController displayController = Get.find<DisplayController>();

  @override
  void initState() {
    reportCtl.fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.sizeScreen.width * 0.82,
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
                Widget currentView;
                switch (widget.dashboardCtl.selectedView.value) {
                  case AppViews.dashboard:
                    currentView = StatisticsView(
                      statisticsCtl: statisticsCtl,
                    );
                    break;
                  case AppViews.trade:
                    currentView = const TradeView();
                    break;
                  case AppViews.product:
                    currentView = ItemView(
                      actionCtl: actionCtl,
                      authCtl: authCtl,
                    );
                    break;
                  case AppViews.computer:
                    currentView = ComputerView(
                      displayController: displayController,
                      authCtl: authCtl,
                      computerCtl: computerCtl,
                    );
                    break;
                  case AppViews.types:
                    currentView = TypeView(
                      authCtl: authCtl,
                    );
                    break;
                  case AppViews.document:
                    currentView = DocumentView(
                      authCtl: authCtl,
                      documentCtl: documentCtl,
                    );
                    break;
                  case AppViews.category:
                    currentView = CategoryView(
                      authCtl: authCtl,
                    );
                    break;
                  case AppViews.client:
                    currentView = CustomerView(
                      authCtl: authCtl,
                      customerCtl: clientCtl,
                    );
                    break;
                  case AppViews.spiska:
                    currentView = const NoteView();
                    break;
                  case AppViews.currency:
                    currentView = CurrencyView(
                      authCtl: authCtl,
                    );
                    break;
                  case AppViews.addProduct:
                    currentView = const CreateDocumentView();
                    break;
                  case AppViews.store:
                    currentView = StoreView(
                      storeCtl: storeCtl,
                    );
                    break;
                  default:
                    currentView = Container();
                }

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: currentView,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
