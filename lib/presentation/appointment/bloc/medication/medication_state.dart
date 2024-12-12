part of 'medication_bloc.dart';

class MedicationState<T> extends Equatable {
  final BlocStatus status;
  final T? data;
  final String? errorMessage;

  const MedicationState._({required this.status, this.data, this.errorMessage});
 
  factory MedicationState.initial() {
    return const MedicationState._(status: BlocStatus.initial);
  }

  factory MedicationState.loading() {
    return const MedicationState._(status: BlocStatus.loading);
  }

  factory MedicationState.success(T data) {
    return MedicationState._(status: BlocStatus.success, data: data);
  }

  factory MedicationState.error(String errorMessage) {
    return MedicationState._(status: BlocStatus.error, errorMessage: errorMessage);
  }

  MedicationState<T> copyWith({
    BlocStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return MedicationState._(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
