part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}


final class AuthenticationInitial extends AuthenticationState {}
// Login state
final class LoginLoading extends AuthenticationState {}

final class LoginSuccess extends AuthenticationState {
  final LoginEntity? loginEntity;

  const LoginSuccess(this.loginEntity);

  @override
  List<Object?> get props => [loginEntity];
}

final class LoginError extends AuthenticationState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object?> get props => [message];
}

// Register state
final class RegisterLoading extends AuthenticationState {}

final class RegisterSuccess extends AuthenticationState {
  final RegisterEntity? registerEntity;

  const RegisterSuccess(this.registerEntity);

  @override
  List<Object?> get props => [registerEntity];
}

final class RegisterError extends AuthenticationState {
  final String message;

  const RegisterError(this.message);

  @override
  List<Object?> get props => [message];
}
