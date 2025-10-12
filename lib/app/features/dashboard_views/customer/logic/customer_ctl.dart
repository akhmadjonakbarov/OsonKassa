import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../models/customer.dart';
import 'customer_repository.dart';
import 'customer_services.dart';

class CustomerCtl extends PaginationController {
  RxList<Customer> customers = RxList<Customer>();
  Rxn<Customer> selectedCustomer = Rxn(null);
  var isLoading = false.obs;

  late final ClientRepository repository;
  late final ClientService service;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    repository = ClientRepository(dio: dio);
    service = ClientService(
      addRepository: repository as Add<Map<String, dynamic>>,
      updateRepository: repository as Update<Customer>,
      deleteRepository: repository as Delete<int>,
      getAllRepository: repository as GetAll<Customer>,
    );
    super.onInit();
    fetchItems();
  }

  fetchItems() async {
    try {
      isLoading(true);
      var apiBuilders = await service.getAllClient();

      customers(apiBuilders);
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
      );
    } finally {
      isLoading(false);
    }
  }

  void selectCustomer(Customer? builder) {
    selectedCustomer.value = builder;
  }

  void addItem(item) async {
    try {
      await service.addClient(clientData: item);
      UserNotifier.showSnackBar(
        text: "${item['full_name']} qo'shildi",
        type: TypeOfSnackBar.success,
      );
      fetchItems();
    } catch (e) {
      switch (e) {
        case AlreadyExistException _:
          UserNotifier.showSnackBar(
            label: "Bu quruvchi mavjud!",
          );
          break;
        default:
          UserNotifier.showSnackBar(
            text: e.toString(),
          );
          break;
      }
    }
  }

  void removeItem(int id) async {
    try {
      await service.deleteClient(id);
      UserNotifier.showSnackBar(
        label: "Quruvchi o'chirildi",
        type: TypeOfSnackBar.delete,
      );
      fetchItems();
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
      );
    }
  }

  void searchBuilder(String text) {
    if (text.isEmpty) {
      fetchItems();
      return;
    }
  }

  void sortByCreatedAt() {
    List<Customer> builders = List.from(customers);
    builders.sort((a, b) {
      return b.createdAt!.compareTo(a.createdAt!);
    });
    customers(builders);
  }

  void sortByName() {
    List<Customer> builders = List.from(customers);
    builders.sort((a, b) {
      return a.fullName!.toLowerCase().compareTo(b.fullName!.toLowerCase());
    });
    customers(builders);
  }

  void handleError(String e) {
    UserNotifier.showSnackBar(label: e.toString(), type: TypeOfSnackBar.error);
  }

  void updateItem(Customer item) async {
    try {
      await service.updateClient(client: item);
      UserNotifier.showSnackBar(
        label: "${item.fullName} yangilandi!",
        type: TypeOfSnackBar.update,
      );

      fetchItems();
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
      );
    }
  }
}
