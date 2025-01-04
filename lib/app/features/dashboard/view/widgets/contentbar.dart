import 'package:osonkassa/app/features/dashboard_views/customer/logic/client_ctl.dart';
import 'package:osonkassa/app/features/dashboard_views/document/logic/document/document_ctl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/app_views.dart';
import '../../../../styles/colors.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../dashboard_views/category/view/category_view.dart';
import '../../../dashboard_views/customer/view/customer_view.dart';
import '../../../dashboard_views/currency/view/currency_view.dart';
import '../../../dashboard_views/debt/view/debt_view.dart';
import '../../../dashboard_views/document/view/edit_screen/edit_product_doc_item_screen.dart';
import '../../../dashboard_views/document/view/main_screen/document_view.dart';
import '../../../dashboard_views/item/view/item_view.dart';
import '../../../dashboard_views/spiska/view/spiska_view.dart';
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
  final DocumentCtl documentCtl = Get.find<DocumentCtl>();
  final ClientCtl clientCtl = Get.find<ClientCtl>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      width: widget.sizeScreen.width * 0.80,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                      authCtl: authCtl,
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
                      clientCtl: clientCtl,
                    );
                  case AppViews.spiska:
                    return const SpiskaView();
                  case AppViews.currency:
                    return const CurrencyView();
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
