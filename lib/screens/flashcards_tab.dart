import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/flashcard_providers.dart';
import '../providers/preferences_providers.dart' as pref;
import '../widgets/flashcard_card.dart';
import '../models/flashcard.dart';

class FlashcardsTab extends ConsumerStatefulWidget {
  const FlashcardsTab({super.key});

  @override
  ConsumerState<FlashcardsTab> createState() => _FlashcardsTabState();
}

class _FlashcardsTabState extends ConsumerState<FlashcardsTab> {
  @override
  Widget build(BuildContext context) {
    final cardsAsync = ref.watch(flashcardsProvider);
    final favorites = ref.watch(pref.favoritesControllerProvider);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(tabs: [Tab(text: 'All'), Tab(text: 'Bookmarked')]),
          Expanded(
            child: TabBarView(
              children: [
                _listView(cardsAsync, favorites, false),
                _listView(cardsAsync, favorites, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listView(AsyncValue<List<Flashcard>> cardsAsync, Set<String> favorites, bool onlyBookmarked) {
    return cardsAsync.when(
      data: (cards) {
        final List<Flashcard> filtered = onlyBookmarked
            ? cards.where((c) => favorites.contains(c.id) || favorites.contains(c.groupId ?? '')).toList()
            : cards;
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: filtered.length,
          itemBuilder: (_, i) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FlashcardCard(flashcard: filtered[i]),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}


