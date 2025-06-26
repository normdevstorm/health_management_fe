class DoctorScheduleEntity {
  final bool? isAvailable;
  final DateTime? startTime;

  DoctorScheduleEntity({
    this.startTime,
    this.isAvailable,
  });

  DoctorScheduleEntity copyWith({
    bool? isAvailable,
    DateTime? startTime,
  }) {
    return DoctorScheduleEntity(
      isAvailable: isAvailable ?? this.isAvailable,
      startTime: startTime ?? this.startTime,
    );
  }
}
