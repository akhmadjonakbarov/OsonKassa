import 'package:get/get.dart';

import '../../../features/shared/models/pagination_model.dart';

abstract class MainController<T> extends GetxController {
  var list = <T>[].obs;
  var cachedList = <T>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  var pagination = PaginationModel.empty().obs;

  void fetchItems();

  void addItem(Map<String, dynamic> item);

  void removeItem(int id);

  void updateItem(T item);

  void handleError(String e);

  void searchItem(
      String text, bool Function(T item, String text) searchCriteria) {
    if (text.isEmpty) {
      fetchItems();
      return;
    }

    final filteredList =
        list.where((item) => searchCriteria(item, text)).toList();

    list(filteredList);
  }

  void selectPage(int pageValue) {
    page(pageValue);

    fetchItems();
  }
}
