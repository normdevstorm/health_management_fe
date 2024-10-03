import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_management/data/auth/models/request/login_request_model.dart';
import 'package:health_management/domain/login/entities/login_entity.dart';
import 'package:health_management/domain/login/usecases/authentication_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationUsecase authenticationUsecase;
  LoginBloc({required this.authenticationUsecase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoginSubmitEvent>((event, emit) => _onLoginSubmit(event, emit));
  }

  _onLoginSubmit(LoginSubmitEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      LoginRequest loginRequest = LoginRequest(
          email: event.email,
          password: event.password,
          fcmToken:
              "cAdhk0s-QIacSG-bsRbLsC:APA91bEOrduaBH8NRaQCvchuX1MYNMtpFyTQe1yu5aLadWblHN7v8Ik6pCBbn26VoMP5kHfvGGoJpGTIXPZumNTXflRwBcnO6e0Qo2PIlyESq_s1oAnYcvt7BXEn33JxJUm-tkq8130Q");
      final loginEntity = await authenticationUsecase.login(loginRequest);
      emit(LoginSuccess(loginEntity));
    } catch (e) {
      print(e);
      emit(LoginError(e.toString()));
    }
  }
}
