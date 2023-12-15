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
    apiKey: 'AIzaSyDQX4eV2baWNAa9X85xXL60G3l3-sPFxyg',
    appId: '1:738285931880:web:b6fb54c0e458627fd15add',
    messagingSenderId: '738285931880',
    projectId: 'km-af-projects',
    authDomain: 'km-af-projects.firebaseapp.com',
    storageBucket: 'km-af-projects.appspot.com',
    measurementId: 'G-0EWDM185T4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAeMjGMNXd7UhH2WGsHcZu9z05f37bmw6I',
    appId: '1:738285931880:android:44bff770c6b26177d15add',
    messagingSenderId: '738285931880',
    projectId: 'km-af-projects',
    storageBucket: 'km-af-projects.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDk48VnOUKZSMZIRT5oSl_SDPixQtytB6U',
    appId: '1:738285931880:ios:453f4c7f70fb4509d15add',
    messagingSenderId: '738285931880',
    projectId: 'km-af-projects',
    storageBucket: 'km-af-projects.appspot.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDk48VnOUKZSMZIRT5oSl_SDPixQtytB6U',
    appId: '1:738285931880:ios:fa9895e17382378ad15add',
    messagingSenderId: '738285931880',
    projectId: 'km-af-projects',
    storageBucket: 'km-af-projects.appspot.com',
    iosBundleId: 'com.example.untitled.RunnerTests',
  );
}