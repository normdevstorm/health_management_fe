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
  final int appointmentId;

  const GetAppointmentDetailEvent({required this.appointmentId});

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
  final String? doctorName;

  const ColectDataDoctorEvent(
      {required this.doctorId, required this.doctorName});

  @override
  List<Object> get props => [doctorId];
}

final class CollectDataDatetimeAndNoteEvent extends AppointmentEvent {
  final DateTime scheduledAt;
  final String? note;

  const CollectDataDatetimeAndNoteEvent({required this.scheduledAt, this.note});

  @override
  List<Object> get props => [scheduledAt, note ?? ''];
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

final class UpdatePrescriptionEvent extends AppointmentEvent {
  final AppointmentRecordEntity appointment;

  const UpdatePrescriptionEvent({required this.appointment});

  @override
  List<Object> get props => [appointment];
}

final class CollectDataSymptomEvent extends AppointmentEvent {
  final SymptomEntity symptom;

  const CollectDataSymptomEvent({required this.symptom});

  @override
  List<Object> get props => [symptom];
}
