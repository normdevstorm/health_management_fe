import 'package:equatable/equatable.dart';
import 'package:health_management/domain/prescription/entities/medication.dart';
import 'package:json_annotation/json_annotation.dart';
part 'prescription_details.g.dart';
@JsonSerializable()
class PrescriptionDetails extends Equatable {
  final int id;
  final Medication? medication;
  final String? dosage;
  final String? frequency;
  final String? duration;
  final String? instruction;

  const PrescriptionDetails({
    required this.id,
    this.medication,
    this.dosage,
    this.frequency,
    this.duration,
    this.instruction,
  });

  @override
  List<Object?> get props => [
    id,
    medication,
    dosage,
    frequency,
    duration,
    instruction,
  ];

  PrescriptionDetails copyWith({
    int? id,
    Medication? medication,
    String? dosage,
    String? frequency,
    String? duration,
    String? instruction,
  }) {
    return PrescriptionDetails(
      id: id ?? this.id,
      medication: medication ?? this.medication,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      instruction: instruction ?? this.instruction,
    );
  }

  factory PrescriptionDetails.fromJson(Map<String, dynamic> json) => _$PrescriptionDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PrescriptionDetailsToJson(this);
}