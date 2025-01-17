import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/enums/product_doc_type.dart';
import '../../../../../core/permission/permissions.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../utils/media/get_screen_size.dart';
import '../../../../../utils/texts/button_texts.dart';
import '../../../../auth/logic/controllers/auth_ctl.dart';
import '../../../../dashboard/logic/controllers/dashboard_controller.dart';
import '../../../../shared/export_commons.dart';
import '../../../../shared/widgets/content_view.dart';
import '../../logic/document/document_ctl.dart';
import 'table/document_table.dart';

class DocumentView extends StatefulWidget {
  final AuthCtl authCtl;
  final DocumentCtl documentCtl;

  const DocumentView(
      {super.key, required this.authCtl, required this.documentCtl});

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  DashboardCtl dashboardCtl = Get.find<DashboardCtl>();
  DocumentCtl documentCtl = Get.find<DocumentCtl>();

  final GlobalKey _sortButtonKey = GlobalKey();

  @override
  void didChangeDependencies() {
    documentCtl.fetchItems();
    super.didChangeDependencies();
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
          labelTextStyle: WidgetStatePropertyAll(textStyleBlack18),
          value: ProductDocType.sell.name,
          child: const Text(ButtonTexts.sold),
        ),
        PopupMenuItem<String>(
          labelTextStyle: WidgetStatePropertyAll(textStyleBlack18),
          value: ProductDocType.buy.name,
          child: const Text(ButtonTexts.received),
        ),
      ],
    );

    if (selected != null) {
      if (selected == ProductDocType.sell.name) {
        documentCtl.sortBySell();
      } else {
        documentCtl.sortByBuy();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return ContentView(
      pagination: documentCtl.pagination,
      onChangePage: (p0) {
        documentCtl.selectPage(p0);
      },
      title: "Ombor",
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  key: _sortButtonKey,
                  onPressed: () => _showPopupMenu(context),
                  icon: const Icon(
                    Icons.sort,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: screenSize.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => DialogTextButton(
                          text: documentCtl.isToday.value
                              ? "Hammasi"
                              : "Bugunilik",
                          textStyle: textStyleWhite18,
                          onClick: () => documentCtl.setToday(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CheckedAddButton(
              onClick: () {},
              permission: Permissions.create_document.name,
              roles: widget.authCtl.userModel.value.roles,
            )
          ],
        ),
        Obx(
          () => DataList(
            isLoading: documentCtl.isLoading.value,
            isNotEmpty: documentCtl.list.isNotEmpty,
            child: DocumentTable(
              documentCtl: documentCtl,
            ),
          ),
        ),
      ],
    );
  }
}
