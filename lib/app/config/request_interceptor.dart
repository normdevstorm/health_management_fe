import 'package:dio/dio.dart';
import 'package:health_management/app/managers/session_manager.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    // super.onRequest(options, handler);
    if (['/auth/register', '/auth/login', '/auth/refresh-token', '/mail/verify_code']
        .contains(options.path)) {
      handler.next(options);
      return;
    } else if (options.path == '/auth/logout') {
      final refreshToken =
          'Bearer ${SessionManager().getSession()?.refreshToken}';
      options.headers.addAll({'Authorization': refreshToken});
      handler.next(options);
      return;
    } else {
      final accessToken =
          'Bearer ${SessionManager().getSession()?.accessToken}';
      options.headers.addAll({'Authorization': accessToken});
      handler.next(options);
      return;
    }
  }
}
