import 'package:flutter/material.dart';
import 'package:osonkassa/app/features/shared/export_commons.dart';

import '../../../styles/text_styles.dart';

class Pagination extends StatefulWidget {
  final int count;
  final Function(int) onClick;

  const Pagination({
    super.key,
    required this.count,
    required this.onClick,
  });

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int currect_index = 1;

  void select(int selected_index) {
    setState(() {
      currect_index = selected_index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.count > 1
        ? ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            width: 5,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: widget.count,
          itemBuilder: (context, index) {
            return PaginationItem(
              is_selected: currect_index == index + 1,
              index: index + 1,
              onClick: (p0) {
                widget.onClick(p0);
                select(p0);
              },
            );
          },
        )
        : const SizedBox.shrink();
  }
}

class PaginationItem extends StatelessWidget {
  final int index;
  final bool is_selected;
  final Function(int) onClick;

  const PaginationItem(
      {super.key,
      required this.index,
      required this.onClick,
      required this.is_selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick(index);
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width / 60,
        height: MediaQuery.sizeOf(context).height / 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          shape: BoxShape.circle,
          color: is_selected ? Color(0xFF7367ef) : Colors.transparent,
        ),
        child: Text(
          (index).toString(),
          style: textStyleBlack18.copyWith(
              fontWeight: is_selected ? FontWeight.bold : FontWeight.normal,
              color: is_selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
