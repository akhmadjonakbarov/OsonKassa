import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../../config/dio_provider.dart';
import '../../../../../core/display/user_notifier.dart';
import '../../../../../core/enums/type_of_snackbar.dart';
import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../../core/interfaces/getx_controller/main_controller.dart';
import '../../models/document_model.dart';
import 'document_repository.dart';
import 'document_service.dart';

class DocumentCtl extends MainController<DocumentModel> {
  var error = ''.obs;
  var isToday = true.obs;

  late final DocumentRepository documentRepository;
  late final DocumentService documentService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    documentRepository = DocumentRepository(dio: dio);
    documentService = DocumentService(
      addRepository: documentRepository as Add<Map<String, dynamic>>,
      deleteRepository: documentRepository as Delete<int>,
      getAllRepository: documentRepository as GetAll<DocumentModel>,
    );
    super.onInit();
  }

  void addProductDoc(Map<String, dynamic> productDoc) async {}

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void setError(String message) {
    UserNotifier.showSnackBar(text: message);
  }

  void setList(List<DocumentModel> newList) {
    list(newList);
  }

  void setToday() {
    isToday.value = !isToday.value;
    fetchItems();
  }

  void clearError() {
    error.value = '';
  }

  @override
  void addItem(item) async {
    try {
      setLoading(true);
      List<Map<String, dynamic>> prdItems = [];

      for (Map<String, dynamic> e in item['product_doc_items']) {
        prdItems.add(
          {
            'qty': e['qty'],
            'qty_kg': e['qty_kg'],
            'item': e['item'],
            'currency_type': e['currency_type'],
            'income_price': e['income_price'],
            'income_price_usd': e['income_price_usd'],
            'can_be_cheaper': e['can_be_cheaper'],
            'selling_price': e['selling_price'],
            'selling_percentage': e['selling_percentage'],
            'currency': e['currency'],
          },
        );
      }

      Map<String, dynamic> productData = {
        "reg_date": item['reg_date'],
        "doc_type": item['doc_type'],
        "product_doc_items": prdItems
      };
      bool isSuccess = await documentService.addProductDoc(productData);
      if (isSuccess) {
        UserNotifier.showSnackBar(
          label: "Product Document qo'shildi",
          type: TypeOfSnackBar.success,
        );
        fetchItems();
      }
      setLoading(false);
    } catch (e) {
      setLoading(false);
      handleError(e.toString());
    }
  }

  @override
  void fetchItems() async {
    try {
      setLoading(true);

      final documents = await documentService.getAllProductDocs();

      list(documents);
      sortBySell();
    } catch (e) {
      handleError(e.toString());
    }
    setLoading(false);
  }

  @override
  void handleError(String e) {
    UserNotifier.showSnackBar(text: e, type: TypeOfSnackBar.error);
  }

  @override
  void removeItem(int id) async {
    try {
      setLoading(true);
      bool isDelete = await documentService.deleteProductDoc(id);
      if (isDelete) {
        UserNotifier.showSnackBar(
          label: "Product Document o'chirildi",
          type: TypeOfSnackBar.success,
        );
        fetchItems();
      }
    } catch (e) {
      setLoading(false);
      handleError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  @override
  void updateItem(DocumentModel item) {
    // TODO: implement updateItem
  }

  // Method to sort by doc_type in ascending or descending order// Method to sort by doc_type and createdAt in ascending or descending order
  void sortDocuments({bool ascending = true}) {
    List<DocumentModel> documents = List.from(list);
    if (isToday.value) {
      documents = documents.where((element) {
        return DateTime.parse(element.created_at.toString()).day ==
            DateTime.now().day;
      }).toList();
    }

    // Sorting by doc_type first, then createdAt if doc_type is the same
    documents.sort((a, b) {
      int docTypeComparison = ascending
          ? a.doc_type.compareTo(b.doc_type)
          : b.doc_type.compareTo(a.doc_type);

      // If doc_type is the same, compare by createdAt
      if (docTypeComparison == 0) {
        return b.created_at.compareTo(a.created_at);
      }

      return docTypeComparison;
    });

    list(documents);
  }

// To sort by buy (ascending order)
  void sortByBuy() {
    sortDocuments(ascending: true);
  }

// To sort by sell (descending order)
  void sortBySell() {
    sortDocuments(ascending: false);
  }
}
