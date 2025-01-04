// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/enums/filter_field.dart';
import '../../../../core/permission_checker/permission_checker.dart';
import '../../../../styles/container_decoration.dart';

import '../../../../styles/text_styles.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../shared/export_commons.dart';
import '../logic/client_ctl.dart';
import 'table/client_table.dart';

class CustomerView extends StatefulWidget {
  final ClientCtl clientCtl;
  CustomerView({
    Key? key,
    required this.clientCtl,
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
    return Stack(
      children: [
        AppContainer(
          padding: EdgeInsets.zero,
          decoration: const BoxDecoration(),
          height: screenSize.height * 0.9,
          child: ListView(
            children: [
              HeaderTitle(
                title: DisplayTexts.builders,
                textStyle: textStyleBlack18.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              AppContainer(
                decoration: containerDecoration,
                child: Column(
                  children: [
                    AppContainer(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: const BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                key:
                                    _sortButtonKey, // Assign the key to the button
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
                                  onChanged: (value) =>
                                      widget.clientCtl.searchBuilder(value),
                                ),
                              ),
                            ],
                          ),
                          if (screenSize.width <= 1370)
                            SizedBox(
                              width: screenSize.width * 0.1,
                              child: PermissionChecker.addButton(
                                'admin',
                                () {
                                  widget.clientCtl.editDialog(context);
                                },
                                Size(0, screenSize.height * 0.06),
                              ),
                            )
                          else
                            SizedBox(
                              width: screenSize.width * 0.08,
                              child: PermissionChecker.addButton(
                                'admin',
                                () {
                                  widget.clientCtl.editDialog(context);
                                },
                                Size(0, screenSize.height * 0.05),
                              ),
                            ),
                        ],
                      ),
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
