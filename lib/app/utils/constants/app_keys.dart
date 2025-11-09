/// App encryption keys and secrets
/// These should be defined at compile time using --dart-define
class AppKeys {
  /// Encryption key for SharedPreferences
  /// Define using: --dart-define=STORAGE_ENCRYPTION_KEY=your_key_here
  static const String storageEncryptionKey = String.fromEnvironment(
    'STORAGE_ENCRYPTION_KEY',
    defaultValue: 'dev_default_key_only_for_development_DO_NOT_USE_IN_PROD',
  );

  /// Check if using default development key (for security warnings)
  static bool get isUsingDefaultKey =>
      storageEncryptionKey ==
      'dev_default_key_only_for_development_DO_NOT_USE_IN_PROD';
}
