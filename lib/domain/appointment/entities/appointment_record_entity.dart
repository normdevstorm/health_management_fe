import 'package:equatable/equatable.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';
import 'package:health_management/domain/prescription/entities/prescription_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import '../../../app/app.dart';

//TODO: import prescription, user, doctor, healthProvider
//TODO: implement freezed here
class AppointmentRecordEntity extends Equatable {
  final int? id;
  final String? note;
  final PrescriptionEntity? prescription;
  final UserEntity? user;
  final DoctorEntity? doctor;
  final HealthProviderEntity? healthProvider;
  final AppointmentType? appointmentType;
  final DateTime? scheduledAt;
  final AppointmentStatus? status;

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

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        note,
        prescription,
        user,
        doctor,
        healthProvider,
        appointmentType,
        scheduledAt,
        status,
      ];

  AppointmentRecordEntity copyWith({
    int? id,
    String? note,
    PrescriptionEntity? prescription,
    UserEntity? user,
    DoctorEntity? doctor,
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
}
