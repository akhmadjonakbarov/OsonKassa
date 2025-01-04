import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:osonkassa/app/features/action/logic/action_ctl.dart';
import 'package:osonkassa/app/utils/helper/button_size_manager.dart';

import '../../../../core/permission_checker/permission_checker.dart';
import '../../../../styles/container_decoration.dart';

import '../../../../styles/icons.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/helper/permission_checker.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
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
    return CustomContainer(
      margin: EdgeInsets.zero,
      child: ListView(
        children: [
          HeaderTitle(
            title: "Productlar Ro'yhati",
            textStyle: textStyleBlack18.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
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
                            if (PermissionChecker.hasPermission(
                                widget.authCtl.userModel.value.roles,
                                "create_item"))
                              BasicIconButton(
                                text: ButtonTexts.add,
                                icon: AppIcons.plus,
                                onClick: () {
                                  itemCtl.editDialog(context);
                                },
                                textStyle: TextStyles.buttonTextStyle(),
                                iconHeight: 22,
                                iconWidth: 22,
                              )
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
          // Obx(
          //   () => DataList(
          //     isLoading: itemCtl.isLoading.value,
          //     isNotEmpty: itemCtl.list.isNotEmpty,
          //     child: ItemTable(
          //       itemCtl: itemCtl,
          //       isSeller: widget.authCtl.isSeller.value,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
