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
    apiKey: 'AIzaSyDW0TLIBNMmdzM7a7ewy0VuyPR-Ju-89UU',
    appId: '1:996965072047:web:0686c4aaf87f2df356685a',
    messagingSenderId: '996965072047',
    projectId: 'todo-app-82b3a',
    authDomain: 'todo-app-82b3a.firebaseapp.com',
    storageBucket: 'todo-app-82b3a.firebasestorage.app',
    measurementId: 'G-FZ7V6FPQJL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAReqqZTSPP9zPSg7Rkrie5kE57hTOpke0',
    appId: '1:996965072047:android:1bd5be7fc01db51756685a',
    messagingSenderId: '996965072047',
    projectId: 'todo-app-82b3a',
    storageBucket: 'todo-app-82b3a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMctID5sRtsu9Ym26URktGeh0kjpbSfMs',
    appId: '1:996965072047:ios:6848671c52af5c3d56685a',
    messagingSenderId: '996965072047',
    projectId: 'todo-app-82b3a',
    storageBucket: 'todo-app-82b3a.firebasestorage.app',
    iosBundleId: 'com.example.todoist',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAMctID5sRtsu9Ym26URktGeh0kjpbSfMs',
    appId: '1:996965072047:ios:6848671c52af5c3d56685a',
    messagingSenderId: '996965072047',
    projectId: 'todo-app-82b3a',
    storageBucket: 'todo-app-82b3a.firebasestorage.app',
    iosBundleId: 'com.example.todoist',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDW0TLIBNMmdzM7a7ewy0VuyPR-Ju-89UU',
    appId: '1:996965072047:web:1ced6615a0f5af8256685a',
    messagingSenderId: '996965072047',
    projectId: 'todo-app-82b3a',
    authDomain: 'todo-app-82b3a.firebaseapp.com',
    storageBucket: 'todo-app-82b3a.firebasestorage.app',
    measurementId: 'G-26QZ2NSJK6',
  );
}
