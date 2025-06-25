part of 'symptoms_bloc.dart';

class SymptomsState extends Equatable {
  final BlocStatus status;
  final List<SymptomEntity> symptoms;
  final String? errorMessage;

  const SymptomsState._({
    required this.status,
    this.symptoms = const [],
    this.errorMessage,
  });

  factory SymptomsState.initial() {
    return const SymptomsState._(status: BlocStatus.initial);
  }

  factory SymptomsState.loading() {
    return const SymptomsState._(status: BlocStatus.loading);
  }

  factory SymptomsState.success({required List<SymptomEntity> symptoms}) {
    return SymptomsState._(
      status: BlocStatus.success,
      symptoms: symptoms,
    );
  }

  factory SymptomsState.error(String errorMessage) {
    return SymptomsState._(
      status: BlocStatus.error,
      errorMessage: errorMessage,
    );
  }

  SymptomsState copyWith({
    BlocStatus? status,
    List<SymptomEntity>? symptoms,
    String? errorMessage,
  }) {
    return SymptomsState._(
      status: status ?? this.status,
      symptoms: symptoms ?? this.symptoms,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, symptoms, errorMessage];
}
