import 'package:health_management/data/address/models/response/address_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/data/doctor/models/response/doctor_response.dart';

import '../../../../domain/user/entities/user_entity.dart';
import 'account_response.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int id;
  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;
  
  final String? gender;
  final String? avatarUrl;
  final AccountResponse? account;
  final List<AddressResponse>? addresses;
  final DoctorResponse? doctorProfile;

  UserResponse({
    required this.id,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.avatarUrl,
    this.account,
    this.addresses,
    this.doctorProfile,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      avatarUrl: avatarUrl,
      account: account?.toEntity(),
      addresses: addresses?.map((e) => e.toEntity()).toList(),
      doctorProfile: doctorProfile?.toEntity(),
    );
  }
}
