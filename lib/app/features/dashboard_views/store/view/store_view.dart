import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/app_paths.dart';
import '../../../../core/enums/filter_field.dart';
import '../../../../styles/container_decoration.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/pagination.dart';
import '../logic/store_ctl.dart';
import 'table/store_table.dart';

class StoreView extends StatefulWidget {
  final StoreCtl storeCtl;
  const StoreView({super.key, required this.storeCtl});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  StoreCtl storeCtl = Get.find<StoreCtl>();
  final GlobalKey _sortButtonKey = GlobalKey();

  @override
  void initState() {
    reloadLists();
    super.initState();
  }

  void reloadLists() {
    storeCtl.fetchItems();
  }

  void _showPopupMenu(BuildContext context) async {
    final RenderBox button =
        _sortButtonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
        button.localToGlobal(Offset.zero) & button.size,
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem<String>(
          value: FilterField.name.name,
          child: const Text(ButtonTexts.sort_by_name),
        ),
        PopupMenuItem<String>(
          value: FilterField.qty.name,
          child: const Text(ButtonTexts.sort_by_price),
        ),
      ],
    );

    if (selected != null) {
      if (selected == FilterField.qty.name) {
        storeCtl.sortItemsByQuantity();
      } else if (selected == FilterField.name.name) {
        storeCtl.sortItemByName();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    reloadLists();
    Size screenSize = getScreenSize(context);

    return AppContainer(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTitle(
            title: "Ombor",
            textStyle: textStyleBlack18.copyWith(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
            isList: false,
          ),
          AppContainer(
            height: MediaQuery.sizeOf(context).height * 0.82,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: containerDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      key: _sortButtonKey,
                      onPressed: () => _showPopupMenu(context),
                      icon: const Icon(
                        Icons.sort_sharp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.01,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.15,
                      child: SearchTextField(
                        hintText:
                            "${ButtonTexts.search} | ${DisplayTexts.name_of_product}",
                        onChanged: (p0) => storeCtl.searchProduct(p0),
                      ),
                    ),
                    DialogTextButton(
                      text: ButtonTexts.statistics,
                      onClick: () => Get.toNamed(AppPaths.storeStatistic),
                      textStyle: textStyleBlack18,
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.63,
                  child: Obx(
                    () => DataList(
                      isLoading: storeCtl.isLoading.value,
                      isNotEmpty: storeCtl.list.isNotEmpty,
                      child: StoreTable(
                        storeCtl: storeCtl,
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  if (storeCtl.pagination.value.pages > 1) {
                    return Pagination(
                      count: storeCtl.pagination.value.pages,
                      onClick: (index) {
                        storeCtl.selectPage(index);
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
