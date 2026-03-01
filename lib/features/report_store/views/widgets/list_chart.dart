import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dashboard_views/category/logic/category_controller.dart';
import '../../../dashboard_views/store/logic/store_ctl.dart';
import '../../../shared/export_commons.dart';
import 'chart_item.dart';

class ListChart extends StatefulWidget {
  final double heigth;

  const ListChart({
    super.key,
    required this.heigth,
  });

  @override
  State<ListChart> createState() => _ListChartState();
}

class _ListChartState extends State<ListChart> {
  final CategoryCtl categoryCtl = Get.find<CategoryCtl>();

  final StoreCtl storeCtl = Get.find<StoreCtl>();

  @override
  void didChangeDependencies() {
    if (categoryCtl.list.isEmpty) {
      categoryCtl.fetchItems();
    }
    if (storeCtl.list.isEmpty) {
      storeCtl.fetchItems();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // Ensure category list is populated before using
        if (categoryCtl.list.isEmpty) {
          return const Loading();
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.6,
            ),
            itemBuilder: (context, index) {
              final categoryModel = categoryCtl.filteredCategories[index];

              return ListItem(
                height: widget.heigth,
                categoryModel: categoryModel,
                storeCtl: storeCtl,
              );
            },
            itemCount: categoryCtl.filteredCategories.length,
          ),
        );
      },
    );
  }
}
