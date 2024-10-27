import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../app/app.dart';
import '../../../../domain/appointment/entities/appointment_record_entity.dart';
part 'appointment_record_request.freezed.dart';
part 'appointment_record_request.g.dart';

@freezed
class AppointmentRecordRequest with _$AppointmentRecordRequest {
  const AppointmentRecordRequest._();
  const factory AppointmentRecordRequest({
    String? note,
    int? userId,
    int? doctorId,
    int? healthProviderId,
    AppointmentType? appointmentType,
    String? scheduledAt,
    AppointmentStatus? status,
  }) = _AppointmentRecordRequest;

  factory AppointmentRecordRequest.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRecordRequestFromJson(json);

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
