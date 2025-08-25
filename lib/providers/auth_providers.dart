import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/auth_service.dart';
import '../services/firebase_auth_service.dart';
import '../firebase_options.dart';

final firebaseInitializedProvider = FutureProvider<bool>((ref) async {
  try {
    if (!DefaultFirebaseOptions.isConfigured) return false;
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    return true;
  } catch (_) {
    return false;
  }
});

final authServiceProvider = Provider<AuthService>((ref) {
  final initialized = ref.watch(firebaseInitializedProvider).maybeWhen(data: (v) => v, orElse: () => false);
  if (initialized) {
    return FirebaseAuthService();
  } else {
    return MockAuthService();
  }
});

final authUserIdProvider = FutureProvider<String?>((ref) async {
  final svc = ref.watch(authServiceProvider);
  return svc.getCurrentUserId();
});


