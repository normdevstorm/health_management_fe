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
  final AppointmentRecordEntity appointmentRecordEntity;

  const CreateAppointmentRecordEvent(this.appointmentRecordEntity);

  @override
  List<Object> get props => [appointmentRecordEntity];
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
