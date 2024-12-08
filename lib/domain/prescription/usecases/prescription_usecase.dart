import '../../../data/prescription/models/request/prescription_ai_analysis_request.dart';
import '../entities/medication.dart';
import '../entities/prescription_side_effect_risk_entity.dart';
import '../repositories/prescription_repository.dart';

class PrescriptionUseCase {
  final PrescriptionRepository _repository;

  PrescriptionUseCase(this._repository);

  Future<List<PrescriptionSideEffectRiskEntity>?> analyzePrescriptionByAi(
      PrescriptionAiAnalysisRequest request) {
    return _repository.prescriptionAiAnalysis(request);
  }

  Future<List<Medication>> getAllMedications() {
    return _repository.getAllMedications();
  }
}
