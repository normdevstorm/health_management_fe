import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/domain/prescription/entities/medical_condition.dart';
import 'package:health_management/domain/prescription/entities/prescription_details.dart';

import '../../../../domain/prescription/entities/prescription_entity.dart';
part 'update_prescription_request.freezed.dart';
part 'update_prescription_request.g.dart';

@freezed
class UpdatePrescriptionRequest with _$UpdatePrescriptionRequest {
  const UpdatePrescriptionRequest._();
  const factory UpdatePrescriptionRequest(
          {
          int? id,
          String? diagnosis,
          String? notes,
          List<PrescriptionDetails>? details,
          List<MedicalCondition>? medicalConditions}) =
      _UpdatePrescriptionRequest;
  factory UpdatePrescriptionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePrescriptionRequestFromJson(json);

  factory UpdatePrescriptionRequest.fromEntity(
      PrescriptionEntity? entity) {
    return UpdatePrescriptionRequest(
      id: entity?.id,
      diagnosis: entity?.diagnosis,
      notes: entity?.notes,
      details: entity?.details,
      medicalConditions: entity?.medicalCondition,
    );
  }
}
