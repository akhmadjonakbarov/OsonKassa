import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/customer_detail/logic/customer_detail_ctl.dart';
import 'package:osonkassa/app/styles/icons.dart';
import 'package:osonkassa/app/styles/text_styles.dart';
import 'package:osonkassa/app/utils/formatter_functions/formatter_currency.dart';

import '../../../../core/enums/filter_field.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../../shared/widgets/content_view.dart';
import '../logic/customer_ctl.dart';
import 'table/client_table.dart';

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
    widget.customerCtl.fetchItems();

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
              ],
            ),
            CheckedAddButton(
              onClick: () {
                widget.customerCtl.editDialog(context);
              },
              permission: "create_customer",
              roles: widget.authCtl.userModel.value.roles,
            )
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 256),
          height: screenSize.height * 0.12,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Statistics",
                  style: textStyleBlack20.copyWith(fontSize: 25),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: SvgPicture.asset(
                              AppIcons.person,
                              height: screenSize.height * 0.1 / 2.8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding:
                                EdgeInsets.all(screenSize.height * 0.1 / 25),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${widget.customerCtl.list.length} ta",
                                style: textStyleBlack20,
                              ),
                              Text(
                                "Mijozlar",
                                style: textStyleBlack15,
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Icon(
                              CupertinoIcons.money_dollar_circle,
                              size: screenSize.height * 0.1 / 2.8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding:
                                EdgeInsets.all(screenSize.height * 0.1 / 25),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${PriceFomatter.formatPrice(customerDetailCtl.totalDebtsPrice.value)} uzs",
                                style: textStyleBlack20,
                              ),
                              Text(
                                "Qarzlar",
                                style: textStyleBlack15,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: screenSize.height * 0.01 / 2,
        ),
        Obx(
          () {
            return DataList(
              isLoading: widget.customerCtl.isLoading.value,
              isNotEmpty: widget.customerCtl.list.isNotEmpty,
              child: ClientTable(
                builderController: widget.customerCtl,
              ),
            );
          },
        ),
      ],
    );
  }
}
