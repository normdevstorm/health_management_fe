import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/domain/verify_code/entities/verify_code_entity.dart';
part 'verify_code_request.g.dart';

@JsonSerializable()
class VerifyCodeRequest {
  final String email;

  VerifyCodeRequest({required this.email});

  factory VerifyCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCodeRequestToJson(this);

  VerifyCodeRequest fromEntity(VerifyCodeEntity entity) {
    return VerifyCodeRequest(
      email: entity.email,
    );
  }
}