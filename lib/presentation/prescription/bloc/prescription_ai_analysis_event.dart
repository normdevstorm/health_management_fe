part of 'prescription_ai_analysis_bloc.dart';

class PrescriptionAiAnalysisEvent extends Equatable {
  const PrescriptionAiAnalysisEvent();

  @override
  List<Object> get props => [];
}

class AnalyzePrescription extends PrescriptionAiAnalysisEvent {
  final PrescriptionAiAnalysisRequest analyzedMedicines;

  const AnalyzePrescription({required this.analyzedMedicines});

  @override
  List<Object> get props => [analyzedMedicines];
}