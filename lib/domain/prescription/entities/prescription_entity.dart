import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/domain/prescription/entities/medical_condition.dart';
import 'package:health_management/domain/prescription/entities/prescription_details.dart';
part 'prescription_entity.g.dart';

@JsonSerializable()
class PrescriptionEntity {
  final int id;
  final String? notes;
  final String? diagnosis;
  final List<PrescriptionDetails>? details;
  final List<MedicalCondition>? medicalCondition;
  final String? frequency;
  final String? duration;
  final String? instruction;
  final String? createdAt;
  final String? updatedAt;

  PrescriptionEntity({
    required this.id,
    this.notes,
    this.diagnosis,
    this.details,
    this.medicalCondition,
    this.frequency,
    this.duration,
    this.instruction,
    this.createdAt,
    this.updatedAt,
  });

  PrescriptionEntity copyWith({
    int? id,
    String? notes,
    String? diagnosis,
    List<PrescriptionDetails>? details,
    List<MedicalCondition>? medicalCondition,
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
      medicalCondition: medicalCondition ?? this.medicalCondition,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      instruction: instruction ?? this.instruction,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PrescriptionEntity.fromJson(Map<String, dynamic> json) => _$PrescriptionEntityFromJson(json);
  Map<String, dynamic> toJson() => _$PrescriptionEntityToJson(this);
}