import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/translation/translated_texts.dart';

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
import '../models/customer.dart';
import 'customer_repository.dart';
import 'customer_services.dart';

class CustomerCtl extends MainController<Customer> {
  var selectedClient = Customer().obs;

  late final ClientRepository builderRepository;
  late final ClientService builderService;

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
    selectedClient(Customer());
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

  void selectBuilder(Customer builder, BuildContext context) {
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
    String buttonText =
        isNull ? TranslatedTexts.buttons.save : TranslatedTexts.buttons.edit;
    // Check if we are editing an existing provider
    if (!isNull) {
      // Set initial values for the controllers if an existing provider is selected
      nameController.text = selectedClient.value.fullName!;
      phoneNumberController.text = selectedClient.value.phoneNumber!;
      phoneNumber2Controller.text = selectedClient.value.phoneNumber2!;
      addressController.text = selectedClient.value.address!;
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
                  isNull
                      ? TranslatedTexts.customer.add.tr
                      : TranslatedTexts.customer.edit.tr,
                  style: textStyleBlack18.copyWith(fontSize: 22),
                ),
                const Divider(),
                const SizedBox(height: 16),
                CustomDialogTextField(
                  controller: nameController,
                  label: TranslatedTexts.textFields.fullName.tr,
                ),
                CustomDialogTextField(
                  controller: phoneNumberController,
                  label: TranslatedTexts.textFields.phoneNumber.tr,
                ),
                CustomDialogTextField(
                  canBeNull: true,
                  controller: phoneNumber2Controller,
                  label: TranslatedTexts.textFields.phoneNumber2.tr,
                ),
                CustomDialogTextField(
                  controller: addressController,
                  label: TranslatedTexts.textFields.address.tr,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DialogTextButton(
                      text: TranslatedTexts.buttons.cancel.tr,
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
                            'phoneNumber': phoneNumber,
                            'phoneNumber2': phoneNumber2,
                            'address': address,
                          };

                          if (isNull) {
                            // Add new provider
                            addItem(clientData);
                          } else {
                            // Update existing provider
                            Customer updatedClient =
                                selectedClient.value.copyWith(
                              fullName: name,
                              phoneNumber: phoneNumber,
                              phoneNumber2: phoneNumber2,
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
                      text: buttonText.tr,
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
