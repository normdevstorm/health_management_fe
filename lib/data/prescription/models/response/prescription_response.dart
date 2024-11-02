import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/domain/prescription/entities/prescription_entity.dart';
import '../../../../domain/prescription/entities/prescription_details.dart';

part 'prescription_response.g.dart';

@JsonSerializable()
class PrescriptionResponse {
  final int id;
  final String? notes;
  final String? diagnosis;
  final List<PrescriptionDetails>? details;
  final String? frequency;
  final String? duration;
  final String? instruction;
  final String? createdAt;
  final String? updatedAt;

  // Added constructor. Must not have any parameter
  const PrescriptionResponse({
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

  PrescriptionEntity toEntity() => PrescriptionEntity(
      id: id,
      createdAt: createdAt,
      details: details,
      diagnosis: diagnosis,
      duration: duration,
      frequency: frequency,
      instruction: instruction,
      notes: notes,
      updatedAt: updatedAt);

  factory PrescriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionResponseToJson(this);
}
