import 'package:health_management/app/app.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/user/entities/user_entity.dart';
part 'user_summary_response.g.dart';

@JsonSerializable()
class UserSummaryResponse {
  final int id;
  final String? lastName;
  final String? firstName;
  final String? avatarUrl;
  final String? email;
  final Role? role;

  const UserSummaryResponse({
    required this.id,
    this.lastName,
    this.avatarUrl,
    this.firstName,
    this.email,
    this.role,
  });

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      lastName: lastName,
      firstName: firstName,
      avatarUrl: avatarUrl,
      email: email,
      role: role,
    );
  }

  factory UserSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserSummaryResponseToJson(this);
}
