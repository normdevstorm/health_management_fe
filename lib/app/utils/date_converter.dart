import 'package:easy_localization/easy_localization.dart';

class DateConverter {
  static String convertToYearMonthDay(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String convertToHourMinuteSecond(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  static String getWeekdayString(DateTime dateTime) {
    switch (dateTime.weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}
