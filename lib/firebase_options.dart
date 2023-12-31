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
    apiKey: 'AIzaSyBRBfNOeAxKCbnc_hQcY9PuZMTnkotJB9Q',
    appId: '1:610600334753:web:cf32aa46f32114dd1d87e0',
    messagingSenderId: '610600334753',
    projectId: 'recycle-47da1',
    authDomain: 'recycle-47da1.firebaseapp.com',
    storageBucket: 'recycle-47da1.appspot.com',
    measurementId: 'G-JDKME8NHSH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClQjZVScWUFhVGrS22i1rHVAmMxu_FIV0',
    appId: '1:610600334753:android:efbf798ee5a5cf9d1d87e0',
    messagingSenderId: '610600334753',
    projectId: 'recycle-47da1',
    storageBucket: 'recycle-47da1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIspQCumzJ2AlBycvsJ-pp0mx8Z5_WklQ',
    appId: '1:610600334753:ios:d21ddbf6b239b34d1d87e0',
    messagingSenderId: '610600334753',
    projectId: 'recycle-47da1',
    storageBucket: 'recycle-47da1.appspot.com',
    iosBundleId: 'com.example.recycle',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIspQCumzJ2AlBycvsJ-pp0mx8Z5_WklQ',
    appId: '1:610600334753:ios:438794091050c5411d87e0',
    messagingSenderId: '610600334753',
    projectId: 'recycle-47da1',
    storageBucket: 'recycle-47da1.appspot.com',
    iosBundleId: 'com.example.recycle.RunnerTests',
  );
}
