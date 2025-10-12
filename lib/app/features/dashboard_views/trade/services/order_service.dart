import 'package:get/get.dart';
import 'package:osonkassa/app/features/dashboard_views/trade/models/order.dart';

class OrderService {
  static Order? getOrder(List<Order> orders, Order order) {
    return orders.firstWhereOrNull(
      (element) => element.id == order.id,
    );
  }

  static List<Order> removeOrder(List<Order> orders, Order order) {
    orders.removeWhere(
      (element) => element.id == order.id,
    );
    return orders;
  }
}
