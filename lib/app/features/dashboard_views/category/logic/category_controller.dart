import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../core/interfaces/api/add.dart';
import '../../../../core/interfaces/api/delete.dart';
import '../../../../core/interfaces/api/get_all.dart';
import '../../../../core/interfaces/api/update.dart';
import '../../../../core/interfaces/getx_controller/main_controller.dart';
import '../../../../styles/colors.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/helper/valid_alert.dart';
import '../../../../utils/texts/alert_texts.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../shared/models/api_data.dart';
import '../../../shared/widgets/buttons.dart';
import '../models/category_models.dart';
import 'category_repository.dart';
import 'category_service.dart';

class CategoryCtl extends MainController<CategoryModel> {
  var filteredCategories = <CategoryModel>[].obs;
  var selected_category_id = 0.obs;

  var selectedCategory = CategoryModel.empty().obs;

  late final CategoryRepository categoryRepository;
  late final CategoryService categoryService;

  @override
  void onInit() {
    super.onInit();
    final Dio dio = DioProvider().createDio();
    categoryRepository = CategoryRepository(dio: dio);
    categoryService = CategoryService(
      addRepository: categoryRepository as Add<Map<String, dynamic>>,
      updateRepository: categoryRepository as Update<CategoryModel>,
      deleteRepository: categoryRepository as Delete<int>,
      getAllRepository: categoryRepository as GetAllWithPagination<ApiData>,
    );
  }

  void selectCategory(CategoryModel category, BuildContext context) {
    selectedCategory(category);
    editDialog(context);
  }

  void searchCategory(String text) {
    searchItem(text, (category, searchText) {
      return category.name.toLowerCase().contains(searchText.toLowerCase());
    });
  }

  @override
  void addItem(item) async {
    try {
      bool isSuccess = await categoryService.addCategory(item);
      if (isSuccess) {
        UserNotifier.showSnackBar(
          label: "${item['name']} ${AlertTexts.created}",
          type: TypeOfSnackBar.success,
        );
        fetchItems();
      }
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  void fetchItems() async {
    try {
      isLoading(true);

      var data = await categoryService.getAllCategories();
      data.items.removeWhere(
        (element) => element.items_count == 0,
      );
      filteredCategories(List.from(data.items));
      data = await categoryService.getAllCategories();

      list(data.items.cast<CategoryModel>().toList());
      pagination(data.pagination);
      isLoading(false);
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  void removeItem(id) async {
    try {
      bool isDeleted = await categoryService.deleteCategory(id);
      if (isDeleted) {
        UserNotifier.showSnackBar(
          label: AlertTexts.deleted,
          type: TypeOfSnackBar.delete,
        );
        isLoading(false);
      }
    } catch (e) {
      handleError(e.toString());
    }
    fetchItems();
  }

  @override
  void updateItem(item) async {
    try {
      await categoryService.updateCategory(item);
      UserNotifier.showSnackBar(
        label: AlertTexts.updateAlert(item.name),
        type: TypeOfSnackBar.update,
      );

      fetchItems();
    } catch (e) {
      handleError(e.toString());
    }
  }

  @override
  void handleError(e) async {
    UserNotifier.showSnackBar(
      text: e,
      type: TypeOfSnackBar.error,
    );
  }

  void editDialog(BuildContext context) {
    bool isNull = selectedCategory.value.id == 0;

    final TextEditingController categoryNameController =
        TextEditingController();

    final formKey = GlobalKey<FormState>();

    if (!isNull) {
      categoryNameController.text = selectedCategory.value.name;
    }

    final String actionText = isNull ? ButtonTexts.add : ButtonTexts.edit;

    Get.dialog(Dialog(
      backgroundColor: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.25,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isNull
                  ? '${DisplayTexts.categories}  ${ButtonTexts.add}'
                  : '${DisplayTexts.categories}  ${ButtonTexts.edit}',
              style: textStyleBlack18.copyWith(fontSize: 22),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: categoryNameController,
                      validator: (value) {
                        if (value == "") {
                          return validField('mahsulot nomini');
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      style: textStyleBlack18,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Mahsulot nomi",
                        hintStyle:
                            textStyleBlack18.copyWith(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DialogTextButton(
                  text: ButtonTexts.cancel,
                  onClick: () {
                    Get.back();
                  },
                  textStyle: textStyleBlack14,
                  isNegative: true,
                ),
                DialogTextButton(
                  text: actionText,
                  onClick: () {
                    bool isValid = formKey.currentState!.validate();
                    if (isValid) {
                      final String categoryName =
                          categoryNameController.text.trim();
                      final CategoryModel category = selectedCategory
                                  .value.id ==
                              -1
                          ? CategoryModel(
                              items_type_count: 0,
                              id: -1,
                              name: categoryName,
                              created_at: DateTime.now(),
                              updated_at: DateTime.now(),
                              items_count: 0,
                            )
                          : selectedCategory.value.copyWith(name: categoryName);
                      if (isNull) {
                        addItem(
                          {
                            'name': categoryName.capitalizeFirst,
                          },
                        );
                      } else {
                        updateItem(category);
                      }
                      fetchItems();
                      Get.back();
                    }
                  },
                  textStyle: textStyleBlack14,
                ),
              ],
            ),
          ],
        ),
      ),
    )).then((value) => resetCategory());
  }

  void resetCategory() {
    selectedCategory(CategoryModel.empty());
  }
}
