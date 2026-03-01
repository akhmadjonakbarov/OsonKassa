import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/features/dashboard_views/trade/models/order_item.dart';

import '../../../../../styles/text_styles.dart';
import '../../../../../utils/formatter_functions/formatter_currency.dart';

class SellProductItem extends StatelessWidget {
  final Function() onEdit;
  final Function() incrementQty;
  final Function() decrementQty;
  final Function() deleteItem;
  final Function() cheapenClick;
  final Function() calculateAmountByPrice;
  final OrderItem product;
  final double height;

  const SellProductItem(
      {super.key,
      required this.height,
      required this.onEdit,
      required this.product,
      required this.incrementQty,
      required this.decrementQty,
      required this.deleteItem,
      required this.cheapenClick,
      required this.calculateAmountByPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Product name
          Expanded(
            flex: 3,
            child: Text(
              "${product.name!}${product.itemType != null ? ' (${product.itemType})' : ''}",
              style: textStyleBlack18.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Quantity (editable)
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onEdit,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  "${product.qty?.toStringAsFixed(2)} ${product.unit ?? ''}",
                  style: textStyleBlack18.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Price
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: calculateAmountByPrice,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  PriceFormatter.formatPrice(
                    product.salePrice! * product.qty!,
                  ),
                  style: textStyleBlack18.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),

          const SizedBox(width: 6),

          // Delete icon
          IconButton(
            onPressed: deleteItem,
            icon: const Icon(Icons.close_rounded, size: 20),
            color: Colors.redAccent,
            tooltip: "delete".tr,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
