// this class is used to represent a medicine information
import 'package:json_annotation/json_annotation.dart';
part 'medication.g.dart';

@JsonSerializable()
class Medication {
  int id;
  String? name;
  String? imageUrl;
  String? description;
  String? mfgDate;
  String? expDate;

  Medication({
    required this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.mfgDate,
    this.expDate,
  });

  factory Medication.fromJson(Map<String, dynamic> json) =>
      _$MedicationFromJson(json);
  Map<String, dynamic> toJson() => _$MedicationToJson(this);
}
