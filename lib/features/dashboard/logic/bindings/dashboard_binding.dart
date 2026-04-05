import 'package:get/get.dart';
import 'package:osonkassa/features/dashboard_views/trade/logic/order_controller.dart';
import 'package:osonkassa/features/dashboard_views/trade/logic/payment_controller.dart';

import '../../../action/logic/action_ctl.dart';
import '../../../dashboard_views/category/logic/category_controller.dart';
import '../../../dashboard_views/company/logic/company_ctl.dart';
import '../../../dashboard_views/computer/logic/computer_ctl.dart';
import '../../../dashboard_views/computer/logic/display/display_controller.dart';
import '../../../dashboard_views/currency/logic/currency_controller.dart';
import '../../../dashboard_views/customer/view/controllers/customer_controller/customer_controller.dart';
import '../../../dashboard_views/customer/view/controllers/transaction_controller.dart';
import '../../../dashboard_views/document/logic/doc_item/doc_item_ctl.dart';
import '../../../dashboard_views/document/logic/document/document_ctl.dart';
import '../../../dashboard_views/document/logic/view_controller/manage_product_doc_item_ctl.dart';
import '../../../dashboard_views/item/logic/item_ctl.dart';
import '../../../dashboard_views/note/logic/note_controller.dart';
import '../../../dashboard_views/statistics/logic/statistics_ctl.dart';
import '../../../dashboard_views/store/logic/store_ctl.dart';
import '../../../dashboard_views/trade/logic/trade_controller.dart';
import '../../../report_docs/logic/report_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../../unit/logic/unit_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenCtl());
    Get.lazyPut(() => DashboardCtl());
    Get.lazyPut(() => CategoryCtl());
    Get.lazyPut(() => CustomerCtl(), fenix: true);
    Get.lazyPut(() => NoteCtl());
    Get.lazyPut(() => CurrencyCtl());
    Get.lazyPut(() => UnitCtl());
    Get.lazyPut(() => ItemCtl());
    Get.lazyPut(() => DocumentCtl());
    Get.lazyPut(() => DocItemCtl());
    Get.lazyPut(() => TradeController());
    Get.lazyPut(() => StoreCtl());
    Get.lazyPut(() => StatisticsCtl());
    Get.lazyPut(() => ManageProductDocItemCtl());
    Get.lazyPut(() => CompanyCtl());
    Get.lazyPut(() => ReportCtl());
    Get.lazyPut(() => ActionCtl());
    Get.lazyPut(() => ComputerCtl());
    Get.lazyPut(() => DisplayController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => PaymentController());
    Get.lazyPut(() => TransactionController());
  }
}
