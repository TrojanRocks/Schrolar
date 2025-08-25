import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/preferences_service.dart';
import 'auth_providers.dart';
import '../services/theme_service.dart';
import 'package:riverpod/riverpod.dart';

final preferencesServiceProvider = Provider<PreferencesService>((ref) => PreferencesService());

final favoritesProvider = FutureProvider<List<String>>((ref) async {
  final userId = await ref.watch(authUserIdProvider.future);
  if (userId == null) return [];
  final svc = ref.watch(preferencesServiceProvider);
  return svc.getFavorites(userId);
});

class FavoritesController extends StateNotifier<Set<String>> {
  final PreferencesService svc;
  final Ref ref;
  FavoritesController(this.ref, this.svc) : super({}) {
    _init();
  }
  Future<void> _init() async {
    final userId = await ref.read(authUserIdProvider.future);
    if (userId == null) return;
    final list = await svc.getFavorites(userId);
    state = list.toSet();
  }
  Future<void> toggle(String id) async {
    final userId = await ref.read(authUserIdProvider.future);
    if (userId == null) return;
    final next = {...state};
    if (next.contains(id)) {
      next.remove(id);
      await svc.removeFavorite(userId, id);
    } else {
      next.add(id);
      await svc.addFavorite(userId, id);
    }
    state = next;
  }
}

final favoritesControllerProvider =
    StateNotifierProvider<FavoritesController, Set<String>>((ref) {
  return FavoritesController(ref, ref.watch(preferencesServiceProvider));
});

final todayProgressProvider = FutureProvider<int>((ref) async {
  final userId = await ref.watch(authUserIdProvider.future);
  if (userId == null) return 0;
  final svc = ref.watch(preferencesServiceProvider);
  return svc.getTodayProgress(userId);
});

final themeServiceProvider = Provider<ThemeService>((ref) => ThemeService());

class ThemeController extends StateNotifier<ThemeVariant> {
  final ThemeService service;
  ThemeController(this.service) : super(ThemeVariant.student) {
    _init();
  }

  Future<void> _init() async {
    final saved = await service.getTheme();
    state = saved;
  }

  Future<void> setTheme(ThemeVariant variant) async {
    state = variant;
    await service.setTheme(variant);
  }
}

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeVariant>((ref) {
  return ThemeController(ref.watch(themeServiceProvider));
});


