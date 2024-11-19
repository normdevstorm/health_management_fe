import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/app/managers/session_manager.dart';
import 'package:health_management/data/auth/models/request/login_request_model.dart';
import 'package:health_management/domain/auth/entities/login_entity.dart';
import 'package:health_management/domain/auth/usecases/authentication_usecase.dart';
import 'package:health_management/domain/chat/models/account_model.dart';
import 'package:health_management/domain/chat/models/profile_model.dart';
import 'package:health_management/domain/chat/models/user_model.dart';
import 'package:health_management/domain/chat/usecases/app_use_cases.dart';
import 'package:health_management/domain/verify_code/usecases/verify_code_usecase.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';

import '../../../app/app.dart';
import '../../../app/utils/functions/hash_password.dart';
import '../../../data/auth/models/request/register_request_model.dart';
import '../../../domain/auth/entities/register_entity.dart';
import '../../../domain/verify_code/entities/validate_code_entity.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationUsecase authenticationUsecase;
  final VerifyCodeUseCase verifyCodeUseCase;
  final AppChatUseCases appChatUseCases;
  AuthenticationBloc(
      {required this.authenticationUsecase,
      required this.verifyCodeUseCase,
      required this.appChatUseCases})
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<LoginSubmitEvent>((event, emit) => onLoginSubmit(event, emit));
    on<CheckLoginStatusEvent>(
        (event, emit) => onCheckLoginStatusEvent(event, emit));
    on<LogOutEvent>((event, emit) => onLogOutEvent(event, emit));
    on<RegisterSubmitEvent>((event, emit) => onRegisterEvent(event, emit));
    on<VerifyCodeSubmitEvent>(
        (event, emit) => onVerifyCodeSubmitEvent(event, emit));
    on<GetVerifyCodeEvent>((event, emit) => onGetVerifyCodeEvent(event, emit));
  }

  onLoginSubmit(
      LoginSubmitEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      LoginEntity? loginEntity = await loginMainService(event);
      await loginFirebaseChat(event);
      if (loginEntity != null) {
        emit(LoginSuccess(loginEntity));
      } else {
        emit(const LoginError("Login failed"));
      }
    } on ApiException catch (e) {
      getIt<Logger>().e(e);
      emit(LoginError(ApiException.getErrorMessage(e)));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          emit(const LoginError('No user found for that email.'));
          break;
        case 'wrong-password':
          emit(const LoginError('Wrong password provided for that user.'));
          break;
        case 'too-many-requests':
          emit(const LoginError('Too many requests. Try again later.'));
          break;
        case 'invalid-email':
          emit(const LoginError('Invalid email'));
          break;
        default:
          emit(const LoginError('Login failed'));
      }
    }
  }

  Future<void> loginFirebaseChat(LoginSubmitEvent event) async {
    appChatUseCases.auth
        .hasExistedUser(event.email)
        .then((hasRegistered) async {
      if (!hasRegistered) {
        SharedPreferenceManager.getUser().then((value) {
          if (value != null) {
            if (value.account?.role == Role.doctor) {
              registerToFirebase(
                  email: event.email,
                  password: event.password,
                  username: event.email,
                  role: Role.doctor);
            }
          }
        });
      } else {
        appChatUseCases.auth.signIn(event.email, event.password);
      }
    });
    return;
  }

  Future<LoginEntity?> loginMainService(LoginSubmitEvent event) async {
    final String fcmToken = SharedPreferenceManager.readFcmToken() ??
        "cAdhk0s-QIacSG-bsRbLsC:APA91bEOrduaBH8NRaQCvchuX1MYNMtpFyTQe1yu5aLadWblHN7v8Ik6pCBbn26VoMP5kHfvGGoJpGTIXPZumNTXflRwBcnO6e0Qo2PIlyESq_s1oAnYcvt7BXEn33JxJUm-tkq8130Q";
    LoginRequest loginRequest = LoginRequest(
        email: event.email, password: event.password, fcmToken: fcmToken);
    final loginEntity = await authenticationUsecase.login(loginRequest);
    return loginEntity;
  }

  onCheckLoginStatusEvent(
      CheckLoginStatusEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      // check session in local storage
      final loginEntity = SessionManager().getSession();
      final bool isLogin = SessionManager().getLoginStatus() ?? false;
      // check session in firebase
      bool isSignIn = await appChatUseCases.auth.isSignedIn();
      User? user = await appChatUseCases.auth.getCurrentUser();

      if (loginEntity == null ||
          isLogin == false
          //  ||
          // user == null ||
          // !isSignIn
          ) {
        if (loginEntity != null) {
          SessionManager().clearSession();
        }
        emit(AuthenticationInitial());
      } else {
        bool hasExpired = JwtDecoder.isExpired(loginEntity.accessToken ?? "");
        if (hasExpired) {
          await authenticationUsecase
              .refreshToken(loginEntity.refreshToken ?? "");
        }
        emit(LoginSuccess(loginEntity));
      }
    } on ApiException catch (e) {
      SessionManager().clearSession();
      emit(CheckLoginStatusErrorState(ApiException.getErrorMessage(e)));
    } on FirebaseAuthException catch (e) {
      SessionManager().clearSession();
      emit(CheckLoginStatusErrorState(e.message ?? ""));
    } catch (e) {
      SessionManager().clearSession();
      emit(CheckLoginStatusErrorState(e.toString()));
    }
  }

  onLogOutEvent(LogOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      await authenticationUsecase.logout();
      await appChatUseCases.auth.signOut();
      emit(AuthenticationInitial());
    } on ApiException catch (e) {
      getIt<Logger>().e(e);
      emit(LoginError(ApiException.getErrorMessage(e)));
    } on FirebaseAuthException catch (e) {
      getIt<Logger>().e(e);
      emit(LoginError(e.message ?? ""));
    }
  }

  onRegisterEvent(
      RegisterSubmitEvent event, Emitter<AuthenticationState> emit) async {
    try {
      RegisterEntity? registerEntity = await registerToMainService(emit, event);
      await registerToFirebase(
          email: event.email,
          password: event.password,
          username: event.username);
      emit(RegisterSuccess(registerEntity));
    } on ApiException catch (e) {
      emit(LoginError(ApiException.getErrorMessage(e)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const LoginError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(const LoginError('The account already exists for that email.'));
      } else {
        emit(LoginError('Error: ${e.message}'));
      }
    } catch (e) {
      emit(LoginError('Error: ${e.toString()}'));
    }
  }

  Future<void> registerToFirebase(
      {required String email,
      required String password,
      required String username,
      Role role = Role.user}) async {
    try {
      final userCredential = await appChatUseCases.auth.signUp(email, password);
      User? user = userCredential.user;
      if (user != null) {
        // emit(AuthSignUpSuccess(user: user));
        String hashedPassword = hashPassword(password);
        // Save user, account, profile to firestore
        appChatUseCases.user.insertAccount(
            ChatAccount(uid: user.uid, email: email, password: hashedPassword));
        appChatUseCases.user.insertProfile(ChatProfile(
          uid: user.uid,
          userName: username,
          email: email,
          avatar:
              'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
        ));
        UserChatModel saveUser = UserChatModel(
          uid: user.uid,
          userName: username,
          profileImage:
              'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
          lastSeen: DateTime.now(),
          groupId: [],
          isOnline: true,
          role: role,
        );
        appChatUseCases.user.insertUser(saveUser);
      }
    } catch (e) {
      // TODO
      Logger().e(e);
      rethrow;
    }
  }

  Future<RegisterEntity?> registerToMainService(
      Emitter<AuthenticationState> emit, RegisterSubmitEvent event) async {
    emit(AuthenticationLoading());
    final registerEntity = await authenticationUsecase.register(RegisterRequest(
        email: event.email,
        password: event.password,
        username: event.username,
        role: event.role));
    return registerEntity;
  }

  onVerifyCodeSubmitEvent(
      VerifyCodeSubmitEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final result = await verifyCodeUseCase.validateCode(
          ValidateCodeEntity(email: event.email, code: event.code));
      emit(VerifyCodeSuccess(result, event.registerSubmitEvent));
    } on ApiException catch (e) {
      emit(VerifyCodeError(ApiException.getErrorMessage(e)));
    }
  }

  onGetVerifyCodeEvent(
      GetVerifyCodeEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final result = await verifyCodeUseCase.verifyCode(event.email);
      emit(GetVerifyCodeSuccess(result));
    } on ApiException catch (e) {
      emit(GetVerifyCodeError(ApiException.getErrorMessage(e)));
    }
  }
}
