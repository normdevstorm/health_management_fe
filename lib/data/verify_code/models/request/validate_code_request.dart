import 'package:json_annotation/json_annotation.dart';
import '../../../../domain/verify_code/entities/validate_code_entity.dart';
part 'validate_code_request.g.dart';

@JsonSerializable()
class ValidateCodeRequest {
  final String code;
  final String email;

  ValidateCodeRequest({required this.code, required this.email});

  factory ValidateCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateCodeRequestToJson(this);

  ValidateCodeRequest fromEntity(ValidateCodeEntity entity) {
    return ValidateCodeRequest(
      code: entity.code,
      email: entity.email,
    );
  }
}