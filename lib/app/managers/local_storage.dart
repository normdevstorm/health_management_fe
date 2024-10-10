import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  //TODO: ENCRYPT THE DATA INTO STORAGE
  static late final SharedPreferences _instance;

  static Future init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future<void> setAccessToken(String accessToken) async {
    _instance.setString("access-token", accessToken);
  }

  static String? readAccessToken() {
    return _instance.getString("access-token");
  }

  static Future<bool> deleteAccessToken() {
    return _instance.remove("access-token");
  }

  static Future<void> setRefreshToken(String refreshToken) async {
    _instance.setString("refresh-token", refreshToken);
  }

  static String? readRefreshToken() {
    return _instance.getString("refresh-token");
  }

  static Future<bool> deleteRefreshToken() {
    return _instance.remove("refresh-token");
  }

  static Future<void> setLoginStatus(bool isLogin) async {
    _instance.setBool("isLogin", isLogin);
  }

  static bool? readLoginStatus() {
    return _instance.getBool("isLogin");
  }
}
