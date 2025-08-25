// Placeholder Firebase options. Replace by running:
// flutter pub global activate flutterfire_cli
// flutterfire configure
// This will generate a real firebase_options.dart for your project.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  // Simple flag to detect placeholder vs real config
  static const bool isConfigured = false; // Set true automatically by FlutterFire generated file

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: 'CHANGE_ME',
          appId: 'CHANGE_ME',
          messagingSenderId: 'CHANGE_ME',
          projectId: 'CHANGE_ME',
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const FirebaseOptions(
          apiKey: 'CHANGE_ME',
          appId: 'CHANGE_ME',
          messagingSenderId: 'CHANGE_ME',
          projectId: 'CHANGE_ME',
          iosBundleId: 'CHANGE_ME',
        );
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return const FirebaseOptions(
          apiKey: 'CHANGE_ME',
          appId: 'CHANGE_ME',
          messagingSenderId: 'CHANGE_ME',
          projectId: 'CHANGE_ME',
        );
    }
  }
}


