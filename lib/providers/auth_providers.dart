import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authUserIdProvider = FutureProvider<String?>((ref) async {
  final svc = ref.watch(authServiceProvider);
  return svc.getCurrentUserId();
});


