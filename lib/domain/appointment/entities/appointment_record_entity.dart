import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';
import 'package:health_management/domain/prescription/entities/prescription_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import '../../../app/app.dart';
part 'appointment_record_entity.freezed.dart';

//TODO: import prescription, user, doctor, healthProvider
//TODO: implement freezed here
@freezed
class AppointmentRecordEntity with _$AppointmentRecordEntity {
  const AppointmentRecordEntity._();
  const factory AppointmentRecordEntity({
    int? id,
    String? note,
    PrescriptionEntity? prescription,
    UserEntity? user,
    DoctorEntity? doctor,
    HealthProviderEntity? healthProvider,
    AppointmentType? appointmentType,
    DateTime? scheduledAt,
    AppointmentStatus? status,
  }) = _AppointmentRecordEntity;
}
