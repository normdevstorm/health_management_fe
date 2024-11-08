import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/data/user/models/response/user_summary_response.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';

import '../../../../app/app.dart';
part 'doctor_summary_response.g.dart';

@JsonSerializable()
class DoctorSummaryResponse extends UserSummaryResponse {
  final HospitalSpecialty? specialization;
  final double? experience;
  final String? qualification;
  final double? rating;
  final String? about;

  DoctorSummaryResponse(
      {required super.id,
      super.lastName,
      super.firstName,
      super.avatarUrl,
      super.email,
      super.role,
      this.specialization,
      this.experience,
      this.qualification,
      this.rating,
      this.about});

  @override
  UserEntity toEntity() {
    return UserEntity(
        lastName: lastName,
        firstName: firstName,
        avatarUrl: avatarUrl,
        email: email,
        role: role,
        doctorProfile: DoctorEntity(
            about: about,
            experience: experience,
            id: id,
            qualification: qualification,
            specialization: specialization,
            rating: rating));
  }

  factory DoctorSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorSummaryResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DoctorSummaryResponseToJson(this);
}
