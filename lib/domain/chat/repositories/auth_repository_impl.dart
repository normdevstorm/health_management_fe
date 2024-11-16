
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/chat/datasources/auth/auth_service.dart';
import '../../../data/chat/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  AuthRepositoryImpl(this._authService);
  @override
  Future<User?> getCurrentUser() {
    return _authService.getCurrentUser();
  }

  @override
  Future<bool> isSignedIn() {
    return _authService.isSignedIn();
  }

  @override
  Future<UserCredential> signIn(String email, String password) {
    return _authService.signInWithEmail(email, password);
  }

  @override
  Future<void> signOut() {
    return _authService.signOut();
  }

  @override
  Future<UserCredential> signUp(String email, String password) {
    return _authService.signUpWithEmail(email, password);
  }

  @override
  Future<String> getCurrentUserId() {
    return _authService.getCurrentUserId();
  }

  @override
  Future<bool> hasExistedUser(String email) {
    return _authService.hasExistedUser(email);
  }
}
