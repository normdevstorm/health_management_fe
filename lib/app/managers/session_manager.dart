import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/domain/auth/entities/login_entity.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  void setSession(LoginEntity session, bool isLogin) async {
    if (session.accessToken != null && session.refreshToken != null) {
      await SharedPreferenceManager.setAccessToken(session.accessToken!);
      await SharedPreferenceManager.setRefreshToken(session.refreshToken!);
      await SharedPreferenceManager.setLoginStatus(isLogin);
    }
    return null;
  }

  LoginEntity? getSession() {
    String? accessToken = SharedPreferenceManager.readAccessToken();
    String? refreshToken = SharedPreferenceManager.readRefreshToken();
    if (accessToken != null && refreshToken != null) {
      return LoginEntity(accessToken: accessToken, refreshToken: refreshToken);
    }
    return null;
  }

  bool? getLoginStatus() {
    return SharedPreferenceManager.readLoginStatus();
  }

  void setLoginStatus(bool isLogin) async {
    await SharedPreferenceManager.setLoginStatus(isLogin);
    return null;
  }

  void clearSession() {
    if (getSession() != null) {
      SharedPreferenceManager.deleteAccessToken();
      SharedPreferenceManager.deleteRefreshToken();
      SharedPreferenceManager.setLoginStatus(false);
    }
  }
}
