import 'dart:convert';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class CacheManager {
  static Future<CacheOptions> dioCacheoptions() async {
    // 1. Initialize Hive (Creates IndexedDB on Web / Files on Mobile)
    await Hive.initFlutter();
    const secureStorage = FlutterSecureStorage();
    final String? keyString =
        await secureStorage.read(key: 'dio_cache_encryption_key');

    List<int> encryptionKey;

    if (keyString == null) {
      // Generate a secure random key
      encryptionKey = Hive.generateSecureKey();
      // Store it securely (On Web, this goes to internal secure storage/cookie)
      await secureStorage.write(
          key: 'dio_cache_encryption_key',
          value: base64UrlEncode(encryptionKey));
    } else {
      encryptionKey = base64Decode(keyString);
    }

    // --- Step 2: Define Storage Path (Mobile Only) ---
    // On Web, 'path' is ignored because IndexedDB manages its own paths.
    String? path;
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      path = dir.path;
    }
    // final aesCipher = HiveAesCipher(encryptionKey);
    final cacheStore = HiveCacheStore(
      path, // Null on web, Valid path on Mobile
      hiveBoxName: 'dio_secure_cache',
      // encryptionCipher: HiveCipher,
    );

    // Initialize AES CBC encrypter using the generated secure key.
    final encrypter = enc.Encrypter(
      enc.AES(enc.Key(Uint8List.fromList(encryptionKey)),
          mode: enc.AESMode.cbc),
    );

    return CacheOptions(
      // Use persistent encrypted Hive cache store.
      store: cacheStore,

      // All subsequent fields are optional to get a standard behaviour.

      // Default.
      policy: CachePolicy.request,
      // hitCacheOnErrorExcept: [],
      // hitCacheOnNetworkFailure: true,
      // Overrides any HTTP directive to delete entry past this duration.
      // Useful only when origin server has no cache config or custom behaviour is desired.
      // Defaults to `null`.
      maxStale: const Duration(minutes: 5),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: CacheCipher(
        encrypt: (bytes) async {
          // Generate a random IV (16 bytes) for every write
          final iv = enc.IV.fromLength(16);
          final encrypted = encrypter.encryptBytes(bytes, iv: iv);

          // Return: [IV Bytes] + [Encrypted Data]
          return [...iv.bytes, ...encrypted.bytes];
        },
        decrypt: (bytes) async {
          // Extract IV (first 16 bytes)
          final iv = enc.IV(Uint8List.fromList(bytes.sublist(0, 16)));

          // Extract Data (remaining bytes)
          final encryptedData =
              enc.Encrypted(Uint8List.fromList(bytes.sublist(16)));

          // Decrypt
          return encrypter.decryptBytes(encryptedData, iv: iv);
        },
      ),
      // Default. Key builder to retrieve requests.
      keyBuilder: (request) {
        return request.uri.path.toString();
      },
      // Default. Allows to cache POST requests.
      // Assigning a [keyBuilder] is strongly recommended when `true`.
      allowPostMethod: false,
    );
  }
}
