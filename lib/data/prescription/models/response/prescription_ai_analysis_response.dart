import 'package:health_management/data/prescription/models/response/prescription_side_effect_risk_response.dart';

class PrescriptionAiAnalysisResponse {
  final List<PrescriptionSideEffectRiskResponse>? risks;

  PrescriptionAiAnalysisResponse({
    this.risks,
  });

  factory PrescriptionAiAnalysisResponse.fromJson(Map<String, dynamic> json) {
    return PrescriptionAiAnalysisResponse(
      risks: List<PrescriptionSideEffectRiskResponse>.from(json['risks'].map((x) => PrescriptionSideEffectRiskResponse.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'risks': risks?.map((x) => x.toJson()).toList(),
    };
  }

}
