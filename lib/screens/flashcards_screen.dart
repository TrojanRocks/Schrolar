import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/flashcard_providers.dart';
import '../providers/preferences_providers.dart' as pref;
import '../widgets/flashcard_card.dart';
import '../models/flashcard.dart';

class FlashcardsScreen extends ConsumerWidget {
  const FlashcardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(flashcardsProvider);
    final favorites = ref.watch(pref.favoritesControllerProvider);
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, inner) => [
          SliverAppBar(
            pinned: true,
            title: const Text('Flashcards'),
            bottom: const TabBar(tabs: [Tab(text: 'All'), Tab(text: 'Bookmarked')]),
          ),
        ],
        body: TabBarView(
          children: [
            _list(cardsAsync, favorites, false),
            _list(cardsAsync, favorites, true),
          ],
        ),
      ),
    );
  }

  Widget _list(AsyncValue<List<Flashcard>> cardsAsync, Set<String> favorites, bool onlyBookmarked) {
    return cardsAsync.when(
      data: (cards) {
        final data = onlyBookmarked
            ? cards.where((c) => favorites.contains(c.id) || favorites.contains(c.groupId ?? '')).toList()
            : cards;
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: data.length,
          itemBuilder: (_, i) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FlashcardCard(flashcard: data[i]),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}
