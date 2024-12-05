import 'package:json_annotation/json_annotation.dart';
import '../../../user/models/response/user_response.dart';

part 'refresh_response_model.g.dart';

@JsonSerializable()
class RefreshResponse {
  @JsonKey(name: "access_token")
  final String accessToken;
  @JsonKey(name: "refresh_token")
  final String refreshToken;
  @JsonKey(name: "user")
  final UserResponse? userResponse;

  RefreshResponse(
      {required this.accessToken,
      required this.refreshToken,
       this.userResponse});

  factory RefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshResponseToJson(this);
}