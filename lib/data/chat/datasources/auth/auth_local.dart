import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> setUserId(String userId);

  Future<String> getUserId();

  Future<void> removeUserId();
  Future<bool> isUserLoggedIn();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  static const String _userIdKey = "USER_ID";

  AuthLocalDataSourceImpl();

  @override
  Future<bool> isUserLoggedIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(_userIdKey) != null;
  }

  @override
  Future<bool> setUserId(String userId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.setString(_userIdKey, userId);
  }

  @override
  Future<String> getUserId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(_userIdKey) ?? "";
  }

  @override
  Future<bool> removeUserId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.remove(_userIdKey);
  }
}
