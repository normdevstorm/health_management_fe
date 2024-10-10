import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/managers/session_manager.dart';
import 'package:health_management/data/auth/models/request/login_request_model.dart';
import 'package:health_management/domain/login/entities/login_entity.dart';
import 'package:health_management/domain/login/usecases/authentication_usecase.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';

import '../../../app/app.dart';
import '../../../data/auth/models/request/register_request_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationUsecase authenticationUsecase;
  LoginBloc({required this.authenticationUsecase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoginSubmitEvent>((event, emit) => onLoginSubmit(event, emit));
    on<CheckLoginStatusEvent>(
        (event, emit) => onCheckLoginStatusEvent(event, emit));
    on<LogOutEvent>((event, emit) => onLogOutEvent(event, emit));
    on<RegisterEvent>((event, emit) => onRegisterEvent(event, emit));
  }

  onLoginSubmit(LoginSubmitEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      LoginRequest loginRequest = LoginRequest(
          email: event.email,
          password: event.password,
          fcmToken:
              "cAdhk0s-QIacSG-bsRbLsC:APA91bEOrduaBH8NRaQCvchuX1MYNMtpFyTQe1yu5aLadWblHN7v8Ik6pCBbn26VoMP5kHfvGGoJpGTIXPZumNTXflRwBcnO6e0Qo2PIlyESq_s1oAnYcvt7BXEn33JxJUm-tkq8130Q");
      final loginEntity = await authenticationUsecase.login(loginRequest);
      SessionManager().setSession(
          loginEntity ?? LoginEntity(accessToken: null, refreshToken: null),
          true);
      emit(LoginSuccess(loginEntity));
    } on ApiException catch (e) {
      getIt<Logger>().e(e);
      emit(LoginError(ApiException.getErrorMessage(e)));
    }
  }

  onCheckLoginStatusEvent(
      CheckLoginStatusEvent event, Emitter<LoginState> emit) {
    emit(LoginLoading());
    try {
      final loginEntity = SessionManager().getSession();
      if (loginEntity == null) {
        emit(LoginInitial());
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

  onLogOutEvent(LogOutEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final String refreshToken =
          SessionManager().getSession()?.refreshToken ?? "";
      await authenticationUsecase.logout(refreshToken);
      SessionManager().clearSession();
      emit(LoginInitial());
    } on Exception catch (e) {
        getIt<Logger>().e(e);
      emit(LoginError(e.toString()));
    }
  }

  onRegisterEvent(RegisterEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      final registerResponse = await authenticationUsecase.register(
          RegisterRequest(
              email: event.email,
              password: event.password,
              username: event.username,
              role: event.role));
      emit(LoginSuccess(LoginEntity(
          accessToken: registerResponse?.accessToken,
          refreshToken: registerResponse?.refreshToken)));
    } on ApiException catch (e) {
      emit(LoginError(ApiException.getErrorMessage(e)));
    }
  }
}
