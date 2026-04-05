import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../store/models/store_item.dart';
import '../../../../utils/helper/log_helper.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../core/enums/type_of_snackbar.dart';
import '../../../report_docs/logic/report_ctl.dart';
import 'trade_repository.dart';
import 'trade_service.dart';

class TradeController extends GetxController {
  var sellProducts = <StoreItem>[].obs;

  late TradeRepository tradeRepository;
  late TradeService tradeService;

  final ReportCtl reportCtl = Get.find<ReportCtl>();

  @override
  void onInit() {
    Dio dio = DioProvider().createDio();
    tradeRepository = TradeRepository(dio);
    tradeService = TradeService(tradeRepository);

    super.onInit();
  }

  clearData() async {
    sellProducts([]);
  }

  setSellStoreItem(StoreItem item) {
    int existingItemOfIndex = sellProducts
        .indexWhere((element) => element.item!.barcode! == item.item!.barcode!);
    LogHelper.logInfo("ProductIndex: $existingItemOfIndex");
    if (existingItemOfIndex <= -1) {
      sellProducts.insert(
        0,
        StoreItem(
          qty: 1,
          item: item.item,
          incomePrice: item.incomePrice,
          salePrice: item.salePrice,
          currency: item.currency,
        ),
      );
    } else {
      final currenItem = sellProducts[existingItemOfIndex];
      final updatedItem = currenItem.copyWith(qty: currenItem.qty! + 1);
      sellProducts[existingItemOfIndex] = updatedItem;
    }
  }

  removeItem(String barcode) {
    try {
      sellProducts
          .removeWhere((storeItem) => storeItem.item!.barcode! == barcode);
    } catch (e) {
      UserNotifier.showSnackBar(
        text: e.toString(),
        type: TypeOfSnackBar.delete,
      );
    }
  }
}
