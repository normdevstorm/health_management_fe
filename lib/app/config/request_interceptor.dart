import 'package:dio/dio.dart';
import 'package:health_management/app/managers/session_manager.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    // super.onRequest(options, handler);
    if (options.path.startsWith('/auth')) {
      handler.next(options);
      return;
    }  else {
      final accessToken =
          'Bearer ${SessionManager().getSession()?.accessToken}';
      options.headers.addAll({'Authorization': accessToken});
      handler.next(options);
      return;
    }
  }
}
