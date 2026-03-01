// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:osonkassa/features/customer_detail/models/payment_history.dart';
import '../../../core/display/user_notifier.dart';
import '../../../core/enums/type_of_snackbar.dart';
import '../../../utils/helper/log_helper.dart';

import '../../../config/dio_provider.dart';
import '../../dashboard_views/customer/domain/models/transaction.dart';
import '../models/purchase.dart';
import 'customer_detail_repository.dart';
import 'customer_detail_service.dart';
import 'package:flutter/material.dart';

class CustomerDetailCtl extends GetxController {
  // Observables for purchases and debts
  var purchases = <Purchase>[].obs;
  var debts = <Purchase>[].obs;
  var transactions = <Transaction>[].obs;
  var totalDebtsPrice = 0.0.obs;

  // Separate loading flags
  var isLoadingPurchases = false.obs;
  var isLoadingDebts = false.obs;
  var isPaymentHistoriesLoading = false.obs;

  late PurchaseRepository purchaseRepository;
  late CustomerTransactionRepository customerTransactionRepository;
  late CustomerDetailService customerDetailService;

  @override
  void onInit() {
    final Dio dio = DioProvider().createDio();
    purchaseRepository = PurchaseRepository(dio: dio);
    customerDetailService = CustomerDetailService(
      purchaseRepository: purchaseRepository,
    );
    customerTransactionRepository = CustomerTransactionRepository(dio: dio);

    super.onInit();
  }

  void pay({required int customerId, required int purchaseId}) async {
    try {
      bool isPaid = await purchaseRepository.pay(
          customerId: customerId, purchaseId: purchaseId);
      if (isPaid) {
        loadCustomerDetails(customerId);
        LogHelper.logInfo("paid");
        UserNotifier.snackbar(
          label: "Qarz to'landi!",
          type: TypeOfSnackBar.success,
        );
      }
    } catch (e) {
      UserNotifier.snackbar(
        label: "Xatolik yuz berdi!",
        text: e.toString(),
        type: TypeOfSnackBar.error,
      );
    }
  }

  void getPurchasesByCustomerId(BuildContext context, int customerId) async {
    try {
      isLoadingPurchases(true);
      purchases.value = await customerDetailService.getPurchasesByCustomerId(
          customerId: customerId);
    } catch (e) {
      UserNotifier.showFlutterSnackBar(context: context, text: e.toString());
    } finally {
      isLoadingPurchases(false);
    }
  }

  void getDebtsByCustomerId(BuildContext context, int customerId) async {
    try {
      isLoadingDebts(true);
      debts.value = await customerDetailService.getDebtsByCustomerId(
          customerId: customerId);
    } catch (e) {
      UserNotifier.showFlutterSnackBar(context: context, text: e.toString());
    } finally {
      isLoadingDebts(false);
    }
  }

  /// Optional: Load both at once
  Future<void> loadCustomerDetails(int customerId) async {
    isLoadingPurchases(true);
    isLoadingDebts(true);
    try {
      final results = await Future.wait([
        customerDetailService.getPurchasesByCustomerId(customerId: customerId),
        customerDetailService.getDebtsByCustomerId(customerId: customerId),
      ]);
      purchases.value = results[0];
      debts.value = results[1];
    } catch (e, stackTrace) {
      debugPrint("Error in loadCustomerDetails: $e");
      debugPrint("StackTrace: $stackTrace");
      UserNotifier.snackbar(
        label: "Xatolik yuz berdi!",
        text: e.toString(),
        type: TypeOfSnackBar.error,
      );
    } finally {
      isLoadingPurchases(false);
      isLoadingDebts(false);
    }
  }

  calculateTotalDebtsPrice(BuildContext context) async {
    try {
      double totalPrice = 0.0;
      final debts = await customerDetailService.getDebts();
      for (Purchase debt in debts) {
        for (var product in debt.purchaseDocument!.products!) {
          totalPrice = totalPrice + (product.salePrice! * product.qty!);
        }
      }
      totalDebtsPrice.value = totalPrice;
    } catch (e) {
      UserNotifier.showFlutterSnackBar(
        context: context,
        type: TypeOfSnackBar.error,
        label: "Xatolik!",
        text: e.toString(),
      );
    }
  }

  getPaymentHistories(int customerId) async {
    try {
      transactions.value =
          await customerTransactionRepository.getTransactions(customerId);
    } catch (e) {
      print(e.toString());
    } finally {
      isPaymentHistoriesLoading.value = false;
    }
  }
}
