import 'package:health_management/domain/doctor_schedule/entities/doctor_schedule_entity.dart';

class DoctorAvailableShiftResponse {
  final bool? isAvailable;
  final DateTime? startTime;

  DoctorAvailableShiftResponse({this.isAvailable, this.startTime});

  factory DoctorAvailableShiftResponse.fromJson(Map<String, dynamic> json) {
    return DoctorAvailableShiftResponse(
      startTime: DateTime.parse(json['time']),
      isAvailable: json['available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': startTime?.toIso8601String(),
      'available': isAvailable,
    };
  }

  DoctorScheduleEntity toEntity() {
    return DoctorScheduleEntity(isAvailable: isAvailable, startTime: startTime);
  }
}
