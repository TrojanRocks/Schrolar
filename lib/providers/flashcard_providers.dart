import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/flashcard_service.dart';
import '../services/preferences_service.dart';
import '../models/flashcard.dart';
import 'auth_providers.dart';

final flashcardServiceProvider = Provider<FlashcardService>((ref) => FlashcardService());
final preferencesServiceProvider = Provider<PreferencesService>((ref) => PreferencesService());

final interestsProvider = FutureProvider<List<String>>((ref) async {
  final userId = await ref.watch(authUserIdProvider.future);
  if (userId == null) return [];
  final prefs = ref.watch(preferencesServiceProvider);
  return prefs.getInterests(userId);
});

final flashcardsProvider = FutureProvider<List<Flashcard>>((ref) async {
  final service = ref.watch(flashcardServiceProvider);
  final interests = await ref.watch(interestsProvider.future);
  return service.loadByInterests(interests);
});

final streakProvider = FutureProvider<int>((ref) async {
  final userId = await ref.watch(authUserIdProvider.future);
  if (userId == null) return 0;
  final prefs = ref.watch(preferencesServiceProvider);
  return prefs.getCurrentStreak(userId);
});


