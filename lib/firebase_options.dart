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
    apiKey: 'AIzaSyDaTbiL87S8SMNUITCNJKpS0FM0-2x8ah4',
    appId: '1:110472587271:web:129411dda2903d8b5b62a2',
    messagingSenderId: '110472587271',
    projectId: 'flutter-chat-691a5',
    authDomain: 'flutter-chat-691a5.firebaseapp.com',
    storageBucket: 'flutter-chat-691a5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7yfCaQJPiVV9hVst-NPyhxHXbUrRvEFU',
    appId: '1:110472587271:android:0be56369c458a54b5b62a2',
    messagingSenderId: '110472587271',
    projectId: 'flutter-chat-691a5',
    storageBucket: 'flutter-chat-691a5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVurnxQYz4Ug07W7HPWj6Wc3U_NQQ0ktY',
    appId: '1:110472587271:ios:87f5d05c55289b085b62a2',
    messagingSenderId: '110472587271',
    projectId: 'flutter-chat-691a5',
    storageBucket: 'flutter-chat-691a5.appspot.com',
    iosClientId: '110472587271-920qm0q8u1su0o36ucn1tkh04bkarcpr.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCVurnxQYz4Ug07W7HPWj6Wc3U_NQQ0ktY',
    appId: '1:110472587271:ios:3c48e7f995d40f045b62a2',
    messagingSenderId: '110472587271',
    projectId: 'flutter-chat-691a5',
    storageBucket: 'flutter-chat-691a5.appspot.com',
    iosClientId: '110472587271-3e168anhdu9kgneuivkqkt217d587pct.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
