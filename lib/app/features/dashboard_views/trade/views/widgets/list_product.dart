import 'package:flutter/widgets.dart';

import '../../../document/models/doc_item_model.dart';
import '../../logic/trade_ctl.dart';
import 'sell_trade_item.dart';

class ListSellProduct extends StatelessWidget {
  final BoxConstraints constraints;

  final TradeCtl tradeCtl;
  const ListSellProduct({
    super.key,
    required this.tradeCtl,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: tradeCtl.sellProductDocItems.length,
          itemBuilder: (context, index) {
            DocItemModel sellProductDocItem =
                tradeCtl.sellProductDocItems[index];
            return SellProductItem(
              onEdit: () => tradeCtl.editProduct(context, sellProductDocItem),
              cheapenClick: () => tradeCtl.calculateDiscount(
                sellProductDocItem.item.barcode,
              ),
              decrementQty: () => tradeCtl.decrementQty(
                sellProductDocItem.item.barcode,
              ),
              incrementQty: () => tradeCtl.incrementQty(
                sellProductDocItem.item.barcode,
              ),
              deleteItem: () => tradeCtl.deleteItemFromSelledProductList(
                sellProductDocItem.item.barcode,
              ),
              sellProductDocItem: sellProductDocItem,
              height: MediaQuery.sizeOf(context).width <= 1370
                  ? constraints.maxHeight * 0.1
                  : constraints.maxHeight * 0.08,
            );
          },
        ),
      ),
    );
  }
}
