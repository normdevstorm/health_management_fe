import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/utils/constants/app_keys.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';

class SharedPreferenceManager {
  static late final EncryptedSharedPreferences _instance;

  // Key used to store the runtime-generated encryption key in secure storage.
  static const String _secureStorageKeyName = 'storage_encryption_key';
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future init() async {
    // Prefer a runtime-generated key stored in secure storage.
    // This avoids shipping a static key in the app binary.
    final encryptionKey = await _getOrCreateEncryptionKey();

    // Security warning in debug mode if we ever fall back to the default key.
    if (AppKeys.isUsingDefaultKey) {
      dev.log(
        '⚠️ WARNING: Using default encryption key. '
        'Configure a secure runtime key strategy for production!',
        name: 'SharedPreferenceManager',
      );
    }

    dev.log(
      'Initializing EncryptedSharedPreferences with 16-character key (length: ${encryptionKey.length})',
      name: 'SharedPreferenceManager',
    );

    // Initialize with default encryptor (requires exactly 16-character key)
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

  /// - First, tries to load a previously generated key from secure storage.
  /// - If none exists, generates a new random key, persists it securely,
  ///   and uses that from now on.
  ///
  /// Note: The default AES encryptor requires exactly 16 characters.
  static Future<String> _getOrCreateEncryptionKey() async {
    // 1. Try to read an existing key from secure storage.
    final existingKey = await _secureStorage.read(key: _secureStorageKeyName);
    if (existingKey != null &&
        existingKey.isNotEmpty &&
        existingKey.length == 16) {
      return existingKey;
    }

    // 2. No key yet → generate a new 16-character random key (for AES-128).
    // The default AES encryptor requires exactly 16 characters (not bytes).
    final random = Random.secure();
    final newKey = String.fromCharCodes(
      List.generate(
        16,
        (_) => AppKeys.keyGenerationChars.codeUnitAt(
          random.nextInt(AppKeys.keyGenerationChars.length),
        ),
      ),
    );

    // 3. Persist the key in secure storage for future app launches.
    await _secureStorage.write(key: _secureStorageKeyName, value: newKey);

    return newKey;
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
