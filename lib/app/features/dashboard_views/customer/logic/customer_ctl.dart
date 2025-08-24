import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../models/customer.dart';
import '../view/widgets/customer_edit_dialog.dart';
import 'customer_repository.dart';
import 'customer_services.dart';

class CustomerCtl extends MainController<Customer> {
  Rxn<Customer> selectedCustomer = Rxn(null);

  late final ClientRepository builderRepository;
  late final ClientService builderService;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController phoneNumber2Controller = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    builderRepository = ClientRepository(dio: dio);
    builderService = ClientService(
      addRepository: builderRepository as Add<Map<String, dynamic>>,
      updateRepository: builderRepository as Update<Customer>,
      deleteRepository: builderRepository as Delete<int>,
      getAllRepository: builderRepository as GetAll<Customer>,
    );
    super.onInit();
  }

  void resetBuilder() {
    selectedCustomer(null);
    nameController.clear();
    phoneNumberController.clear();
    phoneNumber2Controller.clear();
    addressController.clear();
  }

  @override
  void fetchItems() async {
    try {
      isLoading(true);
      var apiBuilders = await builderService.getAllClient();

      list(apiBuilders);
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
      );
    } finally {
      isLoading(false);
    }
  }

  void selectCustomer(Customer builder, BuildContext context) {
    selectedCustomer(builder);
    editDialog(context);
  }

  void editDialog(BuildContext context) {
    if (selectedCustomer.value != null) {
      nameController.text = selectedCustomer.value!.fullName!;
      phoneNumberController.text = selectedCustomer.value!.phoneNumber!;
      phoneNumber2Controller.text = selectedCustomer.value!.phoneNumber2!;
      addressController.text = selectedCustomer.value!.address!;
    } else {
      resetBuilder();
    }
    Get.dialog(CustomerEditDialog(customerCtl: this)).then(
      (value) => resetBuilder(),
    );
  }

  @override
  void addItem(item) async {
    try {
      await builderService.addClient(clientData: item);
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

  @override
  void removeItem(id) async {
    try {
      await builderService.deleteClient(id);
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
    searchItem(text, (customer, searchText) {
      return customer.fullName!
          .toLowerCase()
          .contains(searchText.toLowerCase());
    });
  }

  void sortByCreatedAt() {
    List<Customer> builders = List.from(list);
    builders.sort((a, b) {
      return b.createdAt!.compareTo(a.createdAt!);
    });
    list(builders);
  }

  void sortByName() {
    List<Customer> builders = List.from(list);
    builders.sort((a, b) {
      return a.fullName!.toLowerCase().compareTo(b.fullName!.toLowerCase());
    });
    list(builders);
  }

  @override
  void handleError(String e) {
    UserNotifier.showSnackBar(label: e.toString(), type: TypeOfSnackBar.error);
  }

  @override
  void updateItem(Customer item) async {
    try {
      await builderService.updateClient(client: item);
      UserNotifier.showSnackBar(
        label: "${item.fullName} yangilandi!",
        type: TypeOfSnackBar.update,
      );

      fetchItems();
      resetBuilder();
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
      );
    }
  }
}
