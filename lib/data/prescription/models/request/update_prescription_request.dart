import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/domain/prescription/entities/medical_condition.dart';
import 'package:health_management/domain/prescription/entities/prescription_details.dart';
import '../../../../domain/prescription/entities/prescription_entity.dart';
part 'update_prescription_request.g.dart';

@JsonSerializable()
class UpdatePrescriptionRequest {
  final int? id;
  final String? diagnosis;
  final String? notes;
  final List<PrescriptionDetails>? details;
  final List<MedicalCondition>? medicalConditions;

  UpdatePrescriptionRequest({
    this.id,
    this.diagnosis,
    this.notes,
    this.details,
    this.medicalConditions,
  });

  factory UpdatePrescriptionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePrescriptionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePrescriptionRequestToJson(this);

  factory UpdatePrescriptionRequest.fromEntity(PrescriptionEntity? entity) {
    return UpdatePrescriptionRequest(
      id: entity?.id,
      diagnosis: entity?.diagnosis,
      notes: entity?.notes,
      details: entity?.details,
      medicalConditions: entity?.medicalCondition,
    );
  }
}
