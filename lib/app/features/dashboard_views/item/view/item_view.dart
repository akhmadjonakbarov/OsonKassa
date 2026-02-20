import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:osonkassa/app/styles/text_styles.dart';

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
import '../logic/product_events.dart';
import 'table/item_table.dart';
import 'widgets/filter_by_category.dart';
import 'widgets/item_edit_dialog.dart';

class ItemView extends StatefulWidget {
  final AuthCtl authCtl;
  final ActionCtl actionCtl;

  const ItemView({super.key, required this.authCtl, required this.actionCtl});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final ItemCtl itemCtl = Get.find<ItemCtl>();
  final CategoryCtl categoryCtl = Get.find<CategoryCtl>();
  final UnitCtl unitCtl = Get.find<UnitCtl>();
  final CompanyCtl companyCtl = Get.find<CompanyCtl>();
  final MultiSelectController categoryController = MultiSelectController();

  @override
  void initState() {
    super.initState();

    companyCtl.fetchItems();
    categoryCtl.fetchItems();
    itemCtl.fetchItems();
    itemCtl.removeSelectedCategory();
    unitCtl.fetchItems();
    ever(itemCtl.events, (ProductEvents? event) {
      if (event is ProductUpdated) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "product was updated".tr,
              style: textStyleWhite18,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
          ),
        );
      }
      if (event is ProductDeleted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "product was deleted".tr,
              style: textStyleWhite18,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
      if (event is ProductCreated) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "product was created".tr,
              style: textStyleWhite18,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    // once(itemCtl.events, (ProductEvents? event) {
    //   if (event is ProductUpdate) {
    //     Get.snackbar(
    //       "Success",
    //       "Product updated successfully!",
    //       snackPosition: SnackPosition.BOTTOM,
    //     );
    //   }
    // });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    itemCtl.selectItem(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return ContentView(
      onChangePage: (p0) {
        itemCtl.selectPage(p0);
      },
      pagination: itemCtl.pagination,
      title: "products".tr,
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
                              Get.dialog(ItemEditDialog()).then(
                                (value) => itemCtl.selectItem(null),
                              );
                            },
                            permission:
                                Permissions.create_item.name.toLowerCase(),
                            roles: widget.authCtl.userModel.value.roles,
                          ),
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
