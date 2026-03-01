import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/permission/permissions.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/content_view.dart';
import '../logic/category_controller.dart';
import 'table/category_table.dart';

class CategoryView extends StatefulWidget {
  final AuthCtl authCtl;

  const CategoryView({super.key, required this.authCtl});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  CategoryCtl categoryCtl = Get.find<CategoryCtl>();

  @override
  void initState() {
    categoryCtl.fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return ContentView(
      onChangePage: (p0) {
        categoryCtl.selectPage(p0);
      },
      title: "Bo'limlar Ro'yhati",
      pagination: categoryCtl.pagination,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenSize.width * 0.15,
              child: SearchTextField(
                hintText: ButtonTexts.search,
                onChanged: (value) => categoryCtl.searchCategory(value),
              ),
            ),
            CheckedAddButton(
              onClick: () {
                categoryCtl.editDialog(context);
              },
              permission: Permissions.create_category.name.toLowerCase(),
              roles: widget.authCtl.userModel.value.roles,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenSize.height / 60,
          ),
          child: Obx(
            () => DataList(
              isLoading: categoryCtl.isLoading.value,
              isNotEmpty: categoryCtl.list.isNotEmpty,
              child: CategoryTable(
                categoryCtl: categoryCtl,
                categories: categoryCtl.list,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
