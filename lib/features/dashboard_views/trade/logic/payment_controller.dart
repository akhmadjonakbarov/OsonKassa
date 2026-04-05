import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osonkassa/features/dashboard_views/customer/domain/models/customer.dart';
import 'package:osonkassa/features/dashboard_views/trade/logic/trade_repository.dart';
import 'package:osonkassa/features/dashboard_views/trade/models/order.dart';
import 'package:osonkassa/features/dashboard_views/trade/models/order_item.dart';
import 'package:osonkassa/features/dashboard_views/trade/views/controllers/payment_event.dart';

import '../../../../config/dio_provider.dart';
import '../../../../utils/globals.dart';

class PaymentController extends GetxController {
  late TradeRepository tradeRepository;

  Rxn<PaymentEvent> paymentEvents = Rxn<PaymentEvent>();

  @override
  void onInit() {
    Dio dio = DioProvider().createDio();
    tradeRepository = TradeRepository(dio);
    super.onInit();
  }

  Future<bool> pay(
    Order order, {
    Customer? customer,
    double remainMoney = 0,
    bool isDebt = false,
  }) async {
    List<Map<String, dynamic>> productList = [];
    for (OrderItem orderItem in order.items!) {
      productList.add(orderItem.toJson());
    }
    Map<String, dynamic> data = {
      "sold_products": productList,
      "customer_id": customer == null ? -1 : customer.id,
      "is_debt": remainMoney > 0.0 ? true : isDebt,
      "remain_money": isDebt ? remainMoney : 0.0,
      "discount": order.discountPrice
    };
    try {
      bool isSuccess = await tradeRepository.sell(data);
      if (isSuccess) {
        messengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text('payment completed successfully'.tr),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      return isSuccess;
    } catch (e) {
      return false;
    }
  }
}
