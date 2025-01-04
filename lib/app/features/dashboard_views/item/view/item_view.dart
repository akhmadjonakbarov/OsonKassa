import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../core/permission_checker/permission_checker.dart';
import '../../../../styles/container_decoration.dart';

import '../../../../styles/text_styles.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../../unit/logic/unit_controller.dart';
import '../../category/logic/category_controller.dart';
import '../../company/logic/company_ctl.dart';
import '../logic/item_ctl.dart';
import 'table/item_table.dart';
import 'widgets/filter_by_category.dart';

class ItemtView extends StatefulWidget {
  final AuthCtl authCtl;
  const ItemtView({super.key, required this.authCtl});

  @override
  State<ItemtView> createState() => _ItemtViewState();
}

class _ItemtViewState extends State<ItemtView> {
  final ItemCtl itemCtl = Get.find<ItemCtl>();
  final CategoryCtl categoryCtl = Get.find<CategoryCtl>();
  final UnitCtl unitCtl = Get.find<UnitCtl>();
  final CompanyCtl companyCtl = Get.find<CompanyCtl>();
  final MultiSelectController categoryController = MultiSelectController();

  @override
  void initState() {
    companyCtl.fetchItems();
    categoryCtl.fetchItems();
    itemCtl.fetchItems();
    itemCtl.removeSelectedCategory();
    unitCtl.fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return AppContainer(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTitle(
              title: "Productlar Ro'yhati",
              textStyle: textStyleBlack18.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            AppContainer(
              padding: const EdgeInsets.all(5),
              decoration: containerDecoration,
              child: Obx(
                () {
                  return categoryCtl.list.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  // filter by category
                                  FilterByCategory(
                                    multiSelectController: categoryController,
                                    isSearchEnabled: true,
                                    categories: categoryCtl.list,
                                    onSearchByCategory: (p0) =>
                                        itemCtl.filterByCategory(p0),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      itemCtl.removeSelectedCategory();
                                      categoryController.clearAllSelection();
                                    },
                                    icon: const Icon(Icons.refresh),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: screenSize.width * 0.15,
                                  child: SearchTextField(
                                    onChanged: (value) =>
                                        itemCtl.searchProduct(value),
                                  ),
                                ),
                                Row(
                                  children: [
                                    if (screenSize.width <= 1370)
                                      SizedBox(
                                        width: screenSize.width * 0.1,
                                        child: PermissionChecker.addButton(
                                          widget.authCtl.userModel.value
                                              .employee.role.role,
                                          () {
                                            itemCtl.editDialog(context);
                                          },
                                          Size(0, screenSize.height * 0.06),
                                        ),
                                      )
                                    else
                                      SizedBox(
                                        width: screenSize.width * 0.08,
                                        child: PermissionChecker.addButton(
                                          widget.authCtl.userModel.value
                                              .employee.role.role,
                                          () {
                                            itemCtl.editDialog(context);
                                          },
                                          Size(0, screenSize.height * 0.05),
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => DataList(
                isLoading: itemCtl.isLoading.value,
                isNotEmpty: itemCtl.list.isNotEmpty,
                child: ItemTable(
                  itemCtl: itemCtl,
                  isSeller: widget.authCtl.isSeller.value,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
