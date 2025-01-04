import '../../utils/helper/valid_alert.dart';

class NumberValidator {
  static bool isNumber(String text) {
    return double.tryParse(text) != null;
  }
  static   String? validPrice(String value, {bool isDouble = true}) {
    String onlyNumber = "Iltimos faqat raqam kiriting";
    if (value.isEmpty) {
      return isDouble ? validField("Narx") : validField("Mahsulot sonini");
    }
    if (isDouble
        ? double.tryParse(value.replaceAll(',', '')) == null
        : int.tryParse(value.replaceAll(',', '')) == null) {
      return onlyNumber;
    }
    return null;
  }
}
