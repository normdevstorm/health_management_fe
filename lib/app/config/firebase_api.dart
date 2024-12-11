import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/web.dart';
import 'package:health_management/firebase_options_cloud_message.dart'
    as firebase_options_cloud_message;

@injectable
class FirebaseMessageService {
  Future<void> initNotificaiton() async {
    await Firebase.initializeApp(
      options:
          firebase_options_cloud_message.DefaultFirebaseOptions.currentPlatform,
    );
    final firebaseMessaging = FirebaseMessaging.instance;
    final firebaseInAppMessaging = FirebaseInAppMessaging.instance;
      if (!kIsWeb) {
  final fcmToken = await firebaseMessaging.getToken();
  if(fcmToken != null) {
    await SharedPreferenceManager.saveFcmToken(fcmToken);
  }
  final firebaseInstallationId = await FirebaseInstallations.instance.getId();
  getIt<Logger>().i("FCMToken: $fcmToken");
  getIt<Logger>().i("InstallationId: $firebaseInstallationId");
  requestNotificationPermissions(firebaseMessaging);
  FirebaseMessaging.onBackgroundMessage(_handlerBackgorundMessage);
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    getIt<Logger>().i("onMessageOpenedApp: $message");
  });
  FirebaseMessaging.onMessage.listen((message) {
    getIt<Logger>().i("onMessage: $message");
  });
  firebaseInAppMessaging.setAutomaticDataCollectionEnabled(true);
  FirebaseMessaging.onMessage.listen((message) {
    getIt<Logger>().i("onMessage: $message");
  });
}
  }
}

Future<void> _handlerBackgorundMessage(RemoteMessage message) async {
  //TODO: TO HANDLE THE MESSAGE DATA 401 LATER ON
  await Firebase.initializeApp();
  getIt<Logger>().i("onBackgroundMessage: $message");
}

Future<void> requestNotificationPermissions(FirebaseMessaging messaging) async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    getIt<Logger>().i('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    getIt<Logger>().i('User granted provisional permission');
  } else {
    getIt<Logger>().i('User declined or has not accepted permission');
  }
}
