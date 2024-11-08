import 'package:health_management/data/address/models/request/address_request.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/data/user/models/request/update_account_request.dart';

import '../../../../domain/user/entities/user_entity.dart';

part 'update_user_request.g.dart';

@JsonSerializable()
class UpdateUserRequest {
  final int? id;
  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? avatarUrl;
  final UpdateAccountRequest? account;
  final List<AddressRequest>? addresses;
  // final DoctorResponse? doctorProfile;

  UpdateUserRequest({
    this.id,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.avatarUrl,
    this.account,
    this.addresses,
    // this.doctorProfile,
  });

  factory UpdateUserRequest.fromEntity(UserEntity entity) {
    return UpdateUserRequest(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      dateOfBirth: entity.dateOfBirth,
      gender: entity.gender,
      avatarUrl: entity.avatarUrl,
      account: UpdateAccountRequest.fromEntity(entity.account, entity.account?.password),
      addresses: entity.addresses?.map((e) => AddressRequest.fromEntity(e)).toList(),
      // doctorProfile: DoctorResponse.fromEntity(entity.doctorProfile),
    );
  }

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}
