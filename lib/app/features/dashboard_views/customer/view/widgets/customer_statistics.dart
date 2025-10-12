import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:osonkassa/app/features/customer_detail/logic/customer_detail_ctl.dart';
import 'package:osonkassa/app/styles/icons.dart';
import 'package:osonkassa/app/styles/text_styles.dart';

import '../../../../../utils/formatter_functions/formatter_currency.dart';
import '../customer_view.dart';

class CustomerStatistics extends StatelessWidget {
  const CustomerStatistics({
    super.key,
    required this.screenSize,
    required this.widget,
    required this.customerDetailCtl,
  });

  final Size screenSize;
  final CustomerView widget;
  final CustomerDetailCtl customerDetailCtl;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(screenSize.height * 0.1 / 25),
                child: SvgPicture.asset(
                  AppIcons.person,
                  height: screenSize.height * 0.1 / 2.8,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.customerCtl.customers.length} ta",
                    style: textStyleBlack20,
                  ),
                  Text(
                    "Mijozlar",
                    style: textStyleBlack15,
                  ),
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(screenSize.height * 0.1 / 25),
                child: Icon(
                  CupertinoIcons.money_dollar_circle,
                  size: screenSize.height * 0.1 / 2.8,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${PriceFomatter.formatPrice(customerDetailCtl.totalDebtsPrice.value)} uzs",
                    style: textStyleBlack20,
                  ),
                  Text(
                    "Qarzlar",
                    style: textStyleBlack15,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
