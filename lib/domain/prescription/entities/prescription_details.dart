import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/domain/prescription/entities/medication.dart';
import 'package:json_annotation/json_annotation.dart';
part 'prescription_details.g.dart';
part 'prescription_details.freezed.dart';

@freezed
class PrescriptionDetails with _$PrescriptionDetails {
  const PrescriptionDetails._();
  const factory PrescriptionDetails(
      {required int id,
      Medication? medication,
      String? dosage,
      String? frequency,
      String? duration,
      String? instruction}) = _PrescriptionDetails;

  factory PrescriptionDetails.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionDetailsFromJson(json);
}