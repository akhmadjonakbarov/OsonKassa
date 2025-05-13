import 'package:osonkassa/app/features/customer_detail/models/purchase.dart';

import 'customer_detail_repository.dart';

class CustomerDetailService {
  final PurchaseRepository purchaseRepository;

  CustomerDetailService({required this.purchaseRepository});

  Future<List<Purchase>> getPurchasesByCustomerId(
      {required int customerId}) async {
    final purchases = await purchaseRepository.getPurchasesByCustomerId(
        customerId: customerId);
    return purchases.where(
      (element) {
        return element.isDebt != true;
      },
    ).toList();
  }

  Future<List<Purchase>> getDebtsByCustomerId({required int customerId}) async {
    final purchases = await purchaseRepository.getPurchasesByCustomerId(
        customerId: customerId);
    return purchases.where(
      (element) {
        return element.isDebt == true;
      },
    ).toList();
  }

  Future<List<Purchase>> getPurchases() async {
    final purchases = await purchaseRepository.getPurchases();
    return purchases
        .where(
          (element) => element.isDebt != true,
        )
        .toList();
  }

  Future<List<Purchase>> getDebts() async {
    final purchases = await purchaseRepository.getPurchases();
    return purchases
        .where(
          (element) => element.isDebt == true,
        )
        .toList();
  }
}
