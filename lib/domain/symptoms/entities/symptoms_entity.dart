class SymptomEntity {
  final int id;
  final String name;

  const SymptomEntity({
    required this.id,
    required this.name,
  });

  factory SymptomEntity.fromJson(String name, int id) {
    return SymptomEntity(
      id: id,
      name: name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
