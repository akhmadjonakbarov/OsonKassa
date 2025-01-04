import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../../config/dio_provider.dart';
import '../../../../../core/display/user_notifier.dart';
import '../../../../../core/enums/type_of_snackbar.dart';
import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../../core/interfaces/getx_controller/main_controller.dart';
import '../../../category/logic/category_controller.dart';
import '../../../trade/logic/trade_ctl.dart';
import '../../models/doc_item_model.dart';
import 'doc_item_repository.dart';
import 'doc_item_service.dart';

class DocItemCtl extends MainController<DocItemModel> {
  var docItemsByDoc = <DocItemModel>[].obs;
  var totalSelledProductCount = 0.obs;
  var totalSelledProductPrice = 0.0.obs;

  late final DocItemRepository _docItemsRepository;
  late final DocItemService _docItemsService;

  final TradeCtl tradeCtl = Get.find<TradeCtl>();
  final CategoryCtl categoryCtl = Get.find<CategoryCtl>();

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    _docItemsRepository = DocItemRepository(dio);
    _docItemsService = DocItemService(
      getAll: _docItemsRepository as GetAll<DocItemModel>,
      fetchItemsById: _docItemsRepository as FetchItemsById<DocItemModel>,
      deleteRepository: _docItemsRepository as Delete<int>,
    );

    fetchItems();
    categoryCtl.fetchItems();
    super.onInit();
  }

  @override
  void fetchItems() async {
    try {
      isLoading(true);
      List<DocItemModel> product_doc_item_list =
          await _docItemsService.fetchItems();

      if (cachedList.isEmpty ||
          product_doc_item_list.length != cachedList.length) {
        cachedList(product_doc_item_list);
      }

      list(cachedList);
      isLoading(false);
    } catch (e) {
      handleError(e.toString());
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
  void removeItem(id) async {
    try {
      bool isDeleted = await _docItemsService.delete(id);

      if (isDeleted) {
        UserNotifier.showSnackBar(
          label: 'Mahsulot qaytarildi',
          type: TypeOfSnackBar.success,
        );
        fetchItems();
      }
    } catch (e) {
      handleError(e.toString());
    }
  }

  List<DocItemModel> filterProductByKeywords(
      List<DocItemModel> products, List<String> keywords) {
    // Filter products by checking if all keywords match either product name or category
    return products.where((product) {
      final productName = product.item.name.toLowerCase();
      final categoryName = product.item.category.name.toLowerCase();
      final barcode = product.item.barcode.toLowerCase();

      // Check if all keywords are found in either product name or category name
      return keywords.every((keyword) =>
          productName.contains(keyword) ||
          categoryName.contains(keyword) ||
          barcode.contains(keyword));
    }).toList();
  }

  void fetchByProductId(int product_id) async {
    try {
      isLoading(true);
      List<DocItemModel> products =
          await _docItemsService.fetchProductDocItemsByProductDocId(product_id);
      docItemsByDoc(products);
      isLoading(false);
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
