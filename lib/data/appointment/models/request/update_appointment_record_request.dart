import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/data/prescription/models/request/update_prescription_request.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';

import '../../../../app/app.dart';
part 'update_appointment_record_request.freezed.dart';
part 'update_appointment_record_request.g.dart';

@freezed
class UpdateAppointmentRecordRequest with _$UpdateAppointmentRecordRequest {
  const UpdateAppointmentRecordRequest._();
  const factory UpdateAppointmentRecordRequest(
      {int? id,
      String? note,
      int? userId,
      int? doctorId,
      int? healthProviderId,
      UpdatePrescriptionRequest? prescription,
      AppointmentType? appointmentType,
      DateTime? scheduledAt,
      AppointmentStatus? status}) = _UpdateAppointmentRecordRequest;

  factory UpdateAppointmentRecordRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAppointmentRecordRequestFromJson(json);

  factory UpdateAppointmentRecordRequest.fromEntity(
      AppointmentRecordEntity entity) {
    return UpdateAppointmentRecordRequest(
      id: entity.id,
      note: entity.note,
      userId: entity.user?.id,
      doctorId: entity.doctor?.id,
      healthProviderId: entity.healthProvider?.id,
      prescription: UpdatePrescriptionRequest.fromEntity(entity.prescription) ,
      appointmentType: entity.appointmentType,
      scheduledAt: entity.scheduledAt,
      status: entity.status,
    );
      }
}
