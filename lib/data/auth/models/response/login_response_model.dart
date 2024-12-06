import 'package:json_annotation/json_annotation.dart';
import '../../../user/models/response/user_response.dart';
part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "access_token")
  final String accessToken;
  @JsonKey(name: "refresh_token")
  final String refreshToken;
  @JsonKey(name: "user")
  final UserResponse userResponse;

  LoginResponse(
      {required this.accessToken,
      required this.refreshToken,
      required this.userResponse});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
