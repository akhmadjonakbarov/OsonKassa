import 'package:intl/intl.dart';

import '../texts/display_texts.dart';

String formatUZSCurrency(double amount) {
  int millions = (amount / 1000000).floor();
  int thousands = ((amount % 1000000) / 1000).floor();
  int hundreds = (amount % 1000)
      .floor(); // Get the remainder directly without dividing by 100

  String millionsPart = millions > 0 ? '$millions ${DisplayTexts.mln} ' : '';
  String thousandsPart =
      thousands > 0 ? '$thousands ${DisplayTexts.thousand} ' : '';
  String hundredsPart =
      hundreds > 0 ? '$hundreds' : ''; // Only add the hundreds without 'yuz'

  String result = millionsPart + thousandsPart + hundredsPart;

  return result.isEmpty ? amount.toStringAsFixed(0) : result;
}

String formatUZSNumber(
  double number, {
  bool useSpaceAsSeparator = false,
  bool isAddWord = false,
}) {
  final format = NumberFormat('#,###.#####', 'en_US');
  String formattedNumber = format.format(number);

  if (useSpaceAsSeparator) {
    // Replace commas with spaces for certain locales
    formattedNumber = formattedNumber.replaceAll(',', ' ');
  }

  return isAddWord ? "$formattedNumber ${DisplayTexts.uzs}" : formattedNumber;
}

String formatPriceAtUZS(double priceAtUZS, {bool isUSD = false}) {
  if (isUSD) {
    return formatUSD(priceAtUZS);
  } else {
    return priceAtUZS < 1000000
        ? formatUZSNumber(priceAtUZS)
        : formatUZSCurrency(priceAtUZS);
  }
}

String formatUSD(
  double number, {
  bool isAddWord = true,
}) {
  final NumberFormat format =
      NumberFormat.currency(locale: 'en_US', symbol: '\$');
  String formattedNumber = format.format(number);

  return isAddWord ? "$formattedNumber ${DisplayTexts.usd}" : formattedNumber;
}

String formatTotalPrice(double totalPriceOfProducts, {bool isUSD = false}) {
  if (isUSD) {
    return formatUSD(totalPriceOfProducts);
  } else {
    return totalPriceOfProducts < 1000000
        ? formatUZSNumber(totalPriceOfProducts)
        : formatUZSCurrency(totalPriceOfProducts);
  }
}

String formatPrice(double currencyValue, double priceValue) {
  final NumberFormat numberFormatterForUSD =
      NumberFormat.currency(locale: 'en_US', symbol: '\$');
  return "${numberFormatterForUSD.format(priceValue)} * ${currencyValue < 1000000 ? formatUZSNumber(currencyValue) : formatUZSCurrency(currencyValue)}";
}
