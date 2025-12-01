import 'dart:convert';
import 'dart:developer' as dev;

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/utils/constants/app_keys.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';

class SharedPreferenceManager {
  static late final EncryptedSharedPreferences _instance;

  static Future init() async {
    // Get encryption key from environment variables
    const encryptionKey = AppKeys.storageEncryptionKey;

    // Security warning in debug mode
    if (AppKeys.isUsingDefaultKey) {
      dev.log(
        '⚠️ WARNING: Using default encryption key. '
        'Define STORAGE_ENCRYPTION_KEY for production!',
        name: 'SharedPreferenceManager',
      );
    }
    await EncryptedSharedPreferences.initialize(encryptionKey);
    _instance = EncryptedSharedPreferences.getInstance();

    _instance.observe(key: 'access-token').listen((event) {
      // event = key
      print("test encrypt$event.");
    });

    _instance.observe(key: 'refresh-token').listen((event) {
      // event = key
      String? value = _instance.getString("access-token");
      print("test encrypt$value");
    });
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

  static Future<bool> deleteUser() async {
    String? userRes = _instance.getString("user");
    bool result = false;
    if (userRes != null) {
      result = await _instance.remove("user");
    }
    return result;
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
