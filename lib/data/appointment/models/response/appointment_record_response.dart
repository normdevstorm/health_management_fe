import 'package:health_management/data/doctor/models/response/doctor_summary_response.dart';
import 'package:health_management/data/health_provider/models/response/health_provider_response.dart';
import 'package:health_management/data/prescription/models/response/prescription_response.dart';
import 'package:health_management/data/user/models/response/user_summary_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../app/app.dart';
import '../../../../domain/appointment/entities/appointment_record_entity.dart';
part 'appointment_record_response.g.dart';

@JsonSerializable()
class AppointmentRecordResponse {
  final int? id;
  final String? note;
  final PrescriptionResponse? prescription;
  final UserSummaryResponse? user;
  final DoctorSummaryResponse? doctor;
  final HealthProviderResponse? healthProvider;
  final AppointmentType? appointmentType;
  final DateTime? scheduledAt;
  final AppointmentStatus? status;

   const AppointmentRecordResponse({
    this.id,
    this.note,
    this.prescription,
    this.user,
    this.doctor,
    this.healthProvider,
    this.appointmentType,
    this.scheduledAt,
    this.status,
  });

  AppointmentRecordEntity toEntity() {
    return AppointmentRecordEntity(
      id: id,
      note: note,
      prescription: prescription?.toEntity(),
      healthProvider: healthProvider?.toEntity(),
      doctor: doctor?.toEntity(),
      user: user?.toEntity(),
      appointmentType: appointmentType,
      scheduledAt: scheduledAt,
      status: status,
    );
  }

  factory AppointmentRecordResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRecordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentRecordResponseToJson(this);
}
