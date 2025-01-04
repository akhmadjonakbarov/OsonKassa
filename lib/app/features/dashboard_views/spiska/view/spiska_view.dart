import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../styles/container_decoration.dart';
import '../../../../styles/text_styles.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../shared/export_commons.dart';
import '../logic/spiska_controller.dart';
import 'table/spiska_table.dart';

class SpiskaView extends StatefulWidget {
  const SpiskaView({super.key});

  @override
  State<SpiskaView> createState() => _SpiskaViewState();
}

class _SpiskaViewState extends State<SpiskaView> {
  SpiskaCtl providerCtl = Get.find<SpiskaCtl>();

  @override
  void initState() {
    providerCtl.fetchItems();
    super.initState();
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
                title: DisplayTexts.providers,
                textStyle: textStyleBlack18.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
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
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: SearchTextField(
                              hintText: ButtonTexts.search,
                              onChanged: (value) =>
                                  providerCtl.searchProvider(value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => DataList(
                        isLoading: providerCtl.isLoading.value,
                        isNotEmpty: providerCtl.list.isNotEmpty,
                        child: SpiskaTable(
                          providerController: providerCtl,
                        ),
                      ),
                    ),
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
