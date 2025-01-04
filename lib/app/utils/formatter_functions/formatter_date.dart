import 'package:intl/intl.dart';

String formatDateToUzbek(String dateTime) {
  String formattedDate = DateFormat('EEEE, dd MMMM yyyy HH:mm:ss', 'en')
      .format(DateTime.parse(dateTime));
  formattedDate = formattedDate
      .replaceAll('Monday', 'Душанба')
      .replaceAll('Tuesday', 'Сешанба')
      .replaceAll('Wednesday', 'Чоршанба')
      .replaceAll('Thursday', 'Пайшанба')
      .replaceAll('Friday', 'Жума')
      .replaceAll('Saturday', 'Шанба')
      .replaceAll('Sunday', 'Якшанба')
      .replaceAll('January', 'Январь')
      .replaceAll('February', 'Февраль')
      .replaceAll('March', 'Март')
      .replaceAll('April', 'Апрель')
      .replaceAll('May', 'Май')
      .replaceAll('June', 'Июнь')
      .replaceAll('July', 'Июль')
      .replaceAll('August', 'Август')
      .replaceAll('September', 'Сентябрь')
      .replaceAll('October', 'Октябрь')
      .replaceAll('November', 'Ноябрь')
      .replaceAll('December', 'Декабрь');

  String capitalizedDate = formattedDate.replaceFirst(
      formattedDate[0], formattedDate[0].toUpperCase());

  return capitalizedDate;
}

String formatDate(String dateTime, {bool hasHour = false}) {
  String formattedDate = '';

  return formattedDate = hasHour
      ? DateFormat('dd-MM-yyyy HH:mm:ss', 'uz').format(
          DateTime.parse(dateTime),
        )
      : DateFormat('dd-MM-yyyy', 'uz').format(
          DateTime.parse(dateTime),
        );
}
