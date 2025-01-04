import 'package:dio/dio.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/interfaces/api/get_all.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../models/spiska_model.dart';
import 'spiska_repository.dart';
import 'spiska_services.dart';

class SpiskaCtl extends MainController<SpiskaModel> {
  late final SpiskaRepository spiskaRepository;
  late final SpiskaService spiskaService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    spiskaRepository = SpiskaRepository(dio: dio);
    spiskaService = SpiskaService(
      getAllRepository: spiskaRepository as GetAll<SpiskaModel>,
    );
    super.onInit();
  }

  void searchProvider(String text) {
    searchItem(text, (provider, searchText) {
      return provider.item.name
          .toLowerCase()
          .contains(searchText.toLowerCase());
    });
  }

  @override
  void fetchItems() async {
    try {
      isLoading(true);
      List<SpiskaModel> providers = await spiskaService.getAllProviders();
      list(providers);
    } catch (e) {
      handleError(e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void handleError(String e) {
    UserNotifier.showSnackBar(
      text: e,
      type: TypeOfSnackBar.error,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
