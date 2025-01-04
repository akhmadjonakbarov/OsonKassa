import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/interfaces/api/api_interfaces.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../../../../styles/colors.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/user_texts.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/custom_textfields.dart';
import '../models/client_model.dart';
import 'client_repository.dart';
import 'client_services.dart';

class ClientCtl extends MainController<CustomerModel> {
  var selectedClient = CustomerModel.empty().obs;

  late final ClientRepository builderRepository;
  late final ClientService builderService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    builderRepository = ClientRepository(dio: dio);
    builderService = ClientService(
      addRepository: builderRepository as Add<Map<String, dynamic>>,
      updateRepository: builderRepository as Update<CustomerModel>,
      deleteRepository: builderRepository as Delete<int>,
      getAllRepository: builderRepository as GetAll<CustomerModel>,
    );
    super.onInit();
  }

  void resetBuilder() {
    selectedClient(CustomerModel.empty());
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

  void selectBuilder(CustomerModel builder, BuildContext context) {
    selectedClient(builder);
    editDialog(context);
  }

  void editDialog(BuildContext context) {
    // is Provider null
    bool isNull = selectedClient.value.id == -1;
    // Controllers for each input field
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController phoneNumber2Controller =
        TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String buttonText = isNull ? ButtonTexts.save : ButtonTexts.edit;
    // Check if we are editing an existing provider
    if (!isNull) {
      // Set initial values for the controllers if an existing provider is selected
      nameController.text = selectedClient.value.full_name;
      phoneNumberController.text = selectedClient.value.phone_number;
      phoneNumber2Controller.text = selectedClient.value.phone_number2;
      addressController.text = selectedClient.value.address;
    }

    // Step 2: Create the method to show the dialog
    Get.dialog(
      Dialog(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width *
              0.2, // Set the desired width here
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isNull ? 'Klient  qo\'shish' : 'Klientni tahrirlash',
                  style: textStyleBlack18.copyWith(fontSize: 22),
                ),
                const Divider(),
                const SizedBox(height: 16),
                CustomDialogTextField(
                  controller: nameController,
                  label: UserTexts.fullName,
                ),
                CustomDialogTextField(
                  controller: phoneNumberController,
                  label: UserTexts.phone_number,
                ),
                CustomDialogTextField(
                  canBeNull: true,
                  controller: phoneNumber2Controller,
                  label: UserTexts.phoneNumber2,
                ),
                CustomDialogTextField(
                  controller: addressController,
                  label: UserTexts.address,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DialogTextButton(
                      text: ButtonTexts.cancel,
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                      textStyle: textStyleGrey14,
                      isNegative: true,
                    ),
                    const SizedBox(width: 8),
                    DialogTextButton(
                      bgColor: isNull ? null : Colors.green,
                      onClick: () {
                        bool isValid = formKey.currentState!.validate();
                        if (isValid) {
                          // Handle save action
                          String name = nameController.text.trim();
                          String phoneNumber =
                              phoneNumberController.text.trim();
                          String phoneNumber2 =
                              phoneNumber2Controller.text.trim();
                          String address = addressController.text.trim();
                          Map<String, dynamic> clientData = {
                            'full_name': name,
                            'phone_number': phoneNumber,
                            'phone_number2': phoneNumber2,
                            'address': address,
                          };

                          if (isNull) {
                            // Add new provider
                            addItem(clientData);
                          } else {
                            // Update existing provider
                            CustomerModel updatedClient =
                                selectedClient.value.copyWith(
                              name: name,
                              phone_number: phoneNumber,
                              phone_number2: phoneNumber2,
                              address: address,
                            );
                            updateItem(updatedClient);
                          }

                          // Clear controllers and close dialog
                          nameController.clear();
                          phoneNumberController.clear();
                          phoneNumber2Controller.clear();
                          addressController.clear();
                          Navigator.of(context).pop();
                        }
                        fetchItems();
                      },
                      textStyle: textStyleBlack14,
                      text: buttonText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ).then(
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
      return customer.full_name
          .toLowerCase()
          .contains(searchText.toLowerCase());
    });
  }

  void sortByCreatedAt() {
    List<CustomerModel> builders = List.from(list);
    builders.sort((a, b) {
      return b.created_at.compareTo(a.created_at);
    });
    list(builders);
  }

  void sortByName() {
    List<CustomerModel> builders = List.from(list);
    builders.sort((a, b) {
      return a.full_name.toLowerCase().compareTo(b.full_name.toLowerCase());
    });
    list(builders);
  }

  @override
  void handleError(String e) {
    UserNotifier.showSnackBar(label: e.toString(), type: TypeOfSnackBar.error);
  }

  @override
  void updateItem(CustomerModel item) async {
    try {
      await builderService.updateClient(client: item);
      UserNotifier.showSnackBar(
        label: "${item.full_name} yangilandi!",
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
