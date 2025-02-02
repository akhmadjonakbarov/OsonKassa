import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../core/permission/permissions.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../action/logic/action_ctl.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/content_view.dart';
import '../../../unit/logic/unit_controller.dart';
import '../../category/logic/category_controller.dart';
import '../../company/logic/company_ctl.dart';
import '../logic/item_ctl.dart';
import 'table/item_table.dart';
import 'widgets/filter_by_category.dart';

class ItemtView extends StatefulWidget {
  final AuthCtl authCtl;
  final ActionCtl actionCtl;

  const ItemtView({super.key, required this.authCtl, required this.actionCtl});

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
    return ContentView(
      onChangePage: (p0) {
        itemCtl.selectPage(p0);
      },
      pagination: itemCtl.pagination,
      title: "Mahsulotlar",
      children: [
        Obx(
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
                          CheckedAddButton(
                              onClick: () {
                                itemCtl.editDialog(context);
                              },
                              permission:
                                  Permissions.create_item.name.toLowerCase(),
                              roles: widget.authCtl.userModel.value.roles),
                        ],
                      ),
                    ],
                  )
                : const SizedBox.shrink();
          },
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
            ),
          ),
        )
      ],
    );
  }
}
