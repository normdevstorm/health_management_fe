import 'package:equatable/equatable.dart';
import 'package:health_management/domain/prescription/entities/prescription_details.dart';

class PrescriptionEntity extends Equatable {
  final int id;
  final String? notes;
  final String? diagnosis;
  final PrescriptionDetails? details;
  final String? frequency;
  final String? duration;
  final String? instruction;
  final String? createdAt;
  final String? updatedAt;

  const PrescriptionEntity({
    required this.id,
    this.notes,
    this.diagnosis,
    this.details,
    this.frequency,
    this.duration,
    this.instruction,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    notes,
    diagnosis,
    details,
    frequency,
    duration,
    instruction,
    createdAt,
    updatedAt,
  ];

  PrescriptionEntity copyWith({
    int? id,
    String? notes,
    String? diagnosis,
    PrescriptionDetails? details,
    String? frequency,
    String? duration,
    String? instruction,
    String? createdAt,
    String? updatedAt,
  }) {
    return PrescriptionEntity(
      id: id ?? this.id,
      notes: notes ?? this.notes,
      diagnosis: diagnosis ?? this.diagnosis,
      details: details ?? this.details,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      instruction: instruction ?? this.instruction,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}