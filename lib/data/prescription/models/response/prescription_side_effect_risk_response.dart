import 'package:health_management/domain/prescription/entities/prescription_side_effect_risk_entity.dart';

class PrescriptionSideEffectRiskResponse {
  final String? name;
  final List<String>? combinations;
  final String? risk;
  final String? recommendation;

  PrescriptionSideEffectRiskResponse({
    this.name,
    this.combinations,
    this.risk,
    this.recommendation,
  });

  factory PrescriptionSideEffectRiskResponse.fromJson(Map<String, dynamic> json) {
    return PrescriptionSideEffectRiskResponse(
      name: json['name'],
      combinations: List<String>.from(json['medicines']),
      risk: json['risk'],
      recommendation: json['recommendation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'medicines': combinations,
      'risk': risk,
      'recommendation': recommendation,
    };
  }

  PrescriptionSideEffectRiskEntity toEntity() {
    return PrescriptionSideEffectRiskEntity(
      name: name,
      combinations: combinations,
      risk: risk,
      recommendation: recommendation,
    );
  }
}