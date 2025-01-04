import 'package:dio/dio.dart';

import '../../../config/dio_provider.dart';
import '../../../core/display/user_notifier.dart';
import '../../../core/enums/type_of_snackbar.dart';
import '../../../core/interfaces/api/api_interfaces.dart';
import '../../../core/interfaces/getx_controller/main_controller.dart';
import '../models/report_model.dart';
import 'report_repository.dart';
import 'report_service.dart';

class ReportCtl extends MainController<ReportModel> {
  late final ReportRepository reportRepository;
  late final ReportService reportService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    reportRepository = ReportRepository(dio: dio);
    reportService = ReportService(
      getAllRepository: reportRepository as GetAll<ReportModel>,
    );
    super.onInit();
  }

  @override
  void fetchItems() async {
    try {
      var reports = await reportService.getAllReports();
      reports.removeWhere(
        (element) => element.value.isEmpty,
      );

      for (var element in reports) {
        if (element.name == "not_selling") {
          int indexOfElement = reports.indexOf(element);
          var elementWithNew = element.copyWith(name: "Sotilmagan mahsulotlar");
          reports[indexOfElement] = elementWithNew;
        } else if (element.name == "best_selling") {
          int indexOfElement = reports.indexOf(element);
          var elementWithNew =
              element.copyWith(name: "Ko'p sotilgan mahsulotlar");
          reports[indexOfElement] = elementWithNew;
        } else if (element.name == "low_selling") {
          int indexOfElement = reports.indexOf(element);
          var elementWithNew =
              element.copyWith(name: "Kam sotilgan mahsulotlar");
          reports[indexOfElement] = elementWithNew;
        } else if (element.name == 'profitable') {
          int indexOfElement = reports.indexOf(element);
          var elementWithNew =
              element.copyWith(name: "Ko'p foyda keltirgan mahsulotlar");
          reports[indexOfElement] = elementWithNew;
        }
      }

      list(reports);
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  void handleError(String e) {
    UserNotifier.showSnackBar(label: e.toString(), type: TypeOfSnackBar.error);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
