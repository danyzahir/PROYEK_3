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
    apiKey: 'AIzaSyCSfLQjeiLwtp0j7MaIjH4wsTbS8MwPceA',
    appId: '1:180027370820:web:f6f6a7beafe9bbb3b9fb11',
    messagingSenderId: '180027370820',
    projectId: 'nahdatultujjar',
    authDomain: 'nahdatultujjar.firebaseapp.com',
    storageBucket: 'nahdatultujjar.firebasestorage.app',
    measurementId: 'G-4K1HQ23GLR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzrq4MMB9TuCJBTYzYQ3Rq6gKEwxjHQbc',
    appId: '1:180027370820:android:c60dcb47978676f9b9fb11',
    messagingSenderId: '180027370820',
    projectId: 'nahdatultujjar',
    storageBucket: 'nahdatultujjar.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDitEJPEPw-ll5jxD3_tmwWn6hz8qyqXZU',
    appId: '1:180027370820:ios:c67d26df579fd3c4b9fb11',
    messagingSenderId: '180027370820',
    projectId: 'nahdatultujjar',
    storageBucket: 'nahdatultujjar.firebasestorage.app',
    iosBundleId: 'com.example.proyek3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDitEJPEPw-ll5jxD3_tmwWn6hz8qyqXZU',
    appId: '1:180027370820:ios:c67d26df579fd3c4b9fb11',
    messagingSenderId: '180027370820',
    projectId: 'nahdatultujjar',
    storageBucket: 'nahdatultujjar.firebasestorage.app',
    iosBundleId: 'com.example.proyek3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCSfLQjeiLwtp0j7MaIjH4wsTbS8MwPceA',
    appId: '1:180027370820:web:94510b34466cd906b9fb11',
    messagingSenderId: '180027370820',
    projectId: 'nahdatultujjar',
    authDomain: 'nahdatultujjar.firebaseapp.com',
    storageBucket: 'nahdatultujjar.firebasestorage.app',
    measurementId: 'G-RL9KEW2JVC',
  );
}
