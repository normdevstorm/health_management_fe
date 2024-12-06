import 'package:health_management/domain/doctor_schedule/entities/doctor_schedule_entity.dart';

class DoctorScheduleResponse {
  final int? id;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? currentPatientCount;
  final int? doctorId;

  DoctorScheduleResponse({
    this.id,
    this.startTime,
    this.endTime,
    this.currentPatientCount,
    this.doctorId,
  });

  factory DoctorScheduleResponse.fromJson(Map<String, dynamic> json) {
    return DoctorScheduleResponse(
      id: json['id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      currentPatientCount: json['current_patient_count'],
      doctorId: json['doctor_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'current_patient_count': currentPatientCount,
      'doctor_id': doctorId,
    };
  }

  DoctorScheduleEntity toEntity() {
    return DoctorScheduleEntity(
      id: id,
      startTime: startTime,
      endTime: endTime,
      currentPatientCount: currentPatientCount,
      doctorId: doctorId,
    );
  }
}
