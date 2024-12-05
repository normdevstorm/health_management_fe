part of 'prescription_ai_analysis_bloc.dart';

class PrescriptionAiAnalysisState extends Equatable {
  final BlocStatus status;
  final List<PrescriptionSideEffectRiskEntity>? risks;
  final String? errorMessage;

  const PrescriptionAiAnalysisState._(
      {required this.status, this.risks, this.errorMessage});

  factory PrescriptionAiAnalysisState.initial() {
    return const PrescriptionAiAnalysisState._(status: BlocStatus.initial);
  }

  factory PrescriptionAiAnalysisState.loading() {
    return const PrescriptionAiAnalysisState._(status: BlocStatus.loading);
  }

  factory PrescriptionAiAnalysisState.success(List<PrescriptionSideEffectRiskEntity> prescriptions) {
    return PrescriptionAiAnalysisState._(status: BlocStatus.success, risks: prescriptions);
  }

  factory PrescriptionAiAnalysisState.error(String errorMessage) {
    return PrescriptionAiAnalysisState._(
        status: BlocStatus.error, errorMessage: errorMessage);
  }

  PrescriptionAiAnalysisState copyWith({
    BlocStatus? status,
    List<PrescriptionSideEffectRiskEntity>? prescriptions,
    String? errorMessage,
  }) {
    return PrescriptionAiAnalysisState._(
      status: status ?? this.status,
      risks: prescriptions ?? this.risks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, risks, errorMessage];
}