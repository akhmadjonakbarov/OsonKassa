import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../config/dio_provider.dart';
import '../../../core/display/user_notifier.dart';
import '../../../core/enums/type_of_snackbar.dart';
import '../../../core/interfaces/api/api_interfaces.dart';
import '../models/report_model.dart';
import 'report_repository.dart';
import 'report_service.dart';

class ReportCtl extends GetxController {
  var reports = <ReportModel>[].obs;
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

  fetchItems() async {
    try {
      var reportsData = await reportService.getAllReports();
      reportsData.removeWhere(
        (element) => element.value.isEmpty,
      );

      for (var element in reportsData) {
        if (element.name == "not_selling") {
          int indexOfElement = reportsData.indexOf(element);
          var elementWithNew = element.copyWith(name: "Sotilmagan mahsulotlar");
          reportsData[indexOfElement] = elementWithNew;
        } else if (element.name == "best_selling") {
          int indexOfElement = reportsData.indexOf(element);
          var elementWithNew =
              element.copyWith(name: "Ko'p sotilgan mahsulotlar");
          reportsData[indexOfElement] = elementWithNew;
        } else if (element.name == "low_selling") {
          int indexOfElement = reportsData.indexOf(element);
          var elementWithNew =
              element.copyWith(name: "Kam sotilgan mahsulotlar");
          reportsData[indexOfElement] = elementWithNew;
        } else if (element.name == 'profitable') {
          int indexOfElement = reportsData.indexOf(element);
          var elementWithNew =
              element.copyWith(name: "Ko'p foyda keltirgan mahsulotlar");
          reportsData[indexOfElement] = elementWithNew;
        }
      }

      reports(reportsData);
    } catch (e) {
      handleError(e.toString());
    }
  }

  void handleError(String e) {
    UserNotifier.showSnackBar(label: e.toString(), type: TypeOfSnackBar.error);
  }
}
