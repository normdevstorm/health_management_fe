import 'package:json_annotation/json_annotation.dart';
part  'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponse{
  final String accessToken;
  final String refreshToken;

  RegisterResponse({required this.accessToken, required this.refreshToken});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}