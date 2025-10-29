import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/type/data/repository/TypeRepositoryImpl.dart';
import 'package:osonkassa/app/features/dashboard_views/type/domain/repository/type_repository.dart';
import '../../../../../config/dio_provider.dart';
import '../../../../shared/models/pagination_model.dart';
import '../../domain/models/type.dart';

class TypeController extends GetxController {
  var type = ''.obs;
  var types = <Type_>[].obs;
  var loading = false.obs;
  late TypeRepository repository;

  var page = 1.obs;
  var pagination = PaginationModel.empty().obs;

  @override
  onInit() {
    final Dio dio = DioProvider().createDio();
    repository = TypeRepositoryImpl(dio: dio);
    getTypes();
    super.onInit();
  }

  getTypes() async {
    loading.value = true;
    try {
      final response = await repository.getTypes(
        page: page.value,
      );
      types.value = response.items.cast<Type_>();
      pagination.value = response.pagination;
      loading.value = false;
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
    }
  }

  createType(String name) async {
    try {
      bool isCreated = await repository.saveType(name);
      if (isCreated) {
        getTypes();
      }
    } catch (e) {
      print(e);
    }
  }

  void selectPage(int pageValue) {
    page(pageValue);
    getTypes();
  }

  void selectType(Type_ type) {
    getTypes();
  }

  void deleteType(int id) async {}
}
