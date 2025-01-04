import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/report_ctl.dart';
import '../../models/report_model.dart';
import 'report_box.dart';

class ReportList extends StatefulWidget {
  final ReportCtl reportCtl;
  const ReportList({
    super.key,
    required this.reportCtl,
  });

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: widget.reportCtl.list.length,
        itemBuilder: (context, index) {
          ReportModel report = widget.reportCtl.list[index];
          if (report.value.isNotEmpty) {
            return ReportBox(report: report);
          } else {
            return const SizedBox
                .shrink(); // Add a blank space to fill the grid cell.
          }
        },
      ),
    );
  }
}
