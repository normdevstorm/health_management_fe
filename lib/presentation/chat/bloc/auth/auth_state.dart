

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoggedInState extends AuthState {}

class AuthLoggedOutState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState({required this.message});
}

class AuthSignUpState extends AuthState {}

class AuthSignUpSuccess extends AuthState {
  final User user;
  AuthSignUpSuccess({required this.user});
}

class AuthSignInSuccess extends AuthState {
  final User user;
  AuthSignInSuccess({required this.user});
}

class AuthSignInState extends AuthState {}
