class RecommendAiResponse {
  final List<Diagnosis> diagnoses;
  final Map<String, dynamic> finalDiagnosis;
  final Map<String, dynamic> recommendations;

  RecommendAiResponse({
    required this.diagnoses,
    required this.finalDiagnosis,
    required this.recommendations,
  });

  factory RecommendAiResponse.fromJson(Map<String, dynamic> json) {
    return RecommendAiResponse(
      diagnoses: (json['diagnoses'] as List<dynamic>?)
              ?.map((e) => Diagnosis.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      finalDiagnosis: json['final_diagnosis'] as Map<String, dynamic>? ?? {},
      recommendations: json['recommendations'] as Map<String, dynamic>? ?? {},
    );
  }
}

class Diagnosis {
  final String disease;
  final int confidence;
  final String department;
  final String explanation;

  Diagnosis({
    required this.disease,
    required this.confidence,
    required this.department,
    required this.explanation,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      disease: json['disease'] as String? ?? '',
      confidence: json['confidence'] as int? ?? 0,
      department: json['department'] as String? ?? '',
      explanation: json['explanation'] as String? ?? '',
    );
  }
}
