import 'package:flutter/material.dart';

import '../../../utils/media/paddings.dart';
import '../../../utils/texts/display_texts.dart';
import '../../shared/widgets/app_bar.dart';
import 'widgets/list_chart.dart';

class StoreReportScreen extends StatefulWidget {
  const StoreReportScreen({
    super.key,
  });

  @override
  State<StoreReportScreen> createState() => _StoreReportScreenState();
}

class _StoreReportScreenState extends State<StoreReportScreen> {
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ListChart(
                    heigth: constraints.maxHeight * 1,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
