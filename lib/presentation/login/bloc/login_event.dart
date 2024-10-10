part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
final class RegisterEvent extends LoginEvent {
  final String email;
  final String password;
  final String username;
  final Role role;

  const RegisterEvent(this.email, this.password, this.username, this.role);

  @override
  List<Object> get props => [email, password, username, role];
}

final class LogOutEvent extends LoginEvent {
  const LogOutEvent();

  @override
  List<Object> get props => [];
}

final class CheckLoginStatusEvent extends LoginEvent {
  const CheckLoginStatusEvent();

  @override
  List<Object> get props => [];
}