import 'package:json_annotation/json_annotation.dart';

import '../../../../app/app.dart';
part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequest{
  String email;
  String username;
  String password;
  Role role;
  RegisterRequest({required this.email, required this.username, required this.password, required this.role});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}