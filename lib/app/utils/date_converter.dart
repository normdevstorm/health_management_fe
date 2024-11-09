import 'package:easy_localization/easy_localization.dart';

class DateConverter {
  static String convertToYearMonthDay(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String convertToHourMinuteSecond(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}
