import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/app/managers/session_manager.dart';
import 'package:health_management/app/route/app_routing.dart';
import 'package:health_management/presentation/auth/bloc/authentication_bloc.dart';
import 'package:logger/logger.dart';
import '../../domain/auth/usecases/authentication_usecase.dart';
import '../di/injection.dart';

class RefreshTokenInterceptor extends Interceptor {
  List<Map<dynamic, dynamic>> failedRequests = [];
  RefreshTokenInterceptor();
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if ([401].contains(err.response?.statusCode) &&
        err.response?.requestOptions.path != '/auth/login') {
      if (SessionManager().getSession()?.refreshToken == null) {
        BlocProvider.of<AuthenticationBloc>(
                globalRootNavigatorKey.currentContext!)
            .add(const CheckLoginStatusEvent());

        return handler.reject(err);
      } else {
        try {
          final refreshTokenResponse = await getIt<AuthenticationUsecase>()
              .refreshToken(SessionManager().getSession()?.refreshToken ?? "");
          if (refreshTokenResponse != null) {
            getIt<Logger>().i(SessionManager().getSession()?.accessToken);

            SessionManager().setSession(refreshTokenResponse, true);
            err.requestOptions.headers['Authorization'] =
                'Bearer ${SessionManager().getSession()!.accessToken}';
            // TODO Retry all the requests that were added to the queue
            getIt<Logger>().i(SessionManager().getSession()?.accessToken);
            for (var request in failedRequests) {
              request['handler'].resolve(request['err']);
            }
          } else {
            err.copyWith(message: 'Failed to refresh token');
            BlocProvider.of<AuthenticationBloc>(
                    globalRootNavigatorKey.currentContext!)
                .add(const CheckLoginStatusEvent());
            // If the refresh process fails, reject with the previous error
            return handler.next(err);
          }
        } catch (e) {
          SessionManager().clearSession();
          BlocProvider.of<AuthenticationBloc>(
                  globalRootNavigatorKey.currentContext!)
              .add(const CheckLoginStatusEvent());

          throw ApiException.getDioException(e);
        }
        // Adding errored request to the queue
      }
    } else {
      return handler.next(err);
    }
  }
}
