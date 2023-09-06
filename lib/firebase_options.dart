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
    apiKey: 'AIzaSyAhyAjaemgTAvdXUWAu10UvYGy3QCgu3VQ',
    appId: '1:1072215642725:web:52f8b300ca2686a58fec8c',
    messagingSenderId: '1072215642725',
    projectId: 'account-app-396414',
    authDomain: 'account-app-396414.firebaseapp.com',
    storageBucket: 'account-app-396414.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEhzTPbiuFZkRz3z1waJY0SNbIm0226T4',
    appId: '1:1072215642725:android:46f17e2c146116598fec8c',
    messagingSenderId: '1072215642725',
    projectId: 'account-app-396414',
    storageBucket: 'account-app-396414.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAY4olJqVuuuOoKLNk-CEf70um8o5XVQ5c',
    appId: '1:1072215642725:ios:bb833020b1d7d9888fec8c',
    messagingSenderId: '1072215642725',
    projectId: 'account-app-396414',
    storageBucket: 'account-app-396414.appspot.com',
    androidClientId: '1072215642725-ripfnpan3aj5dtn675sl13nt4a2t1bi6.apps.googleusercontent.com',
    iosClientId: '1072215642725-cu1e7o6oi8mlag05dphsq12knn813dk0.apps.googleusercontent.com',
    iosBundleId: 'com.example.accountApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAY4olJqVuuuOoKLNk-CEf70um8o5XVQ5c',
    appId: '1:1072215642725:ios:9d7e83676197f9f18fec8c',
    messagingSenderId: '1072215642725',
    projectId: 'account-app-396414',
    storageBucket: 'account-app-396414.appspot.com',
    androidClientId: '1072215642725-ripfnpan3aj5dtn675sl13nt4a2t1bi6.apps.googleusercontent.com',
    iosClientId: '1072215642725-hm4tjmg719fcd0tcuhngu9jvimup4pni.apps.googleusercontent.com',
    iosBundleId: 'com.example.accountApp.RunnerTests',
  );
}
