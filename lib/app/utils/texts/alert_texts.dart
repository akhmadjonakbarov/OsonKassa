// ignore_for_file: constant_identifier_names

class AlertTexts {
  static const fill_field = "Илтимос формани тўлдиринг";

  static const barcode_unique = "Бу штрих-код маълумотлар омборида мавжуд!";
  static const updated = "ўзгартирилди";
  static const deleted = "ўчирилди";
  static const created = "қўшилди";
  static const no_debt = "Қарзлар мавжуд эмас";
  static const no_product_selected =
      "Маҳсулотлар мавжуд эмас! Илтимос, маҳсулотларни танланг!";
  static const fill_category = "Илтимос бўлим номини киритинг";
  static const success_trade = "Sotuv amalga oshirildi!";

  static const invalid_data =
      "Ma'lumotlarni kiritishdi xatolik, iltimos qaytadan kiriting!";
  static const delete_info = "Ushbu elementni oʻchirib tashlamoqchimisiz?";
  static const delete_data = "Ma'lumot o'chirildi.";

  static String addAlert(String text) {
    return "$text $created";
  }

  static String updateAlert(String text) {
    return "$text $updated";
  }

  static String deleteAlert(String text) {
    return "$text $deleted";
  }
}
