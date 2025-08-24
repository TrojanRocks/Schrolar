import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/preferences_service.dart';
import 'auth_providers.dart';

final preferencesServiceProvider = Provider<PreferencesService>((ref) => PreferencesService());

final favoritesProvider = FutureProvider<List<String>>((ref) async {
  final userId = await ref.watch(authUserIdProvider.future);
  if (userId == null) return [];
  final svc = ref.watch(preferencesServiceProvider);
  return svc.getFavorites(userId);
});

final todayProgressProvider = FutureProvider<int>((ref) async {
  final userId = await ref.watch(authUserIdProvider.future);
  if (userId == null) return 0;
  final svc = ref.watch(preferencesServiceProvider);
  return svc.getTodayProgress(userId);
});


