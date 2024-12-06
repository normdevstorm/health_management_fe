class ShiftTimeEntity {
  final String name;
  final String partOfDay;
  final int? startTime;
  bool available;

  ShiftTimeEntity({
    required this.name,
    required this.partOfDay,
    this.startTime,
    this.available = true,
  });

  ShiftTimeEntity copyWith({
    String? name,
    int? startTime,
    bool? available,
    String? partOfDay,
  }) {
    return ShiftTimeEntity(
      partOfDay: partOfDay ?? this.partOfDay,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      available: available ?? this.available,
    );
  }
}
