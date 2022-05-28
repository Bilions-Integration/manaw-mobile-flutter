// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGFF0b6BIjSpit8Zx-wLbUKCLNRkAkOXQ',
    appId: '1:571631180991:android:9c88ce9eb0f893579d7a0a',
    messagingSenderId: '571631180991',
    projectId: 'bilions-pos',
    databaseURL: 'https://bilions-pos-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bilions-pos.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFIkPE_0SCMq8FH6Kne0wAxtDvbQP2FSs',
    appId: '1:571631180991:ios:61f047c2fc5af78d9d7a0a',
    messagingSenderId: '571631180991',
    projectId: 'bilions-pos',
    databaseURL: 'https://bilions-pos-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bilions-pos.appspot.com',
    androidClientId: '571631180991-n515f142slu0453l1pjovpqarrlplaqg.apps.googleusercontent.com',
    iosClientId: '571631180991-n09tnlva4d2o8apsprdq3de8r50io3jr.apps.googleusercontent.com',
    iosBundleId: 'org.bilions.manawstore',
  );
}
