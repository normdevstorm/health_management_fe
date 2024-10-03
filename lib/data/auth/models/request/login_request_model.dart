import 'package:json_annotation/json_annotation.dart';
part 'login_request_model.g.dart';


@JsonSerializable()
class LoginRequest{ 
  final String email;
  final String password;
  @JsonKey(name: 'notification_key')
  final String fcmToken;
  const LoginRequest({required this.email,required this.password, required this.fcmToken});

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}