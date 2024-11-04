import 'package:json_annotation/json_annotation.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/app.dart';
import '../../../../domain/appointment/entities/appointment_record_entity.dart';
part 'appointment_record_request.g.dart';

@JsonSerializable()
class AppointmentRecordRequest {
  final String? note;
  final int? userId;
  final int? doctorId;
  final int? healthProviderId;
  final AppointmentType? appointmentType;
  final String? scheduledAt;
  final AppointmentStatus? status;

  AppointmentRecordRequest({
    this.note,
    this.userId,
    this.doctorId,
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
      note: entity.note,
      userId: entity.user?.id,
      doctorId: entity.doctor?.id,
      healthProviderId: entity.healthProvider?.id,
      appointmentType: entity.appointmentType,
      scheduledAt: entity.scheduledAt == null
          ? null
          : DateFormat('yyyy-MM-dd').format(entity.scheduledAt!),
      status: entity.status,
    );
  }

}
