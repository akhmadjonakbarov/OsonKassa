import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/shared/widgets/pagination.dart';
import 'package:osonkassa/app/styles/themes.dart';

import '../../../../styles/container_decoration.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/table_bar.dart';
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
    return CustomContainer(
      child: ListView(
        children: [
          HeaderTitle(
            title: "Bo'limlar Ro'yhati",
            textStyle: textStyleBlack18.copyWith(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    // TableBar(
                    //   screenSize: screenSize,
                    //   onEdit: () => categoryCtl.editDialog(context),
                    //   onSearch: (value) => categoryCtl.searchCategory(value),
                    //   role: widget.authCtl.userModel.value.employee.role.role,
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.sizeOf(context).height * 0.63,
                    //   child: Obx(
                    //     () => DataList(
                    //       isLoading: categoryCtl.isLoading.value,
                    //       isNotEmpty: categoryCtl.list.isNotEmpty,
                    //       child: CategoryTable(
                    //         categoryCtl: categoryCtl,
                    //         categories: categoryCtl.list,
                    //         isSeller: widget.authCtl.isSeller.value,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Pagination(
                  count: categoryCtl.pagination.value.pages,
                  onClick: (p0) {
                    categoryCtl.selectPage(p0);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
