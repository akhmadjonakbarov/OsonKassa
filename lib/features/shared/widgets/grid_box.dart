import 'package:flutter/material.dart';

class GridBox extends StatefulWidget {
  final Widget child;
  const GridBox({super.key, required this.child});

  @override
  State<GridBox> createState() => _GridBoxState();
}

class _GridBoxState extends State<GridBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        child: widget.child,
      ),
    );
  }
}
