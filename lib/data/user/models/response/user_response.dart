import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/data/doctor/models/response/doctor_response.dart';
import 'package:health_management/domain/address/entities/address_entity.dart';

import '../../../../domain/user/entities/user_entity.dart';
import 'account_response.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int id;
  final String? firstname;
  final String? lastname;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? avatarUrl;
  final AccountResponse? account;
  final List<AddressEntity>? addresses;
  final DoctorResponse? doctor;

  UserResponse({
    required this.id,
    this.firstname,
    this.lastname,
    this.dateOfBirth,
    this.gender,
    this.avatarUrl,
    this.account,
    this.addresses,
    this.doctor,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstname,
      lastName: lastname,
      dateOfBirth: dateOfBirth,
      gender: gender,
      avatarUrl: avatarUrl,
      account: account?.toEntity(),
      addresses: addresses,
      doctorProfile: doctor?.toEntity(),
    );
  }
}