import 'package:firebase_auth/firebase_auth.dart';

import '../../../../app/utils/errors/exception.dart';
import '../../../../data/chat/repositories/auth_repository.dart';

class AuthUseCase implements AuthRepository {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  @override
  Future<UserCredential> signIn(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      throw FirebaseDatabaseException('SignIn: email or password is empty');
    } else {
      return _repository.signIn(email, password);
    }
  }

  @override
  Future<UserCredential> signUp(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      throw FirebaseDatabaseException('SignUp: email or password is empty');
    } else {
      return _repository.signUp(email, password);
    }
  }

  @override
  Future<void> signOut() {
    return _repository.signOut();
  }

  @override
  Future<bool> isSignedIn() {
    return _repository.isSignedIn();
  }

  @override
  Future<User?> getCurrentUser() {
    return _repository.getCurrentUser();
  }

  @override
  Future<String> getCurrentUserId() {
    return _repository.getCurrentUserId();
  }

  @override
  Future<bool> hasExistedUser(String email) {
    return _repository.hasExistedUser(email);
  }
}
