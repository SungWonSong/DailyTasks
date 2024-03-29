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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB-CvEtey5E7CzMfTMrG3B_CLLF-HA7yLQ',
    appId: '1:389466164401:web:dc2aec2f4da783a6d22690',
    messagingSenderId: '389466164401',
    projectId: 'dailytaskproject',
    authDomain: 'dailytaskproject.firebaseapp.com',
    storageBucket: 'dailytaskproject.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7LaxAt4IwgP6QREm1K-Th_e2LW1g2MxA',
    appId: '1:389466164401:android:50061b17840fe2aed22690',
    messagingSenderId: '389466164401',
    projectId: 'dailytaskproject',
    storageBucket: 'dailytaskproject.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrI-gPOn-XmUyAWr_QyJcZcJevirLEMoQ',
    appId: '1:389466164401:ios:d28e049fd5ee3736d22690',
    messagingSenderId: '389466164401',
    projectId: 'dailytaskproject',
    storageBucket: 'dailytaskproject.appspot.com',
    iosBundleId: 'com.example.dailytask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrI-gPOn-XmUyAWr_QyJcZcJevirLEMoQ',
    appId: '1:389466164401:ios:586323ffc92c6ba2d22690',
    messagingSenderId: '389466164401',
    projectId: 'dailytaskproject',
    storageBucket: 'dailytaskproject.appspot.com',
    iosBundleId: 'com.example.dailytask.RunnerTests',
  );
}
