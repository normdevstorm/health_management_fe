import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/domain/prescription/entities/prescription_entity.dart';
import '../../../../domain/prescription/entities/prescription_details.dart';
part 'prescription_response.freezed.dart';
part 'prescription_response.g.dart';
@Freezed(copyWith: false, toJson: true, fromJson: true)
class PrescriptionResponse with _$PrescriptionResponse {
  //Sometimes, you may want to manually define methods/properties in our classes.
  // Added constructor. Must not have any parameter
  const PrescriptionResponse._();
  const factory PrescriptionResponse(
      {required int id,
      String? notes,
      String? diagnosis,
      PrescriptionDetails? details,
      String? frequency,
      String? duration,
      String? instruction,
      String? createdAt,
      String? updatedAt}) = _PrescriptionResponse;

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
}
