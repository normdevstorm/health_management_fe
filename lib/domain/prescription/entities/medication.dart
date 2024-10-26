// this class is used to represent a medicine information
import 'package:json_annotation/json_annotation.dart';
part 'medication.g.dart';
@JsonSerializable()
class Medication {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String mfgDate;
  final String expDate;

  Medication({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.mfgDate,
    required this.expDate,
  });

  factory Medication.fromJson(Map<String, dynamic> json) => _$MedicationFromJson(json);
  Map<String, dynamic> toJson() => _$MedicationToJson(this);
}