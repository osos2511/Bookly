// File generated from the Android configuration in
// `android/app/google-services.json`.
//
// Only Android is configured for this Firebase project. To add iOS, web or
// desktop, install the FlutterFire CLI and run `flutterfire configure`, which
// will regenerate this file for every platform.
//
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'run the FlutterFire CLI again to reconfigure this file.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for '
          '$defaultTargetPlatform - run `flutterfire configure` to add it.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDti5MV_B138kWpj2DbRPbutUy9AZaRxhM',
    appId: '1:119450981481:android:03f82d052e29fe066fbef8',
    messagingSenderId: '119450981481',
    projectId: 'bookly-app-e31d5',
    storageBucket: 'bookly-app-e31d5.firebasestorage.app',
  );
}
