class SymptomResponse {
  final int total;
  final List<String> symptoms;

  SymptomResponse({
    required this.total,
    required this.symptoms,
  });

  factory SymptomResponse.fromJson(Map<String, dynamic> json) {
    return SymptomResponse(
      total: json['total'] as int,
      symptoms: List<String>.from(json['symptoms'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'symptoms': symptoms,
    };
  }
}
