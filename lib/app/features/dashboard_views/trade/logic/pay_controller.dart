import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/core/enums/type_of_snackbar.dart';
import 'package:osonkassa/app/features/dashboard_views/customer/models/customer.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/logic/trade_repository.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/models/order.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/models/order_item.dart';

import '../../../../config/dio_provider.dart';
import '../../../../core/display/user_notifier.dart';
import '../../../../utils/texts/alert_texts.dart';

class PayController extends GetxController {
  late TradeRepository tradeRepository;
  @override
  void onInit() {
    Dio dio = DioProvider().createDio();
    tradeRepository = TradeRepository(dio);
    super.onInit();
  }

  Future<bool> pay(Order order,
      {Customer? customer, bool isDebt = false}) async {
    List<Map<String, dynamic>> productList = [];
    for (OrderItem orderItem in order.items!) {
      productList.add(orderItem.toJson());
    }
    Map<String, dynamic> data = {
      "sold_products": productList,
      "customer_id": customer == null ? -1 : customer.id,
      "is_debt": isDebt,
      "discount": order.discountPrice
    };
    try {
      bool isSuccess = await tradeRepository.sell(data);
      if (isSuccess) {
        UserNotifier.showSnackBar(
          label: AlertTexts.success_trade,
          type: TypeOfSnackBar.success,
        );
      }
      return isSuccess;
    } catch (e) {
      return false;
    }
  }
}
