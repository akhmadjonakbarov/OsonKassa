import 'pagination_model.dart';

class ApiData<T> {
  PaginationModel pagination;
  List<T> items;
  ApiData({
    required this.pagination,
    required this.items,
  });
}
