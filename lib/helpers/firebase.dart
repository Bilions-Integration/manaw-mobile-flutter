import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_app/helpers/console_log.dart';

updateFirebaseToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  String? token = await messaging.getToken();
  console.log('FCM_TOKEN $token');
}
