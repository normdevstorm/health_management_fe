part of 'symptoms_bloc.dart';

class SymptomsState extends Equatable {
  final BlocStatus status;
  final List<String> symptoms;
  final RecommendAiResponse? diagnosisResponse;
  final String? errorMessage;

  const SymptomsState._({
    required this.status,
    this.symptoms = const [],
    this.diagnosisResponse,
    this.errorMessage,
  });

  factory SymptomsState.initial() {
    return const SymptomsState._(status: BlocStatus.initial);
  }

  factory SymptomsState.loading() {
    return const SymptomsState._(status: BlocStatus.loading);
  }

  factory SymptomsState.success({
    required List<String> symptoms,
    RecommendAiResponse? diagnosisResponse,
  }) {
    return SymptomsState._(
      status: BlocStatus.success,
      symptoms: symptoms,
      diagnosisResponse: diagnosisResponse,
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
    List<String>? symptoms,
    RecommendAiResponse? diagnosisResponse,
    String? errorMessage,
  }) {
    return SymptomsState._(
      status: status ?? this.status,
      symptoms: symptoms ?? this.symptoms,
      diagnosisResponse: diagnosisResponse ?? this.diagnosisResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        symptoms,
        diagnosisResponse,
        errorMessage,
      ];
}
