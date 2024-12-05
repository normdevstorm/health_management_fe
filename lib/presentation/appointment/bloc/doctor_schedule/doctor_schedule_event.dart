part of 'doctor_schedule_bloc.dart';

class DoctorScheduleEvent extends Equatable {
  const DoctorScheduleEvent();

  @override
  List<Object?> get props => [];
}

final class GetDoctorScheduleEvent extends DoctorScheduleEvent {
  final int doctorId;

  const GetDoctorScheduleEvent({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}
