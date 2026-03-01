import 'package:dio/dio.dart';

import '../../../config/dio_provider.dart';
import '../../../core/display/user_notifier.dart';
import '../../../core/interfaces/api/get_all.dart';
import '../../../core/interfaces/getx_controller/main_controller.dart';
import '../models/unit.dart';
import 'unit_repo.dart';
import 'unit_service.dart';

class UnitCtl extends MainController<Unit> {
  late final UnitRepository _unitRepository;
  late final UnitService _unitService;

  @override
  void onInit() {
    super.onInit();
    final Dio dio = DioProvider().createDio();
    _unitRepository = UnitRepository(dio);
    _unitService = UnitService(
      getAllRepo: _unitRepository as GetAll<Unit>,
    );
  }

  @override
  void fetchItems() async {
    try {
      List<Unit> units_ = await _unitService.getAllUnits();
      list(units_);
    } catch (e) {
      UserNotifier.showSnackBar(text: "O'lchov birligni olishda xatolik");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
