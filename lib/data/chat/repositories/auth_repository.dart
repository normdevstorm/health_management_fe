import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> signIn(String email, String password);
  Future<UserCredential> signUp(String email, String password);
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<User?> getCurrentUser();
  Future<String> getCurrentUserId();
  Future<bool> hasExistedUser(String email);
}
