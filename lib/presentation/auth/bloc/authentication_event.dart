part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class LoginSubmitEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginSubmitEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

final class RegisterSubmitEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String username;
  final Role role;

  const RegisterSubmitEvent(
      this.email, this.password, this.username, this.role);

  @override
  List<Object> get props => [email, password, username, role];
}

final class LogOutEvent extends AuthenticationEvent {
  const LogOutEvent();

  @override
  List<Object> get props => [];
}

final class CheckLoginStatusEvent extends AuthenticationEvent {
  const CheckLoginStatusEvent();

  @override
  List<Object> get props => [];
}
