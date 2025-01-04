import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/media/paddings.dart';
import '../../../utils/texts/display_texts.dart';
import '../../shared/widgets/app_bar.dart';
import '../logic/report_ctl.dart';
import 'widgets/report_list.dart';

class ReportDocsScreen extends StatefulWidget {
  const ReportDocsScreen({super.key});

  @override
  State<ReportDocsScreen> createState() => _ReportDocsScreenState();
}

class _ReportDocsScreenState extends State<ReportDocsScreen> {
  final ReportCtl reportCtl = Get.find<ReportCtl>();

  @override
  void initState() {
    reportCtl.fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: paddingSH16.copyWith(top: 10),
        child: Column(
          children: [
            const TopBar(text: DisplayTexts.report),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ReportList(
                reportCtl: reportCtl,
              ),
            )
          ],
        ),
      ),
    );
  }
}
