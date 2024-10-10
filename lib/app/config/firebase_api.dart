import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/web.dart';
import '../../firebase_options.dart';

@injectable
class FirebaseApi {
  Future<void> initNotificaiton() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final firebaseMessaging = FirebaseMessaging.instance;
    final fcmToken = await firebaseMessaging.getToken();
    final firebaseInstallationId = await FirebaseInstallations.instance.getId();
    getIt<Logger>().i("FCMToken: $fcmToken");
    getIt<Logger>().i("InstallationId: $firebaseInstallationId");
    FirebaseMessaging.onBackgroundMessage(handlerBackgorundMessage);
    FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
    FirebaseMessaging.onMessage.listen((message) {
      getIt<Logger>().i("onMessage: $message");
    });
  }

  Future<void> handlerBackgorundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    //TODO: TO HANDLE THE MESSAGE DATA 401 LATER ON
    getIt<Logger>().i("onBackgroundMessage: $message");
  }
}
