import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/data/prescription/models/request/update_prescription_request.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import '../../../../app/app.dart';
part 'update_appointment_record_request.g.dart';

@JsonSerializable()
class UpdateAppointmentRecordRequest {
  final int? id;
  final String? note;
  final int? userId;
  final int? doctorId;
  final int? healthProviderId;
  final UpdatePrescriptionRequest? prescription;
  final AppointmentType? appointmentType;
  final DateTime? scheduledAt;
  final AppointmentStatus? status;

  UpdateAppointmentRecordRequest({
    this.id,
    this.note,
    this.userId,
    this.doctorId,
    this.healthProviderId,
    this.prescription,
    this.appointmentType,
    this.scheduledAt,
    this.status,
  });

  factory UpdateAppointmentRecordRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAppointmentRecordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAppointmentRecordRequestToJson(this);

  factory UpdateAppointmentRecordRequest.fromEntity(
      AppointmentRecordEntity entity) {
    return UpdateAppointmentRecordRequest(
      id: entity.id,
      note: entity.note,
      userId: entity.user?.id,
      doctorId: entity.doctor?.id,
      healthProviderId: entity.healthProvider?.id,
      prescription: UpdatePrescriptionRequest.fromEntity(entity.prescription),
      appointmentType: entity.appointmentType,
      scheduledAt: entity.scheduledAt,
      status: entity.status,
    );
  }
}
