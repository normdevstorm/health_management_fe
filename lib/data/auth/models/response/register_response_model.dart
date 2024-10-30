import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_management/domain/auth/entities/register_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_response_model.freezed.dart';
part 'register_response_model.g.dart';

@freezed
class RegisterResponse with _$RegisterResponse {
  const RegisterResponse._();
  const factory RegisterResponse({
    required String accessToken,
    required String refreshToken,
  }) = _RegisterResponse;
  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

  RegisterEntity toEntity() {
    return RegisterEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}