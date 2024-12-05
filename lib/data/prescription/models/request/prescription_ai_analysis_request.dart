class PrescriptionAiAnalysisRequest {
  final List<String> medicines;

  PrescriptionAiAnalysisRequest({
    required this.medicines,
  });

  Map<String, dynamic> toJson() {
    return {
      'medicines': medicines,
    };
  }

  factory PrescriptionAiAnalysisRequest.fromJson(Map<String, dynamic> json) {
    return PrescriptionAiAnalysisRequest(
      medicines: List<String>.from(json['medicines']),
    );
  }
}
