import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD_1qaoo3DTiX2xXOLgUvK0hEw9k1wz1Sc',
    appId: '1:101813099744:web:831ef1198c614f53620485',
    messagingSenderId: '101813099744',
    projectId: 'neurochat-ce359',
    authDomain: 'neurochat-ce359.firebaseapp.com',
    storageBucket: 'neurochat-ce359.firebasestorage.app',
    measurementId: 'G-45SWB6GR1L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2zkgPjeW9WNmssxjzSwFpmec9EOkmZwY',
    appId: '1:101813099744:android:1858a3d578150899620485',
    messagingSenderId: '101813099744',
    projectId: 'neurochat-ce359',
    storageBucket: 'neurochat-ce359.firebasestorage.app',
  );
}
