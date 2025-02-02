import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../styles/colors.dart';
import '../../../../../styles/text_styles.dart';
import '../../../../../utils/media/get_screen_size.dart';
import '../../../../shared/export_commons.dart';
import '../../../document/models/doc_item_model.dart';

class SellProductItem extends StatefulWidget {
  final Function() onEdit;
  final Function() incrementQty;
  final Function() decrementQty;
  final Function() deleteItem;
  final Function() cheapenClick;
  final DocItemModel sellProductDocItem;
  final double height;

  const SellProductItem({
    super.key,
    required this.height,
    required this.onEdit,
    required this.sellProductDocItem,
    required this.incrementQty,
    required this.decrementQty,
    required this.deleteItem,
    required this.cheapenClick,
  });

  @override
  State<SellProductItem> createState() => _SellProductItemState();
}

class _SellProductItemState extends State<SellProductItem> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: widget.height,
      decoration: BoxDecoration(
        color: bgButtonColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "(${widget.sellProductDocItem.item.category.name}) ${widget.sellProductDocItem.item.name}",
                style: textStyleBlack18,
              ),
              Text(
                widget.sellProductDocItem.item.barcode,
                style: textStyleBlack14.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AddingMinusingButton(
                onClick: widget.incrementQty,
                iconSize: 25,
                icon: CupertinoIcons.add_circled_solid,
                iconColor: Colors.green,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.sellProductDocItem.qty.toStringAsFixed(0),
                          textAlign: TextAlign.center,
                          style: textStyleBlack18.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 2),
                        // Text(
                        //   widget.sellProductDocItem.item.units
                        //       .firstWhere(
                        //         (element) =>
                        //             element.value.toLowerCase() == 'kg',
                        //       )
                        //       .value,
                        //   textAlign: TextAlign.center,
                        //   style: textStyleBlack14,
                        // )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.sellProductDocItem.qty.toStringAsFixed(0),
                          textAlign: TextAlign.center,
                          style: textStyleBlack18.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 2),
                        // Text(
                        //   widget.sellProductDocItem.item.units
                        //       .firstWhere(
                        //         (element) =>
                        //             element.value.toLowerCase() == 'qop',
                        //       )
                        //       .value,
                        //   textAlign: TextAlign.center,
                        //   style: textStyleBlack14,
                        // )
                      ],
                    ),
                  ],
                ),
              ),
              AddingMinusingButton(
                onClick: widget.decrementQty,
                iconSize: 25,
                icon: CupertinoIcons.minus_circle_fill,
                iconColor: Colors.red,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${widget.sellProductDocItem.selling_price.toStringAsFixed(2)} ${widget.sellProductDocItem.currency_type}",
                      style: textStyleBlack18.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.009,
                  ),
                  const Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "${widget.sellProductDocItem.income_price.toStringAsFixed(2)} ${widget.sellProductDocItem.currency_type}",
                    style: textStyleBlack18.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.009,
                  ),
                  const Icon(
                    Icons.arrow_downward,
                    color: Colors.red,
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
                onPressed: widget.onEdit,
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: widget.deleteItem,
              )
            ],
          )
        ],
      ),
    );
  }
}
