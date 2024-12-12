part of '../app.dart';

class ConstantManager {
  static const int defaultRequestTiemoutInSeconds = 60;
  static const int defaultRecordNumber = 10;
  static const String defaultHardcodedFirebseUserUid = "YMl6SwRipMUmWagF53GcQvtyd9y2";
  static const List<Map<String, String>> defaultDoctorWorkingShifts = [
    {'7:00 AM': 'Morning'},
    {'8:00 AM': 'Morning'},
    {'9:00 AM': 'Morning'},
    {'10:00 AM': 'Morning'},
    {'11:00 AM': 'Morning'},
    {'1:00 PM': 'Afternoon'},
    {'2:00 PM': 'Afternoon'},
    {'3:00 PM': 'Afternoon'},
    {'4:00 PM': 'Afternoon'},
    {'5:00 PM': 'Afternoon'},
  ];
}
