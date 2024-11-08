import 'package:json_annotation/json_annotation.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/app.dart';
import '../../../../domain/appointment/entities/appointment_record_entity.dart';
import '../../../prescription/models/request/update_prescription_request.dart';
part 'appointment_record_request.g.dart';

@JsonSerializable()
class AppointmentRecordRequest {
  final int? id;
  final String? note;
  final int? userId;
  final int? doctorId;
  final int? healthProviderId;
  final UpdatePrescriptionRequest? prescription;
  final AppointmentType? appointmentType;
  final String? scheduledAt;
  final AppointmentStatus? status;

  AppointmentRecordRequest({
    this.id,
    this.note,
    this.userId,
    this.doctorId,
    this.prescription,
    this.healthProviderId,
    this.appointmentType,
    this.scheduledAt,
    this.status,
  });

  factory AppointmentRecordRequest.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRecordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentRecordRequestToJson(this);

  factory AppointmentRecordRequest.fromEntity(AppointmentRecordEntity entity) {
    return AppointmentRecordRequest(
      id: entity.id,
      note: entity.note,
      userId: entity.user?.id,
      doctorId: entity.doctor?.doctorProfile?.id,
      prescription: UpdatePrescriptionRequest.fromEntity(entity.prescription),
      healthProviderId: entity.healthProvider?.id,
      appointmentType: entity.appointmentType,
      scheduledAt: entity.scheduledAt?.toIso8601String().split('.').first,
      status: entity.status,
    );
  }
}
