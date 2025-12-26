import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt_lib;
import 'package:encrypt_shared_preferences/src/crypto/encryptor.dart';

/// Custom Encryptor implementation that supports 32-byte (256-bit) keys.
///
/// This allows using longer, more secure encryption keys compared to the
/// default 16-byte (128-bit) key limitation.
class CustomAES256Encryptor implements IEncryptor {
  final String _key;

  /// Creates a CustomAES256Encryptor with the provided key.
  ///
  /// The key can be any length, but 32 bytes (256 bits) is recommended for AES-256.
  /// If the key is shorter than 32 bytes, it will be padded.
  /// If longer, it will be truncated to 32 bytes.
  CustomAES256Encryptor(String key) : _key = _normalizeKey(key);

  /// Gets the normalized key for encryption/decryption.
  String get key => _key;

  /// Normalizes the key to exactly 32 bytes for AES-256.
  ///
  /// Handles both base64-encoded keys and raw string keys.
  /// - If key is base64-encoded: decodes it first, then normalizes
  /// - If key is shorter than 32 bytes: pads with zeros
  /// - If key is longer than 32 bytes: truncates to 32 bytes
  /// - If key is exactly 32 bytes: uses as-is
  /// Returns base64-encoded normalized key for use with encrypt package
  static String _normalizeKey(String key) {
    List<int> keyBytes;

    // Try to decode as base64 first (if it's already base64-encoded)
    try {
      keyBytes = base64Url.decode(key);
      // If decoding succeeds and we have bytes, use them
      if (keyBytes.isNotEmpty) {
        // Already decoded, proceed with normalization
      } else {
        // Empty after decode, try as UTF-8
        keyBytes = utf8.encode(key);
      }
    } catch (e) {
      // Not base64, treat as UTF-8 string
      keyBytes = utf8.encode(key);
    }

    // Normalize to exactly 32 bytes
    List<int> normalizedBytes;
    if (keyBytes.length == 32) {
      normalizedBytes = keyBytes;
    } else if (keyBytes.length < 32) {
      // Pad with zeros
      normalizedBytes = List<int>.from(keyBytes);
      normalizedBytes.addAll(List.filled(32 - keyBytes.length, 0));
    } else {
      // Truncate to 32 bytes
      normalizedBytes = keyBytes.sublist(0, 32);
    }

    // Return base64-encoded for use with encrypt package Key.fromBase64()
    return base64.encode(normalizedBytes);
  }

  @override
  String decrypt(String encryptedData, String key) {
    try {
      // Use the provided key (normalized) or fall back to instance key
      final normalizedKey = _normalizeKey(key.isNotEmpty ? key : _key);

      // Decode the base64-encoded encrypted data
      final encryptedBytes = base64.decode(encryptedData);

      // Extract IV (first 16 bytes) and ciphertext (rest)
      if (encryptedBytes.length < 16) {
        throw Exception('Invalid encrypted data: too short');
      }

      final ivBytes = encryptedBytes.sublist(0, 16);
      final ciphertextBytes = encryptedBytes.sublist(16);

      // Create IV and key objects
      final iv = encrypt_lib.IV(ivBytes);
      final keyObj = encrypt_lib.Key.fromBase64(normalizedKey);

      // Create encrypter with AES mode
      final encrypter = encrypt_lib.Encrypter(
        encrypt_lib.AES(keyObj, mode: encrypt_lib.AESMode.cbc),
      );

      // Create encrypted object and decrypt
      final encrypted = encrypt_lib.Encrypted(ciphertextBytes);
      final decrypted = encrypter.decrypt(encrypted, iv: iv);

      return decrypted;
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }

  @override
  String encrypt(String plaintext, String key) {
    try {
      // Use the provided key (normalized) or fall back to instance key
      final normalizedKey = _normalizeKey(key.isNotEmpty ? key : _key);

      // Create IV (16 bytes for AES)
      final iv = encrypt_lib.IV.fromLength(16);

      // Create key object from normalized key
      final keyObj = encrypt_lib.Key.fromBase64(normalizedKey);

      // Create encrypter with AES mode
      final encrypter = encrypt_lib.Encrypter(
        encrypt_lib.AES(keyObj, mode: encrypt_lib.AESMode.cbc),
      );

      // Encrypt the plaintext
      final encrypted = encrypter.encrypt(plaintext, iv: iv);

      // Combine IV and ciphertext, then base64 encode
      final combined = <int>[];
      combined.addAll(iv.bytes);
      combined.addAll(encrypted.bytes);

      return base64.encode(combined);
    } catch (e) {
      throw Exception('Encryption failed: $e');
    }
  }
}
