part of 'appointment_bloc.dart';

class AppointmentState<T> extends Equatable {

  final BlocStatus status;
  final T? data;
  final String? errorMessage;

  const AppointmentState._({required this.status, this.data, this.errorMessage});
 
  factory AppointmentState.initial() {
    return AppointmentState._(status: BlocStatus.initial);
  }

  factory AppointmentState.loading() {
    return AppointmentState._(status: BlocStatus.loading);
  }

  factory AppointmentState.success(T data) {
    return AppointmentState._(status: BlocStatus.success, data: data);
  }

  factory AppointmentState.error(String errorMessage) {
    return AppointmentState._(status: BlocStatus.error, errorMessage: errorMessage);
  }

  AppointmentState<T> copyWith({
    BlocStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return AppointmentState._(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
