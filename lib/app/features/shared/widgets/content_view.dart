import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/auth/models/user_model.dart';
import 'package:osonkassa/app/features/shared/models/pagination_model.dart';

import '../../../styles/text_styles.dart';
import '../../../styles/themes.dart';
import '../../../utils/formatter_functions/formatter_currency.dart';
import '../../../utils/media/get_screen_size.dart';
import '../../../utils/texts/button_texts.dart';
import '../export_commons.dart';
import 'pagination.dart';

class ContentView extends StatelessWidget {
  final Function(int) onChangePage;
  final Rx<PaginationModel> pagination;
  final Widget child;

  const ContentView(
      {super.key,
      required this.pagination,
      required this.onChangePage,
      required this.child});
  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);

    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: child),
          CustomContainer(
            height: screenSize.height * 0.1 / 1.8,
            margin: const EdgeInsets.only(top: 5),
            decoration: Decorations.decoration(),
            child: Obx(
              () => Pagination(
                count: pagination.value.pages,
                onClick: (index) {
                  onChangePage(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
