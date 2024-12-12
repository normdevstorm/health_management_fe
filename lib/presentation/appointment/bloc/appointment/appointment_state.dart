part of 'appointment_bloc.dart';

class AppointmentState<T> extends Equatable {
  final BlocStatus status;
  final T? data;
  final String? errorMessage;

  const AppointmentState._(
      {required this.status, this.data, this.errorMessage});

  factory AppointmentState.initial() {
    return const AppointmentState._(status: BlocStatus.initial);
  }

  factory AppointmentState.loading() {
    return const AppointmentState._(status: BlocStatus.loading);
  }

  factory AppointmentState.success(T data) {
    return AppointmentState._(status: BlocStatus.success, data: data);
  }

  factory AppointmentState.error(String errorMessage) {
    return AppointmentState._(
        status: BlocStatus.error, errorMessage: errorMessage);
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

class CancelAppointmentRecordState extends AppointmentState {
  const CancelAppointmentRecordState._({
    super.data,
    required super.status,
    super.errorMessage,
  }) : super._();
  factory CancelAppointmentRecordState.initial() {
    return const CancelAppointmentRecordState._(
      status: BlocStatus.initial,
    );
  }

  factory CancelAppointmentRecordState.loading() {
    return const CancelAppointmentRecordState._(
      status: BlocStatus.loading,
    );
  }

  factory CancelAppointmentRecordState.success(String message) {
    return CancelAppointmentRecordState._(
      status: BlocStatus.success,
      data: message,
    );
  }

  factory CancelAppointmentRecordState.error(String errorMessage) {
    return CancelAppointmentRecordState._(
      status: BlocStatus.error,
      errorMessage: errorMessage,
    );
  }
}

class CreateAppointmentRecordState extends AppointmentState {
  // final AppointmentRecordEntity? data;
  const CreateAppointmentRecordState._({
    required super.data,
    required super.status,
    super.errorMessage,
  }) : super._();
  factory CreateAppointmentRecordState.initial() {
    return const CreateAppointmentRecordState._(
      status: BlocStatus.initial,
      data: AppointmentRecordEntity(),
    );
  }

  factory CreateAppointmentRecordState.inProgress(
      {required AppointmentRecordEntity createAppointmentRecordEntity}) {
    return CreateAppointmentRecordState._(
      status: BlocStatus.inProgress,
      data: createAppointmentRecordEntity,
    );
  }
  factory CreateAppointmentRecordState.loading(
      {required AppointmentRecordEntity createAppointmentRecordEntity}) {
    return CreateAppointmentRecordState._(
      status: BlocStatus.loading,
      data: createAppointmentRecordEntity,
    );
  }

  factory CreateAppointmentRecordState.success(
      {required AppointmentRecordEntity createdAppointmentRecordEntity}) {
    return CreateAppointmentRecordState._(
      status: BlocStatus.success,
      data: createdAppointmentRecordEntity,
    );
  }

  factory CreateAppointmentRecordState.error(String errorMessage,
      {required AppointmentRecordEntity createdAppointmentRecordEntity}) {
    return CreateAppointmentRecordState._(
      status: BlocStatus.error,
      data: createdAppointmentRecordEntity,
      errorMessage: errorMessage,
    );
  }
}

class GetAppointmentDetailState extends AppointmentState {
  const GetAppointmentDetailState._({
    super.data,
    required super.status,
    super.errorMessage,
  }) : super._();
  factory GetAppointmentDetailState.initial() {
    return const GetAppointmentDetailState._(
      status: BlocStatus.initial,
    );
  }
  factory GetAppointmentDetailState.loading() {
    return const GetAppointmentDetailState._(
      status: BlocStatus.loading,
    );
  }

  factory GetAppointmentDetailState.success(
      {required AppointmentRecordEntity appointmentRecordEntity}) {
    return GetAppointmentDetailState._(
      status: BlocStatus.success,
      data: appointmentRecordEntity,
    );
  }

  factory GetAppointmentDetailState.error(
    String errorMessage,
  ) {
    return GetAppointmentDetailState._(
      status: BlocStatus.error,
      errorMessage: errorMessage,
    );
  }
}


class UpdatePrescriptionState extends AppointmentState {
  const UpdatePrescriptionState._({
    super.data,
    required super.status,
    super.errorMessage,
  }) : super._();
  factory UpdatePrescriptionState.initial() {
    return const UpdatePrescriptionState._(
      status: BlocStatus.initial,
    );
  }
  factory UpdatePrescriptionState.loading() {
    return const UpdatePrescriptionState._(
      status: BlocStatus.loading,
    );
  }

  factory UpdatePrescriptionState.success(
      {required AppointmentRecordEntity appointmentRecordEntity}) {
    return UpdatePrescriptionState._(
      status: BlocStatus.success,
      data: appointmentRecordEntity,
    );
  }

  factory UpdatePrescriptionState.error(
    String errorMessage,
  ) {
    return UpdatePrescriptionState._(
      status: BlocStatus.error,
      errorMessage: errorMessage,
    );
  }
}

