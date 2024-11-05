import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AccountEntity {
  final String? userName;
  final String? email;
  final String? password;
  final String? phone;

  AccountEntity({this.userName, this.email, this.password, this.phone});
}
