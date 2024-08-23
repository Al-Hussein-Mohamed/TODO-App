// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBYosb7JTR9s4i8MDQEhk9NrDJ0xwz3HI4',
    appId: '1:440730913229:web:d781f20381901fd0a91c84',
    messagingSenderId: '440730913229',
    projectId: 'todo-app-glitch-20',
    authDomain: 'todo-app-glitch-20.firebaseapp.com',
    storageBucket: 'todo-app-glitch-20.appspot.com',
    measurementId: 'G-GPCY6B693X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsrERGO6n0WUAiZw0zmFAd2QlBoDm0da0',
    appId: '1:440730913229:android:7ac63a5687aa4d85a91c84',
    messagingSenderId: '440730913229',
    projectId: 'todo-app-glitch-20',
    storageBucket: 'todo-app-glitch-20.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAeWfxzmEjemyx93WN8DHuuYoNm629ZWIo',
    appId: '1:440730913229:ios:cb70bcbdc636ef8aa91c84',
    messagingSenderId: '440730913229',
    projectId: 'todo-app-glitch-20',
    storageBucket: 'todo-app-glitch-20.appspot.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAeWfxzmEjemyx93WN8DHuuYoNm629ZWIo',
    appId: '1:440730913229:ios:cb70bcbdc636ef8aa91c84',
    messagingSenderId: '440730913229',
    projectId: 'todo-app-glitch-20',
    storageBucket: 'todo-app-glitch-20.appspot.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBYosb7JTR9s4i8MDQEhk9NrDJ0xwz3HI4',
    appId: '1:440730913229:web:1043181b928a335aa91c84',
    messagingSenderId: '440730913229',
    projectId: 'todo-app-glitch-20',
    authDomain: 'todo-app-glitch-20.firebaseapp.com',
    storageBucket: 'todo-app-glitch-20.appspot.com',
    measurementId: 'G-8QJBBPK5NK',
  );

}