import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_entity.g.dart';

@JsonSerializable()
class RegisterEntity {
  final String accessToken;
  final String refreshToken;
  final UserEntity user;

  RegisterEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  RegisterEntity copyWith({
    String? accessToken,
    String? refreshToken,
    UserEntity? user,
  }) {
    return RegisterEntity(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }

  factory RegisterEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterEntityFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterEntityToJson(this);
}
