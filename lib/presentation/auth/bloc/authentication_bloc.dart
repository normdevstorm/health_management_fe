import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/managers/session_manager.dart';
import 'package:health_management/data/auth/models/request/login_request_model.dart';
import 'package:health_management/domain/auth/entities/login_entity.dart';
import 'package:health_management/domain/auth/usecases/authentication_usecase.dart';
import 'package:health_management/domain/verify_code/usecases/verify_code_usecase.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';

import '../../../app/app.dart';
import '../../../data/auth/models/request/register_request_model.dart';
import '../../../domain/auth/entities/register_entity.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationUsecase authenticationUsecase;
  final VerifyCodeUseCase verifyCodeUseCase;
  AuthenticationBloc(
      {required this.authenticationUsecase, required this.verifyCodeUseCase})
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoginSubmitEvent>((event, emit) => onLoginSubmit(event, emit));
    on<CheckLoginStatusEvent>(
        (event, emit) => onCheckLoginStatusEvent(event, emit));
    on<LogOutEvent>((event, emit) => onLogOutEvent(event, emit));
    on<RegisterSubmitEvent>((event, emit) => onRegisterEvent(event, emit));
  }

  onLoginSubmit(
      LoginSubmitEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoading());
    try {
      LoginRequest loginRequest = LoginRequest(
          email: event.email,
          password: event.password,
          fcmToken:
              "cAdhk0s-QIacSG-bsRbLsC:APA91bEOrduaBH8NRaQCvchuX1MYNMtpFyTQe1yu5aLadWblHN7v8Ik6pCBbn26VoMP5kHfvGGoJpGTIXPZumNTXflRwBcnO6e0Qo2PIlyESq_s1oAnYcvt7BXEn33JxJUm-tkq8130Q");
      final loginEntity = await authenticationUsecase.login(loginRequest);
      emit(LoginSuccess(loginEntity));
    } on ApiException catch (e) {
      getIt<Logger>().e(e);
      emit(LoginError(ApiException.getErrorMessage(e)));
    }
  }

  onCheckLoginStatusEvent(
      CheckLoginStatusEvent event, Emitter<AuthenticationState> emit) {
    emit(LoginLoading());
    try {
      final loginEntity = SessionManager().getSession();
      if (loginEntity == null) {
        emit(AuthenticationInitial());
        return;
      } else {
        bool hasExpired = JwtDecoder.isExpired(loginEntity.accessToken ?? "");
        if (hasExpired) {
          SessionManager().clearSession();
          emit(const LoginError("Token Expired !!!!"));
        } else {
          emit(LoginSuccess(loginEntity));
        }
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  onLogOutEvent(LogOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoading());
    try {
      await authenticationUsecase.logout();
      emit(AuthenticationInitial());
    } on Exception catch (e) {
      getIt<Logger>().e(e);
      emit(LoginError(e.toString()));
    }
  }

  onRegisterEvent(
      RegisterSubmitEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(LoginLoading());
      // final registerEntity = await authenticationUsecase.register(
      //     RegisterRequest(
      //         email: event.email,
      //         password: event.password,
      //         username: event.username,
      //         role: event.role));
      await verifyCodeUseCase.verifyCode(event.email);
      emit(LoginSuccess(LoginEntity(
          accessToken: "sdfbsdjf",
          refreshToken: "sfjshdfsjfhksj")));
    } on ApiException catch (e) {
      emit(LoginError(ApiException.getErrorMessage(e)));
    }
  }
}
