class PrescriptionSideEffectRiskEntity {
  final String? name;
  final List<String>? combinations;
  final String? risk;
  final String? recommendation;

  PrescriptionSideEffectRiskEntity({
    this.name,
    this.combinations,
    this.risk,
    this.recommendation,
  });

  PrescriptionSideEffectRiskEntity copyWith({
    String? name,
    List<String>? combinations,
    String? risk,
    String? recommendation,
  }) {
    return PrescriptionSideEffectRiskEntity(
      name: name ?? this.name,
      combinations: combinations ?? this.combinations,
      risk: risk ?? this.risk,
      recommendation: recommendation ?? this.recommendation,
    );
  }
}
