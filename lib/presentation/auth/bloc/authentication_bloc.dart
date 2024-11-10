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
import '../../../domain/verify_code/entities/validate_code_entity.dart';

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
    });
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
    emit(AuthenticationLoading());
    try {
      final loginEntity = SessionManager().getSession();
      final bool isLogin = SessionManager().getLoginStatus() ?? false;
      if (loginEntity == null || isLogin == false) {
        if (loginEntity != null) {
          SessionManager().clearSession();
        }
        emit(AuthenticationInitial());
        return;
      } else {
        bool hasExpired = JwtDecoder.isExpired(loginEntity.accessToken ?? "");
        if (hasExpired) {
          SessionManager().clearSession();
          emit(const CheckLoginStatusErrorState("Token Expired !!!!"));
        } else {
          emit(LoginSuccess(loginEntity));
        }
      }
    } on ApiException catch (e) {
      emit(CheckLoginStatusErrorState(ApiException.getErrorMessage(e)));
    }
  }

  onLogOutEvent(LogOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      await authenticationUsecase.logout();
      emit(AuthenticationInitial());
    } on ApiException catch (e) {
      getIt<Logger>().e(e);
      emit(LoginError(ApiException.getErrorMessage(e)));
    }
  }

  onRegisterEvent(
      RegisterSubmitEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationLoading());
      final registerEntity = await authenticationUsecase.register(
          RegisterRequest(
              email: event.email,
              password: event.password,
              username: event.username,
              role: event.role));
      emit(RegisterSuccess(registerEntity));
    } on ApiException catch (e) {
      emit(LoginError(ApiException.getErrorMessage(e)));
    }
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
