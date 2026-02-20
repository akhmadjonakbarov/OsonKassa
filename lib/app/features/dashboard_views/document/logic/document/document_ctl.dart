import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/shared/models/api_data.dart';

import '../../../../../config/dio_provider.dart';
import '../../../../../core/display/user_notifier.dart';
import '../../../../../core/enums/type_of_snackbar.dart';
import '../../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../../core/interfaces/getx_controller/main_controller.dart';
import '../../models/document_model.dart';
import '../../view/controllers/document_event.dart';
import 'document_repository.dart';
import 'document_service.dart';

class DocumentCtl extends MainController<Document> {
  var error = ''.obs;
  var isToday = true.obs;
  var isSaving = false.obs;

  Rxn<DocumentEvent> events = Rxn<DocumentEvent>();

  late final DocumentRepository documentRepository;
  late final DocumentService documentService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    documentRepository = DocumentRepository(dio: dio);
    documentService = DocumentService(
      addRepository: documentRepository as Add<Map<String, dynamic>>,
      deleteRepository: documentRepository as Delete<int>,
      getAllRepository: documentRepository as GetAllWithPagination<ApiData>,
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

  void setList(List<Document> newList) {
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
    isSaving.value = true;
    try {
      setLoading(true);

      bool isSuccess = await documentService.addDocument(item);
      if (isSuccess) {
        events.value = DocumentCreated();

        fetchItems();
        isSaving.value = false;
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
      isLoading(true);
      var apiCurrencies = await documentService.getDocuments(page: page.value);
      list(apiCurrencies.items.cast<Document>());
      pagination(apiCurrencies.pagination);
      isLoading(false);
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

  // Method to sort by doc_type in ascending or descending order// Method to sort by doc_type and createdAt in ascending or descending order
  void sortDocuments({bool ascending = true}) {
    List<Document> documents = List.from(list);
    if (isToday.value) {
      documents = documents.where((element) {
        return DateTime.parse(element.createdAt!.toString()).day ==
            DateTime.now().day;
      }).toList();
    }

    // Sorting by doc_type first, then createdAt if doc_type is the same
    documents.sort((a, b) {
      int docTypeComparison = ascending
          ? a.docType!.compareTo(b.docType!)
          : b.docType!.compareTo(a.docType!);

      // If doc_type is the same, compare by createdAt
      if (docTypeComparison == 0) {
        return b.createdAt!.compareTo(a.createdAt!);
      }

      return docTypeComparison;
    });

    list(documents);
  }

  void sortByBuy() {
    sortDocuments(ascending: true);
  }

  void sortBySell() {
    sortDocuments(ascending: false);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
