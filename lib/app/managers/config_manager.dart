part of '../app.dart';

enum FlavorManager { dev, staging, production }

class ConfigManager {
  final String apiBaseUrl;
  final FlavorManager appFlavor;
  //TODO: Add more config variables here
  final FirebaseOptions firebaseOptions;

  ConfigManager._({
    required this.apiBaseUrl,
    required this.appFlavor,
    required this.firebaseOptions,
  });

  static ConfigManager? _instance;

  static ConfigManager devConfig = ConfigManager._(
    apiBaseUrl: 'https://api.duynguyendev.xyz/api/v1/core',
    appFlavor: FlavorManager.dev,
    firebaseOptions: DefaultFirebaseOptionsStg.currentPlatform,
  );

  static ConfigManager stagingConfig = ConfigManager._(
    apiBaseUrl: 'http://localhost:8080/api/v1/core',
    appFlavor: FlavorManager.staging,
    firebaseOptions: DefaultFirebaseOptionsStg.currentPlatform,
  );

  static ConfigManager productionConfig = ConfigManager._(
    apiBaseUrl: 'https://api.duynguyendev.xyz/api/v1/core',
    appFlavor: FlavorManager.production,
    firebaseOptions: DefaultFirebaseOptionsProd.currentPlatform,
  );

  static ConfigManager getInstance({String? flavorName}) {
    if (_instance == null) {
      switch (flavorName) {
        case 'dev':
          _instance = devConfig;
          break;
        case 'staging':
          _instance = stagingConfig;
          break;
        case 'production':
          _instance = productionConfig;
          break;
        default:
          _instance = devConfig;
          break;
      }

      return _instance!;
    } else {
      return _instance!;
    }
  }
}
