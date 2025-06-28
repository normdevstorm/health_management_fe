part of 'doctor_schedule_bloc.dart';

class DoctorScheduleEvent extends Equatable {
  const DoctorScheduleEvent();

  @override
  List<Object?> get props => [];
}

final class GetDoctorScheduleEvent extends DoctorScheduleEvent {
  final int doctorId;
  final int patientId;

  const GetDoctorScheduleEvent(
      {required this.doctorId, required this.patientId});

  @override
  List<Object?> get props => [doctorId, patientId];
}
