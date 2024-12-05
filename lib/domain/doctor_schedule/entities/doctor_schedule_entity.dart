class DoctorScheduleEntity {
  final int? id;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? currentPatientCount;
  final int? doctorId;

  DoctorScheduleEntity({
    this.id,
    this.startTime,
    this.endTime,
    this.currentPatientCount,
    this.doctorId,
  });

  DoctorScheduleEntity copyWith({
    int? id,
    DateTime? startTime,
    DateTime? endTime,
    int? currentPatientCount,
    int? doctorId,
  }) {
    return DoctorScheduleEntity(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      currentPatientCount: currentPatientCount ?? this.currentPatientCount,
      doctorId: doctorId ?? this.doctorId,
    );
  }
}