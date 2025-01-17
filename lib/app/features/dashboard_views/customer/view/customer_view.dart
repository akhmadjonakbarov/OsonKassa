// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/auth/logic/controllers/auth_ctl.dart';
import 'package:osonkassa/app/features/shared/widgets/content_view.dart';

import '../../../../core/enums/filter_field.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../shared/export_commons.dart';
import '../logic/client_ctl.dart';
import 'table/client_table.dart';

class CustomerView extends StatefulWidget {
  final ClientCtl clientCtl;
  final AuthCtl authCtl;

  CustomerView({
    Key? key,
    required this.clientCtl,
    required this.authCtl,
  }) : super(key: key);

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  final GlobalKey _sortButtonKey = GlobalKey();

  @override
  void didChangeDependencies() {
    widget.clientCtl.fetchItems();

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
          value: FilterField.name.name,
          child: const Text(ButtonTexts.sort_by_name),
        ),
        PopupMenuItem<String>(
          value: FilterField.created_at.name,
          child: const Text(ButtonTexts.sort_by_adding_time),
        ),
      ],
    );
    if (selected != null) {
      if (selected == FilterField.created_at.name) {
        widget.clientCtl.sortByCreatedAt();
      } else if (selected == FilterField.name.name) {
        widget.clientCtl.sortByName();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return ContentView(
      onChangePage: (p0) {
        widget.clientCtl.selectPage(p0);
      },
      title: DisplayTexts.builders,
      pagination: widget.clientCtl.pagination,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  key: _sortButtonKey, // Assign the key to the button
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
                    onChanged: (value) => widget.clientCtl.searchBuilder(value),
                  ),
                ),
              ],
            ),
            CheckedAddButton(
              onClick: () {},
              permission: "create_customer",
              roles: widget.authCtl.userModel.value.roles,
            )
          ],
        ),
        Obx(
          () {
            return DataList(
              isLoading: widget.clientCtl.isLoading.value,
              isNotEmpty: widget.clientCtl.list.isNotEmpty,
              child: ClientTable(
                builderController: widget.clientCtl,
              ),
            );
          },
        ),
      ],
    );
  }
}
