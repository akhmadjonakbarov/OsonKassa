import 'package:dio/dio.dart';
import 'package:osonkassa/app/core/interfaces/api/api_interfaces.dart';
import 'package:osonkassa/app/core/interfaces/getx_controller/main_controller.dart';
import 'package:osonkassa/app/features/action/logic/action_repository.dart';
import 'package:osonkassa/app/features/action/logic/action_service.dart';
import 'package:osonkassa/app/features/action/models/action_model.dart';

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
