import 'package:health_management/data/user/models/response/user_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/domain/auth/entities/register_entity.dart';

part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String accessToken;
  final String refreshToken;
  final UserResponse user;

  RegisterResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  RegisterEntity toEntity() {
    return RegisterEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user.toEntity(),
    );
  }
}
