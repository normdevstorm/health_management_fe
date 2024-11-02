import 'package:json_annotation/json_annotation.dart';
part 'register_entity.g.dart';

@JsonSerializable()
class RegisterEntity {
  final String accessToken;
  final String refreshToken;

  RegisterEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  RegisterEntity copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return RegisterEntity(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  factory RegisterEntity.fromJson(Map<String, dynamic> json) => _$RegisterEntityFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterEntityToJson(this);
}