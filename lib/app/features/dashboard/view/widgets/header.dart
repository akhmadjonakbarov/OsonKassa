import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../config/app_paths.dart';
import '../../../../config/app_views.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../../styles/app_colors.dart';
import '../../../../styles/container_decoration.dart';
import '../../../../styles/icons.dart';
import '../../../../styles/text_styles.dart';
import '../../../../styles/themes.dart';
import '../../../../utils/formatter_functions/formatter_currency.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../auth/logic/controllers/auth_ctl.dart';
import '../../../dashboard_views/statistics/logic/statistics_ctl.dart';
import '../../../dashboard_views/statistics/view/widgets/statistics_item.dart';
import '../../../dashboard_views/store/logic/store_ctl.dart';
import '../../../report_docs/logic/report_ctl.dart';
import '../../../shared/export_commons.dart';
import '../../logic/controllers/dashboard_controller.dart';

class Header extends StatefulWidget {
  final ReportCtl reportCtl;
  final StoreCtl storeCtl;
  final StatisticsCtl statisticsCtl;
  final DashboardCtl dashboardCtl;
  final AuthCtl authCtl;

  const Header({
    super.key,
    required this.authCtl,
    required this.reportCtl,
    required this.storeCtl,
    required this.statisticsCtl,
    required this.dashboardCtl,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final GlobalKey _menuKey = GlobalKey();

  void _showMenu() {
    final RenderBox renderBox =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + 15,
        offset.dx + size.width,
        offset.dy,
      ),
      items: [
        const PopupMenuItem<String>(
          value: AppPaths.profile,
          child: SizedBox(
            width: 150,
            child: ListTile(
              leading: Icon(Icons.person_2),
              title: Text('Shaxsiy bo\'lim'),
            ),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: SizedBox(
            width: 100,
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(ButtonTexts.exit),
            ),
          ),
        ),
      ],
    ).then((value) {
      switch (value) {
        case 'profile_page':
          Get.toNamed(AppPaths.profile);
          break;
        case 'logout':
          _logout();
          break;
      }
    });
  }

  void _logout() {
    widget.authCtl.logout();
  }

  OverlayEntry? _overlayEntry;

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(builder: (context) {
      return Positioned(
        width: MediaQuery.of(context).size.width * 0.5,
        left: offset.dx,
        top: offset.dy + renderBox.size.height + 3,
        child: Material(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.transparent,
          elevation: 4.0,
          child: MouseRegion(
            onEnter: (_) {
              _showOverlay();
            },
            onExit: (_) {
              _hideOverlay();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppContainer(
                  height: MediaQuery.of(context).size.height * 0.18,
                  decoration: containerDecoration,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ButtonTexts.statistics,
                            style: textStyleBlack18.copyWith(fontSize: 28),
                          ),
                          IconButton(
                            onPressed: () => _hideOverlay(),
                            icon: const Icon(
                              Icons.close,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            StatisticsItem(
                              onClick: () {
                                widget.dashboardCtl.changeView(AppViews.store);
                                _hideOverlay();
                              },
                              backgroundColor: Colors.redAccent,
                              icon: AppIcons.store,
                              text: widget.storeCtl.totalProductQty.toString(),
                              subText: DisplayTexts.products,
                            ),
                            StatisticsItem(
                              style: textStyleBlack18.copyWith(fontSize: 16),
                              onClick: () {},
                              backgroundColor: Colors.green,
                              icon: AppIcons.stock,
                              text: "${formatUZSNumber(
                                widget.statisticsCtl.total_profit.toDouble(),
                              )} USD",
                              subText: DisplayTexts.profit_of_month,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                switch (MediaQuery.sizeOf(context).width) {
                  1366 => AppContainer(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: containerDecoration,
                      child: TotalPriceOfProduct(
                        widget: widget,
                      ),
                    ),
                  1920 => AppContainer(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: containerDecoration,
                      child: TotalPriceOfProduct(widget: widget),
                    ),
                  // TODO: Handle this case.
                  double() => throw UnimplementedError(),
                }
              ],
            ),
          ),
        ),
      );
    });
  }

  void _showOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry(context);
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _hideOverlay() async {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    double spaceBtwButtons = 0;
    if (screenSize.width <= 1366) {
      spaceBtwButtons = screenSize.width * 0.19;
    } else {
      spaceBtwButtons = screenSize.width * 0.15;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: Paddings.padding12),
      width: double.infinity,
      height: screenSize.height * 0.1 / 1.5,
      decoration: Decorations.decoration(boxShadow: BoxShadows.custom),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: spaceBtwButtons,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MouseRegion(
                  onEnter: (_) {
                    _showOverlay();
                  },
                  child: BasicButton(
                      text: ButtonTexts.statistics,
                      bgColor: ButtonColors.info,
                      textStyle: TextStyles.buttonTextStyle(
                          fontSize: screenSize.height / 54),
                      height: screenSize.height * 0.1 / 2.5,
                      width: screenSize.width * 0.08),
                ),
                BasicButton(
                  text: "Hisobotlar",
                  onClick: () {
                    if (widget.reportCtl.list.isNotEmpty) {
                      Get.toNamed(AppPaths.reportDocs);
                    } else {
                      UserNotifier.showSnackBar(
                          label: "Hisobotlar mavjud emas!",
                          type: TypeOfSnackBar.alert);
                    }
                  },
                  textStyle: TextStyles.buttonTextStyle(
                      fontSize: screenSize.height / 54),
                  height: screenSize.height * 0.1 / 2.5,
                  width: screenSize.width * 0.06,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.authCtl.userModel.value.firstName,
                    style: textStyleBlack18,
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                key: _menuKey,
                onTap: _showMenu,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: 50,
                    height: 50,
                    color: Colors.red,
                    child: SvgPicture.asset(
                      AppIcons.person,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TotalPriceOfProduct extends StatelessWidget {
  const TotalPriceOfProduct({
    super.key,
    required this.widget,
  });

  final Header widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          DisplayTexts.value_of_products,
          style: textStyleBlack18.copyWith(
              fontSize: 22, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BudgetCard(
                title: "",
                height: 80,
                width: MediaQuery.of(context).size.width * 0.1,
                budgetAmount:
                    "${formatUZSNumber(widget.statisticsCtl.total_value_of_products_usd.value, isAddWord: false)} \$",
                bgColor: Colors.blue,
              ),
              BudgetCard(
                title: "",
                height: 80,
                width: MediaQuery.of(context).size.width * 0.16,
                budgetAmount: formatUZSCurrency(
                    widget.statisticsCtl.total_value_of_products_uzs.value),
                bgColor: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BudgetCard extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final Color bgColor;
  final String budgetAmount;

  const BudgetCard({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    required this.bgColor,
    required this.budgetAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(16)),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            budgetAmount,
            style: textStyleWhite20,
          ),
        ],
      ),
    );
  }
}
