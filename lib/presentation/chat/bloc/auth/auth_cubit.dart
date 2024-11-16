import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/utils/functions/hash_password.dart';
import 'package:health_management/domain/chat/models/account_model.dart';
import 'package:health_management/domain/chat/models/profile_model.dart';
import 'package:health_management/domain/chat/models/user_model.dart';
import 'package:health_management/domain/chat/usecases/app_use_cases.dart';
import 'package:health_management/presentation/chat/bloc/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final usecase = getIt.call<AppChatUseCases>;

  AuthCubit() : super(AuthInitialState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    bool isSignIn = await usecase().auth.isSignedIn();
    User? user = await usecase().auth.getCurrentUser();
    if (user != null || isSignIn) {
      emit(AuthLoggedInState());
    } else {
      emit(AuthLoggedOutState());
    }
  }

  Future<void> signUpWithEmail(
      String email, String password, String userName) async {
    emit(AuthLoadingState());
    try {
      final userCredential = await usecase().auth.signUp(email, password);
      User? user = userCredential.user;
      if (user != null) {
        emit(AuthSignUpSuccess(user: user));
        String hashedPassword = hashPassword(password);
        // Save user, account, profile to firestore
        usecase().user.insertAccount(
            ChatAccount(uid: user.uid, email: email, password: hashedPassword));
        usecase().user.insertProfile(ChatProfile(
              uid: user.uid,
              userName: userName,
              email: email,
              avatar:
                  'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
            ));
        UserChatModel saveUser = UserChatModel(
          uid: user.uid,
          userName: userName,
          profileImage:
              'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
          lastSeen: DateTime.now(),
          groupId: [],
          isOnline: true,
        );
        usecase().user.insertUser(saveUser);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthErrorState(message: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthErrorState(
            message: 'The account already exists for that email.'));
      } else {
        emit(AuthErrorState(message: e.message!));
      }
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(AuthLoadingState());
    try {
      final userCredential = await usecase().auth.signIn(email, password);
      if (userCredential.user != null) {
        emit(AuthSignInSuccess(user: userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          emit(AuthErrorState(message: 'No user found for that email.'));
          break;
        case 'wrong-password':
          emit(AuthErrorState(
              message: 'Wrong password provided for that user.'));
          break;
        case 'too-many-requests':
          emit(AuthErrorState(message: 'Too many requests. Try again later.'));
          break;
        case 'invalid-email':
          emit(AuthErrorState(message: 'Invalid email'));
          break;
        default:
          emit(AuthErrorState(message: e.message!));
      }
    }
  }

  Future<void> signOut() async {
    emit(AuthLoadingState());
    try {
      await usecase().auth.signOut();
      emit(AuthLoggedOutState());
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
      rethrow;
    }
  }

  Future<void> isSignedIn() async {
    emit(AuthLoadingState());
    try {
      final isSignedIn = await usecase().auth.isSignedIn();
      if (isSignedIn) {
        emit(AuthLoggedInState());
      } else {
        emit(AuthLoggedOutState());
      }
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
      rethrow;
    }
  }

  Future<User?> getCurrentUser() async {
    return await usecase().auth.getCurrentUser();
  }

  Future<String> getCurrentUserId() async {
    return await usecase().auth.getCurrentUserId();
  }
}
