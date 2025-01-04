import 'package:flutter/material.dart';

import 'loading.dart';
import 'no_data.dart';

class DataList extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final bool isNotEmpty;

  const DataList({
    super.key,
    required this.child,
    required this.isLoading,
    required this.isNotEmpty,
  });

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Loading();
    } else {
      if (widget.isNotEmpty) {
        return SingleChildScrollView(
          child: widget.child,
        );
      } else {
        return const NoData();
      }
    }
  }
}
