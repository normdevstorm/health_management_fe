import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/domain/prescription/entities/medical_condition.dart';
import 'package:health_management/domain/prescription/entities/prescription_details.dart';
part 'prescription_entity.freezed.dart';

@freezed
class PrescriptionEntity with _$PrescriptionEntity {
  const PrescriptionEntity._();
  const factory PrescriptionEntity({
    required int id,
    String? notes,
    String? diagnosis,
    List<PrescriptionDetails>? details,
    List<MedicalCondition>? medicalCondition,
    String? frequency,
    String? duration,
    String? instruction,
    String? createdAt,
    String? updatedAt
  }) = _PrescriptionEntity;
}