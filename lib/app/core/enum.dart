part of '../app.dart';

enum Role {
  @JsonValue('ADMIN')
  admin,
  @JsonValue('USER')
  user,
  @JsonValue('DOCTOR')
  doctor
}
