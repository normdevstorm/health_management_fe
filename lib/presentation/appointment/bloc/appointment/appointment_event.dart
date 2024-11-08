part of 'appointment_bloc.dart';

sealed class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

final class GetAllAppointmentRecordEvent extends AppointmentEvent {
  const GetAllAppointmentRecordEvent();

  @override
  List<Object> get props => [];
}

final class GetAppointmentDetailEvent extends AppointmentEvent {
  final String appointmentId;

  const GetAppointmentDetailEvent(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

final class CreateAppointmentRecordEvent extends AppointmentEvent {
  // final AppointmentRecordEntity appointmentRecordEntity;

  const CreateAppointmentRecordEvent();

  @override
  List<Object> get props => [];
}

final class CollectDataHealthProviderEvent extends AppointmentEvent {
  final AppointmentRecordEntity appointmentRecordEntity;

  const CollectDataHealthProviderEvent(this.appointmentRecordEntity);

  @override
  List<Object> get props => [appointmentRecordEntity];
}

final class ColectDataDoctorEvent extends AppointmentEvent {
  final int doctorId;

  const ColectDataDoctorEvent({required this.doctorId});

  @override
  List<Object> get props => [doctorId];
}

final class CollectDataDatetimeEvent extends AppointmentEvent {
  final DateTime scheduledAt;

  const CollectDataDatetimeEvent({required this.scheduledAt});

  @override
  List<Object> get props => [scheduledAt];
}

final class UpdateAppointmentRecordEvent extends AppointmentEvent {
  final AppointmentRecordEntity updateAppointmentRecordEntity;

  const UpdateAppointmentRecordEvent(this.updateAppointmentRecordEntity);

  @override
  List<Object> get props => [updateAppointmentRecordEntity];
}

final class DeleteAppointmentRecordEvent extends AppointmentEvent {
  final int appointmentId;

  const DeleteAppointmentRecordEvent({required this.appointmentId});

  @override
  List<Object> get props => [appointmentId];
}
