import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/app_views.dart';
import '../../../../styles/icons.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../dashboard_views/note/logic/note_controller.dart';
import '../../../shared/export_commons.dart';
import '../../logic/controllers/dashboard_controller.dart';

class SideBar extends StatefulWidget {
  final DashboardCtl dashboardController;

  const SideBar({
    super.key,
    required this.dashboardController,
    required this.sizeScreen,
  });

  final Size sizeScreen;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final NoteCtl spiskaCtl = Get.find<NoteCtl>();

  @override
  Widget build(BuildContext context) {
    spiskaCtl.fetchItems();
    return Obx(
      () {
        return CustomContainer(
          width: widget.sizeScreen.width * 0.15,
          margin: EdgeInsets.zero,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Boshqaruv Paneli",
                    style: textStyleBlack18.copyWith(
                        fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              CustomButton(
                isSelecte:
                    widget.dashboardController.isSelected(AppViews.dashboard),
                buttonSize: Size(0, 55),
                text: ButtonTexts.dashboard,
                textStyle: textStyleWhite18W800,
                icon: AppIcons.house,
                buttonBgColor: Colors.transparent,
                onClick: () {
                  widget.dashboardController.changeView(AppViews.dashboard);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              CustomButton(
                isSelecte:
                    widget.dashboardController.isSelected(AppViews.trade),
                buttonSize: const Size(double.infinity, 55),
                text: ButtonTexts.trade,
                textStyle: textStyleWhite18W800,
                icon: AppIcons.house,
                buttonBgColor: Colors.transparent,
                onClick: () {
                  widget.dashboardController.changeView(AppViews.trade);
                },
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 8),
              ),
              CustomButton(
                isSelecte:
                    widget.dashboardController.isSelected(AppViews.category),
                buttonSize: const Size(double.infinity, 55),
                text: ButtonTexts.categories,
                textStyle: textStyleWhite18W800,
                icon: AppIcons.category,
                buttonBgColor: Colors.transparent,
                onClick: () {
                  widget.dashboardController.changeView(AppViews.category);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                isSelecte:
                    widget.dashboardController.isSelected(AppViews.product),
                buttonSize: const Size(double.infinity, 55),
                text: ButtonTexts.products,
                textStyle: textStyleWhite18W800,
                icon: AppIcons.shop,
                buttonBgColor: Colors.transparent,
                onClick: () {
                  widget.dashboardController.changeView(AppViews.product);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                isSelecte:
                    widget.dashboardController.isSelected(AppViews.computer),
                buttonSize: const Size(double.infinity, 55),
                text: ButtonTexts.computers,
                textStyle: textStyleWhite18W800,
                icon: AppIcons.shop,
                buttonBgColor: Colors.transparent,
                onClick: () {
                  widget.dashboardController.changeView(AppViews.computer);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                isSelecte:
                    widget.dashboardController.isSelected(AppViews.document),
                buttonSize: const Size(double.infinity, 55),
                text: ButtonTexts.docs,
                textStyle: textStyleWhite18W800,
                icon: AppIcons.store,
                buttonBgColor: Colors.transparent,
                onClick: () {
                  widget.dashboardController.changeView(AppViews.document);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                isSelecte:
                    widget.dashboardController.isSelected(AppViews.store),
                buttonSize: const Size(double.infinity, 55),
                text: ButtonTexts.store,
                textStyle: textStyleWhite18W800,
                icon: AppIcons.store,
                buttonBgColor: Colors.transparent,
                onClick: () {
                  widget.dashboardController.changeView(AppViews.store);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                isSelecte:
                    widget.dashboardController.isSelected(AppViews.spiska),
                buttonSize: const Size(double.infinity, 50),
                text: ButtonTexts.spiska,
                textStyle: textStyleWhite18W800,
                icon: AppIcons.spiska,
                buttonBgColor: Colors.transparent,
                onClick: () {
                  widget.dashboardController.changeView(AppViews.spiska);
                },
                count: spiskaCtl.list.length,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                isSelecte:
                    widget.dashboardController.isSelected(AppViews.client),
                buttonSize: const Size(double.infinity, 50),
                text: ButtonTexts.clients,
                textStyle: textStyleWhite18W800,
                icon: AppIcons.builder,
                buttonBgColor: Colors.transparent,
                onClick: () {
                  widget.dashboardController.changeView(AppViews.client);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                isSelecte:
                    widget.dashboardController.isSelected(AppViews.currency),
                buttonSize: const Size(double.infinity, 50),
                text: ButtonTexts.currency,
                textStyle: textStyleWhite18W800,
                icon: AppIcons.currency,
                buttonBgColor: Colors.transparent,
                onClick: () {
                  widget.dashboardController.changeView(AppViews.currency);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                isSelecte: widget.dashboardController.isSelected(AppViews.debt),
                buttonSize: const Size(double.infinity, 50),
                text: ButtonTexts.debt,
                textStyle: textStyleWhite18W800,
                icon: AppIcons.debt,
                buttonBgColor: Colors.transparent,
                onClick: () {
                  widget.dashboardController.changeView(AppViews.debt);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
