import 'package:health_management/app/app.dart';
import 'package:json_annotation/json_annotation.dart';
part 'doctor_entity.g.dart';

@JsonSerializable()
class DoctorEntity {
  final String? name;
  final int? id;
  final HospitalSpecialty? specialization;
  final double? experience;
  final String? qualification;
  final double? rating;
  final String? about;

  DoctorEntity({
    this.name,
    this.id,
    this.specialization,
    this.experience,
    this.qualification,
    this.rating,
    this.about,
  });

  DoctorEntity copyWith({
    String? name,
    int? id,
    HospitalSpecialty? specialization,
    double? experience,
    String? qualification,
    double? rating,
    String? about,
  }) {
    return DoctorEntity(
      name: name ?? this.name,
      id: id ?? this.id,
      specialization: specialization ?? this.specialization,
      experience: experience ?? this.experience,
      qualification: qualification ?? this.qualification,
      rating: rating ?? this.rating,
      about: about ?? this.about,
    );
  }

  factory DoctorEntity.fromJson(Map<String, dynamic> json) =>
      _$DoctorEntityFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorEntityToJson(this);
}
