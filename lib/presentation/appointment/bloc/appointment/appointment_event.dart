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

final class CreateAppointmentRecordChooseHealthProviderEvent extends AppointmentEvent {
  final AppointmentRecordEntity appointmentRecordEntity;

  const CreateAppointmentRecordChooseHealthProviderEvent(this.appointmentRecordEntity);

  @override
  List<Object> get props => [appointmentRecordEntity];
}

final class CreateAppointmentRecordChooseDoctorEvent extends AppointmentEvent {
  final int doctorId;

  const CreateAppointmentRecordChooseDoctorEvent({required this.doctorId});

  @override
  List<Object> get props => [doctorId];
}

final class CreateAppointmentRecordChooseDatetimeEvent extends AppointmentEvent {
  final DateTime scheduledAt;

  const CreateAppointmentRecordChooseDatetimeEvent({required this.scheduledAt});

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
  final String appointmentId;

  const DeleteAppointmentRecordEvent(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}
