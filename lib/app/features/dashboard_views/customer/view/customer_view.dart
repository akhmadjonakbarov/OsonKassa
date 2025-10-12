import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/styles/app_colors.dart';
import 'package:osonkassa/design_system/buttons/primary_button.dart';

import '../../../../core/enums/filter_field.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../customer_detail/logic/customer_detail_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/content_view.dart';
import '../logic/customer_ctl.dart';
import 'table/customer_table.dart';
import 'widgets/customer_edit_dialog.dart';
import 'widgets/customer_statistics.dart';

class CustomerView extends StatefulWidget {
  final CustomerCtl customerCtl;
  final AuthCtl authCtl;

  const CustomerView({
    super.key,
    required this.customerCtl,
    required this.authCtl,
  });

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  final GlobalKey _sortButtonKey = GlobalKey();
  late CustomerDetailCtl customerDetailCtl;

  @override
  void didChangeDependencies() {
    customerDetailCtl = Get.find<CustomerDetailCtl>();
    customerDetailCtl.calculateTotalDebtsPrice(context);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    widget.customerCtl.fetchItems();
    super.initState();
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
        widget.customerCtl.sortByCreatedAt();
      } else if (selected == FilterField.name.name) {
        widget.customerCtl.sortByName();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return ContentView(
      onChangePage: (p0) {
        widget.customerCtl.selectPage(p0);
      },
      title: DisplayTexts.builders,
      pagination: widget.customerCtl.pagination,
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
                    onChanged: (value) =>
                        widget.customerCtl.searchBuilder(value),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                PrimaryButton(
                  backgroundColor: ButtonColors.primary,
                  onClick: () {},
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      child: Text(
                        "Pay for debt",
                        style: textStyleWhite18,
                      )),
                )
              ],
            ),
            CheckedAddButton(
              onClick: () {
                Get.dialog(const CustomerEditDialog());
              },
              permission: "create_customer",
              roles: widget.authCtl.userModel.value.roles,
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 256),
          height: screenSize.height * 0.12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Statistics",
                style: textStyleBlack20.copyWith(fontSize: 25),
              ),
              CustomerStatistics(
                  screenSize: screenSize,
                  widget: widget,
                  customerDetailCtl: customerDetailCtl),
            ],
          ),
        ),
        SizedBox(
          height: screenSize.height * 0.01 / 2,
        ),
        CustomerTable(
          controller: widget.customerCtl,
        ),
      ],
    );
  }
}
