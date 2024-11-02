import 'package:json_annotation/json_annotation.dart';
import '../../../../domain/doctor/entities/doctor_entity.dart';
part 'doctor_response.g.dart';

@JsonSerializable()
class DoctorResponse {
  final int? id;
  //todo: create user entitya
  // final UserEntity user;
  final String? specialization;
  final double? experience;
  final String? qualification;
  final double? rating;
  final String? about;

    const DoctorResponse({
    this.id,
    // required this.user,
    this.specialization,
    this.experience,
    this.qualification,
    this.rating,
    this.about
  });

  DoctorEntity toEntity() {
    return DoctorEntity(
      id: id,
      // user: user,
      specialization: specialization,
      experience: experience,
      qualification: qualification,
      rating: rating,
      about: about,
    );
  }

  factory DoctorResponse.fromEntity(DoctorEntity? entity) {
    return DoctorResponse(
      id: entity?.id,
      // user: entity.user,
      specialization: entity?.specialization,
      experience: entity?.experience,
      qualification: entity?.qualification,
      rating: entity?.rating,
      about: entity?.about,
    );
  }

  factory DoctorResponse.fromJson(Map<String, dynamic> json) => _$DoctorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorResponseToJson(this);

}