import 'package:health_management/domain/user/entities/account_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_account_request.g.dart';

@JsonSerializable()
class UpdateAccountRequest {
  final String? username;
  final String? email;
  final String? password;
  final String? phone;

  UpdateAccountRequest({
    this.username,
    this.email,
    this.password,
    this.phone,
  });

  factory UpdateAccountRequest.fromEntity(AccountEntity? entity, String? password) {
    return UpdateAccountRequest(
      username: entity?.username,
      email: entity?.email,
      password: password,
      phone: entity?.phone,
    );
  }

  factory UpdateAccountRequest.fromJson(Map<String, dynamic> json) => _$UpdateAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateAccountRequestToJson(this);
}