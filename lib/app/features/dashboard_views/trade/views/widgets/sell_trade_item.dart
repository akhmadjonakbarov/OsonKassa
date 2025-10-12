import 'package:flutter/material.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/models/order_item.dart';

import '../../../../../styles/text_styles.dart';
import '../../../../../utils/formatter_functions/formatter_currency.dart';

class SellProductItem extends StatelessWidget {
  final Function() onEdit;
  final Function() incrementQty;
  final Function() decrementQty;
  final Function() deleteItem;
  final Function() cheapenClick;
  final OrderItem product;
  final double height;

  const SellProductItem({
    super.key,
    required this.height,
    required this.onEdit,
    required this.product,
    required this.incrementQty,
    required this.decrementQty,
    required this.deleteItem,
    required this.cheapenClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          // Product info
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? "",
                  style: textStyleBlack18.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.barcode ?? "",
                  style: textStyleBlack14.copyWith(
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Qty control
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onEdit,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.qty!.toStringAsFixed(2),
                      style: textStyleBlack18.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.unit ?? "",
                      style: textStyleBlack14.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Price tag
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                PriceFomatter.formatPrice(
                  product.salePrice! * product.qty!,
                ),
                textAlign: TextAlign.center,
                style: textStyleBlack20.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Delete button
          IconButton(
            onPressed: deleteItem,
            icon: const Icon(Icons.delete_forever),
            color: Colors.redAccent,
            iconSize: 28,
            tooltip: "Remove item",
          ),
        ],
      ),
    );
  }
}

/// Custom Qty Button for + / -
class _QtyButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QtyButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.15),
        ),
        child: Icon(
          icon,
          size: 20,
          color: color,
        ),
      ),
    );
  }
}
