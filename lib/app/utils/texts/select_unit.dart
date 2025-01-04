import 'package:flutter/material.dart';

import '../../features/dashboard_views/document/models/doc_item_model.dart';

class UnitSelectionWidget extends StatefulWidget {
  final DocItemModel doc_item;
  final Function(int) onSelectId;

  const UnitSelectionWidget(
      {required this.doc_item, required this.onSelectId, super.key});

  @override
  _UnitSelectionWidgetState createState() => _UnitSelectionWidgetState();
}

class _UnitSelectionWidgetState extends State<UnitSelectionWidget> {
  int selectedUnitId = 1; // Track selected unit ID

  void _onUnitTap(int id) {
    setState(() {
      selectedUnitId = id;
      widget.onSelectId(id); // Notify the parent widget of the selected unit ID
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 2,
        ),
        itemCount: widget.doc_item.item.units.length,
        itemBuilder: (context, index) {
          final unit = widget.doc_item.item.units[index];
          final isSelected =
              selectedUnitId == unit.id; // Check if the unit is selected

          return GestureDetector(
            onTap: () => _onUnitTap(unit.id), // Handle unit tap
            child: Card(
              color: isSelected
                  ? Colors.green
                  : Colors.transparent, // Change color if selected
              child: Center(
                child: Text(
                  unit.value,
                  style: TextStyle(
                    fontSize: 18,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
