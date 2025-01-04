import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../styles/chart_colors.dart';
import '../../../dashboard_views/document/models/doc_item_model.dart';
import 'indicator.dart';

class PieChartGraph extends StatefulWidget {
  final List<DocItemModel> data;

  const PieChartGraph({
    super.key,
    required this.data,
  });

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartGraph> {
  int touchedIndex = -1;
  double percentOfProduct = 0.0;

  // Function to sort data
  List<DocItemModel> _sortedData() {
    // Create a copy of the data list and sort it
    List<DocItemModel> sortedData = List.from(widget.data);
    sortedData.sort(
        (a, b) => b.qty.compareTo(a.qty)); // Change sorting criteria as needed
    return sortedData;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      sectionsSpace: 10,
                      centerSpaceRadius: 30,
                      sections: showingSections(),
                    ),
                  )),
            ),
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _sortedData().map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Indicator(
                        textColor: Colors.black,
                        color: PieChartColors.colors[widget.data.indexOf(item) %
                            PieChartColors.colors.length],
                        text: "${item.item.name} ---- (${item.qty}) ",
                        isSquare: true,
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData>? showingSections() {
    final totalValue = widget.data.fold<double>(
      0,
      (sum, item) => sum + item.qty.toDouble(),
    ); // Calculate total value

    return List.generate(
      widget.data.length,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 200.0 : 180.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

        final item = widget.data[i];
        percentOfProduct = (item.qty.toDouble()) / totalValue * 100;

        return PieChartSectionData(
          color: PieChartColors
              .colors[widget.data.indexOf(item) % PieChartColors.colors.length],
          value: percentOfProduct,
          title: '${item.item.name} ${percentOfProduct.toStringAsFixed(1)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: ChartColors.mainTextColor1,
            shadows: shadows,
          ),
        );
      },
    );
  }
}
