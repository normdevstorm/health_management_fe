
  import 'package:health_management/domain/prescription/entities/prescription_side_effect_risk_entity.dart';

import '../../../data/prescription/models/request/prescription_ai_analysis_request.dart';

abstract class PrescriptionRepository {
    Future<List<PrescriptionSideEffectRiskEntity>?> prescriptionAiAnalysis(PrescriptionAiAnalysisRequest request);
}

