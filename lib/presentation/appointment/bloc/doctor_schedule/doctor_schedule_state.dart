part of 'doctor_schedule_bloc.dart';


class DoctorScheduleState extends Equatable {
  final BlocStatus status;
  final List<DoctorScheduleEntity>? data;
  final String? errorMessage;

  const DoctorScheduleState._({required this.status, this.data, this.errorMessage});
 
  factory DoctorScheduleState.initial() {
    return const DoctorScheduleState._(status: BlocStatus.initial);
  }

  factory DoctorScheduleState.loading() {
    return const DoctorScheduleState._(status: BlocStatus.loading);
  }

  factory DoctorScheduleState.success(List<DoctorScheduleEntity>? data) {
    return DoctorScheduleState._(status: BlocStatus.success, data: data);
  }

  factory DoctorScheduleState.error(String errorMessage) {
    return DoctorScheduleState._(status: BlocStatus.error, errorMessage: errorMessage);
  }

  DoctorScheduleState copyWith({
    BlocStatus? status,
    List<DoctorScheduleEntity>? data,
    String? errorMessage,
  }) {
    return DoctorScheduleState._(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
