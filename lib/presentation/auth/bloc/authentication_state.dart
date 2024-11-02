part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<Object?> get props => [message];
}

final class LoginSuccess extends AuthenticationState {
  final LoginEntity? loginEntity;

  const LoginSuccess(this.loginEntity);

  @override
  List<Object?> get props => [loginEntity];
}

final class LoginError extends AuthenticationError {
  const LoginError(super.message);

  @override
  List<Object?> get props => [message];
}

// Register state
final class RegisterSuccess extends AuthenticationState {
  final RegisterEntity? registerEntity;

  const RegisterSuccess(this.registerEntity);

  @override
  List<Object?> get props => [registerEntity];
}

final class RegisterError extends AuthenticationError {
  const RegisterError(super.message);

  @override
  List<Object?> get props => [message];
}

// Verify code state
final class GetVerifyCodeSuccess extends AuthenticationState {
  final String message;

  const GetVerifyCodeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetVerifyCodeError extends AuthenticationError {
  const GetVerifyCodeError(super.message);

  @override
  List<Object?> get props => [message];
}

final class VerifyCodeSuccess extends AuthenticationState {
  final String message;
  final RegisterSubmitEvent registerSubmitEvent;

  const VerifyCodeSuccess(this.message, this.registerSubmitEvent);

  @override
  List<Object?> get props => [message,registerSubmitEvent];
}

final class VerifyCodeError extends AuthenticationError {

  const VerifyCodeError(super.message);

  @override
  List<Object?> get props => [message];
}
