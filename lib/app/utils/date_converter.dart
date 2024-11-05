import 'package:easy_localization/easy_localization.dart';

class DateConverter {
  static String convertToYMD(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}