import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../../config/dio_provider.dart';
import '../../../../../core/display/user_notifier.dart';
import '../../../../../core/enums/type_of_snackbar.dart';
import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../../core/interfaces/getx_controller/main_controller.dart';
import '../../../category/logic/category_controller.dart';
import '../../../trade/logic/trade_controller.dart';
import '../../models/document_item.dart';
import 'doc_item_repository.dart';
import 'doc_item_service.dart';

class DocItemCtl extends MainController<DocumentItem> {
  var docItemsByDoc = <DocumentItem>[].obs;
  var totalSelledProductCount = 0.obs;
  var totalSelledProductPrice = 0.0.obs;

  late final DocItemRepository _docItemsRepository;
  late final DocItemService _docItemsService;

  final TradeController tradeCtl = Get.find<TradeController>();
  final CategoryCtl categoryCtl = Get.find<CategoryCtl>();

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    _docItemsRepository = DocItemRepository(dio);
    _docItemsService = DocItemService(
      getAll: _docItemsRepository as GetAll<DocumentItem>,
      fetchItemsById: _docItemsRepository as FetchItemsById<DocumentItem>,
      deleteRepository: _docItemsRepository as Delete<int>,
    );

    categoryCtl.fetchItems();
    super.onInit();
  }

  @override
  void fetchItems() async {
    try {
      isLoading(true);
      List<DocumentItem> productDocItems = await _docItemsService.fetchItems();

      list(productDocItems);
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

  List<DocumentItem> filterProductByKeywords(
      List<DocumentItem> products, List<String> keywords) {
    // Filter products by checking if all keywords match either product name or category
    return products.where((product) {
      final productName = product.item!.name!.toLowerCase();
      final categoryName = product.item!.category!.toLowerCase();
      final barcode = product.item!.barcode!.toLowerCase();

      // Check if all keywords are found in either product name or category name
      return keywords.every((keyword) =>
          productName.contains(keyword) ||
          categoryName.contains(keyword) ||
          barcode.contains(keyword));
    }).toList();
  }

  void fetchByProductId(int productId) async {
    try {
      isLoading(true);
      List<DocumentItem> products =
          await _docItemsService.fetchProductDocItemsByProductDocId(productId);
      docItemsByDoc(products);
      isLoading(false);
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
