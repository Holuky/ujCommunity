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
    apiKey: 'AIzaSyAd2BMc0thiSLPSFmuw6AxzIAVUd-qhEmM',
    appId: '1:121130728692:web:3cf224b71b078afc58f2a1',
    messagingSenderId: '121130728692',
    projectId: 'unjeong-6b434',
    authDomain: 'unjeong-6b434.firebaseapp.com',
    storageBucket: 'unjeong-6b434.appspot.com',
    measurementId: 'G-B68MK4MM82',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMhn7a4TyoRI2sVS3t9EKMeN2sP60Wdas',
    appId: '1:121130728692:android:cb69b79bbd0388f058f2a1',
    messagingSenderId: '121130728692',
    projectId: 'unjeong-6b434',
    storageBucket: 'unjeong-6b434.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOvYS6jCKTaO4yR6FEBkU2yOjq_VjtA68',
    appId: '1:121130728692:ios:98f25cd6338c79b258f2a1',
    messagingSenderId: '121130728692',
    projectId: 'unjeong-6b434',
    storageBucket: 'unjeong-6b434.appspot.com',
    iosBundleId: 'com.unjeong.ujCommunity',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOvYS6jCKTaO4yR6FEBkU2yOjq_VjtA68',
    appId: '1:121130728692:ios:773a85d1937e70b658f2a1',
    messagingSenderId: '121130728692',
    projectId: 'unjeong-6b434',
    storageBucket: 'unjeong-6b434.appspot.com',
    iosBundleId: 'com.unjeong.ujCommunity.RunnerTests',
  );
}
