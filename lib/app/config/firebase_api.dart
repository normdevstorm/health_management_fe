import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../firebase_options.dart';

class FirebaseApi{

  Future<void> initNotificaiton() async {

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  final _firebaseMessaging = FirebaseMessaging.instance;

    final fcmToken = await _firebaseMessaging.getToken();
    print("Token: $fcmToken");
    FirebaseMessaging.onBackgroundMessage(handlerBackgorundMessage);
  }

  Future<void> handlerBackgorundMessage(RemoteMessage message) async {
      await Firebase.initializeApp();
    print('onBackgroundMessage: $message');
  }
}