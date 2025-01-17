import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../styles/text_styles.dart';
import '../../../../utils/media/get_screen_size.dart';
import '../../../../utils/texts/button_texts.dart';
import '../../../../utils/texts/display_texts.dart';
import '../../../shared/export_commons.dart';
import '../logic/note_controller.dart';
import 'table/spiska_table.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  NoteCtl providerCtl = Get.find<NoteCtl>();

  @override
  void initState() {
    providerCtl.fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return CustomContainer(
      child: ListView(
        children: [
          HeaderTitle(
            title: DisplayTexts.providers,
            textStyle: textStyleBlack18.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenSize.width * 0.15,
                    child: SearchTextField(
                      hintText: ButtonTexts.search,
                      onChanged: (value) => providerCtl.searchProvider(value),
                    ),
                  ),
                ],
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
        ],
      ),
    );
  }
}
