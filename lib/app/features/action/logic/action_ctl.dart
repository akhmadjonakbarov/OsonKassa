import 'package:dio/dio.dart';
import '../../../core/interfaces/api/api_interfaces.dart';
import '../../../core/interfaces/getx_controller/main_controller.dart';
import 'action_repository.dart';
import 'action_service.dart';
import '../models/action_model.dart';

import '../../../config/dio_provider.dart';
import '../../../core/display/user_notifier.dart';
import '../../../core/enums/type_of_snackbar.dart';

class ActionCtl extends MainController<ActionModel> {
  late final ActionRepository actionRepository;
  late final ActionService actionService;

  @override
  void onInit() {
    super.onInit();
    final Dio dio = DioProvider().createDio();
    actionRepository = ActionRepository(dio: dio);
    actionService = ActionService(
      getAllRepository: actionRepository as GetAll<ActionModel>,
    );
  }

  @override
  void addItem(Map<String, dynamic> item) {
    // TODO: implement addItem
  }

  @override
  void fetchItems() async {
    try {
      final List<ActionModel> actions = await actionService.getAllActions();
      list(actions);
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  void handleError(e) async {
    UserNotifier.showSnackBar(
      text: e,
      type: TypeOfSnackBar.error,
    );
  }

  @override
  void removeItem(int id) {
    // TODO: implement removeItem
  }

  @override
  void updateItem(ActionModel item) {
    // TODO: implement updateItem
  }
}
