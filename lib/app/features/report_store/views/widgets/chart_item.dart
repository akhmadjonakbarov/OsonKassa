import 'package:flutter/material.dart';

import '../../../../styles/colors.dart';
import '../../../shared/widgets/header_title.dart';
import '../../../dashboard_views/category/models/category_models.dart';
import '../../../dashboard_views/store/logic/store_ctl.dart';
import '../charts/pie_chart.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.height,
    required this.categoryModel,
    required this.storeCtl,
  });

  final double height;
  final CategoryModel categoryModel;
  final StoreCtl storeCtl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      height: height,
      child: Column(
        children: [
          HeaderTitle2(title: categoryModel.name),
          PieChartGraph(
            data: storeCtl.list
                    .where(
                      (p0) => p0.item.category.id == categoryModel.id,
                    )
                    .toList()
                    .isNotEmpty
                ? storeCtl.list
                    .where(
                      (p0) => p0.item.category.id == categoryModel.id,
                    )
                    .toList()
                : [], // Convert Iterable to List
          ),
        ],
      ),
    );
  }
}
