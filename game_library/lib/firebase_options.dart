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
    apiKey: 'AIzaSyAor9yXGPMuZFAqRw7FzSO8o0NuPxcGxeE',
    appId: '1:185291867690:web:4083c03d6cf0d89129e553',
    messagingSenderId: '185291867690',
    projectId: 'game-library-4dbf7',
    authDomain: 'game-library-4dbf7.firebaseapp.com',
    storageBucket: 'game-library-4dbf7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_VnVeS3epDhXJY5FV3WJeoE3v_iTDUII',
    appId: '1:185291867690:android:8fd37f247d20692d29e553',
    messagingSenderId: '185291867690',
    projectId: 'game-library-4dbf7',
    storageBucket: 'game-library-4dbf7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNCr9xapTSGSpXnsoDkL4EACTNTw7JqIc',
    appId: '1:185291867690:ios:36b33dbefc59c15429e553',
    messagingSenderId: '185291867690',
    projectId: 'game-library-4dbf7',
    storageBucket: 'game-library-4dbf7.appspot.com',
    iosClientId: '185291867690-iknl4au6guo1ach0stl9vr6ma308saj6.apps.googleusercontent.com',
    iosBundleId: 'com.example.gameLibrary',
  );
}
