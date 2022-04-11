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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAr3gsN1u79WA2-RNNWukQSJPo7wxrRA-E',
    appId: '1:439864024538:web:4525acaed2366af00e74e3',
    messagingSenderId: '439864024538',
    projectId: 'chatapp-4b3fc',
    authDomain: 'chatapp-4b3fc.firebaseapp.com',
    storageBucket: 'chatapp-4b3fc.appspot.com',
    measurementId: 'G-X4MZE1E0DE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOaG98fOQGPcxGD-W1mBuB6rNNGur8oMc',
    appId: '1:439864024538:android:5821e24e42ae2fad0e74e3',
    messagingSenderId: '439864024538',
    projectId: 'chatapp-4b3fc',
    storageBucket: 'chatapp-4b3fc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDoB1ZxCGo5OMah8jmkhNs1xiMUIpablk',
    appId: '1:439864024538:ios:8fc152e63e6d0a4f0e74e3',
    messagingSenderId: '439864024538',
    projectId: 'chatapp-4b3fc',
    storageBucket: 'chatapp-4b3fc.appspot.com',
    iosClientId: '439864024538-4hfd03b0hdf5ii83chaspu571u3q8kbm.apps.googleusercontent.com',
    iosBundleId: 'com.chat.app',
  );
}