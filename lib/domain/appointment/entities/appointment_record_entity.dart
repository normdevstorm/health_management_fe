import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';
import 'package:health_management/domain/prescription/entities/prescription_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import '../../../app/app.dart';
part 'appointment_record_entity.g.dart';

@JsonSerializable()
class AppointmentRecordEntity {
  final int? id;
  final String? note;
  final PrescriptionEntity? prescription;
  final UserEntity? user;
  final UserEntity? doctor;
  final HealthProviderEntity? healthProvider;
  final AppointmentType? appointmentType;
  final DateTime? scheduledAt;
  final AppointmentStatus? status;

  const AppointmentRecordEntity._({
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

  const AppointmentRecordEntity({
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

  //todo: REMOVE IN CASE OF REDUNDANCY

  factory AppointmentRecordEntity.update(
      {required final int id,
      final String? note,
      required final int userId,
      final int? doctorId,
      final PrescriptionEntity? prescription,
      required final int healthProviderId,
      final AppointmentType? appointmentType,
      final String? scheduledAt,
      final AppointmentStatus? status}) {
    return AppointmentRecordEntity._(
        id: id,
        prescription: prescription,
        note: note,
        appointmentType: appointmentType,
        scheduledAt: DateTime.parse(scheduledAt!),
        status: status,
        user: UserEntity(id: userId),
        doctor: UserEntity(doctorProfile: DoctorEntity(id: doctorId)),
        healthProvider: HealthProviderEntity(id: healthProviderId));
  }

  factory AppointmentRecordEntity.create(
      {final String? note,
      required final int userId,
      final int? doctorId,
      required final int healthProviderId,
      final AppointmentType? appointmentType,
      required final String scheduledAt,
      final AppointmentStatus? status}) {
    return AppointmentRecordEntity._(
        note: note,
        appointmentType: appointmentType,
        scheduledAt: DateTime.parse(scheduledAt),
        status: status,
        user: UserEntity(id: userId),
        doctor: UserEntity(doctorProfile: DoctorEntity(id: doctorId)),
        healthProvider: HealthProviderEntity(id: healthProviderId));
  }

  AppointmentRecordEntity copyWith({
    int? id,
    String? note,
    PrescriptionEntity? prescription,
    UserEntity? user,
    UserEntity? doctor,
    HealthProviderEntity? healthProvider,
    AppointmentType? appointmentType,
    DateTime? scheduledAt,
    AppointmentStatus? status,
  }) {
    return AppointmentRecordEntity(
      id: id ?? this.id,
      note: note ?? this.note,
      prescription: prescription ?? this.prescription,
      user: user ?? this.user,
      doctor: doctor ?? this.doctor,
      healthProvider: healthProvider ?? this.healthProvider,
      appointmentType: appointmentType ?? this.appointmentType,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      status: status ?? this.status,
    );
  }

  factory AppointmentRecordEntity.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRecordEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentRecordEntityToJson(this);
}
