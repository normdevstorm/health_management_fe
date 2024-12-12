import 'dart:convert';

import 'package:health_management/app/app.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
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

  static String? readUserId() {
    return _instance.getString("user-id");
  }

  static Future<void> setUserId(String userId) async {
    _instance.setString("user-id", userId);
  }

  static Future<bool> deleteUserId() {
    return _instance.remove("user-id");
  }

  static Future<void> setUser(UserEntity userEntity) async {
    _instance.setString("user", jsonEncode(userEntity.toJson()));
  }

  static Future<UserEntity?> getUser() async {
    String? userRes = _instance.getString("user");
    if (userRes != null) {
      return UserEntity.fromJson(jsonDecode(userRes));
    }
    return null;
  }

  static Future<Role> getUserRole() async {
    UserEntity? user = await getUser();
    if (user != null) {
      return user.account!.role!;
    }
    return Role.user;
  }

  static Future<void> saveFcmToken(String fcmToken) async {
    await _instance.setString("fcmToken", fcmToken);
  }

  static String? readFcmToken() {
    return _instance.getString("fcmToken");
  }

  static Future<bool> deleteFcmToken() {
    return _instance.remove("fcmToken");
  }
}
