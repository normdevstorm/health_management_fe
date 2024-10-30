import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_entity.freezed.dart';
@Freezed(fromJson: false, toJson: false)
class RegisterEntity with _$RegisterEntity {
  const RegisterEntity._();
  const factory RegisterEntity({
    required String accessToken,
    required String refreshToken,
  }) = _RegisterEntity;
}