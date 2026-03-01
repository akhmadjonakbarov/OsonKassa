import 'package:dio/dio.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/interfaces/api/get_all.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../models/note.dart';
import 'note_repository.dart';
import 'note_services.dart';

class NoteCtl extends MainController<Note> {
  late final NoteRepository spiskaRepository;
  late final SpiskaService spiskaService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    spiskaRepository = NoteRepository(dio: dio);
    spiskaService = SpiskaService(
      getAllRepository: spiskaRepository as GetAll<Note>,
    );
    super.onInit();
  }

  void searchProvider(String text) {
    searchItem(text, (provider, searchText) {
      return provider.name!.toLowerCase().contains(searchText.toLowerCase());
    });
  }

  @override
  Future<void> fetchItems() async {
    try {
      isLoading(true);
      List<Note> providers = await spiskaService.getAllProviders();
      list(providers);
    } catch (e) {
      handleError(e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void handleError(String e) {
    // UserNotifier.showSnackBar(
    //   text: e,
    //   type: TypeOfSnackBar.error,
    // );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
