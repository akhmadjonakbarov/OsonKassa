import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/shared/models/pagination_model.dart';

import '../../../styles/text_styles.dart';
import '../../../styles/themes.dart';
import '../../../utils/media/get_screen_size.dart';
import '../export_commons.dart';
import 'pagination.dart';

class ContentView extends StatelessWidget {
  final Function(int) onChangePage;
  final Rx<PaginationModel> pagination;
  final List<Widget> children; // Pass list of widgets instead of ListView
  final String title;

  const ContentView(
      {super.key,
      required this.pagination,
      required this.onChangePage,
      required this.children,
      required this.title});

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);

    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                HeaderTitle(
                  title: title,
                  textStyle: textStyleBlack18.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  isList: false,
                ),
                ...children
              ],
            ),
          ),
          Obx(
            () {
              if (pagination.value.pages > 1) {
                return CustomContainer(
                  height: screenSize.height * 0.1 / 1.8,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: Decorations.decoration(),
                  child: Pagination(
                    count: pagination.value.pages,
                    onClick: (index) {
                      onChangePage(index);
                    },
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}
