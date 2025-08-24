import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/flashcard_providers.dart';
import '../providers/preferences_providers.dart' as pref;
import '../providers/auth_providers.dart';
import '../widgets/flashcard_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final cardsAsync = ref.watch(flashcardsProvider);
    final progressAsync = ref.watch(pref.todayProgressProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schrolar'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/profile'),
            icon: const Icon(Icons.person_outline),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: progressAsync.maybeWhen(
                data: (count) => Text("Today's progress: $count"),
                orElse: () => const SizedBox.shrink(),
              ),
            ),
            Expanded(
              child: cardsAsync.when(
                data: (cards) {
                  if (cards.isEmpty) {
                    return const Center(child: Text('No cards available. Pick interests in Settings.'));
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (i) => setState(() => _index = i),
                          itemCount: cards.length,
                          itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.all(12),
                            child: FlashcardCard(
                              flashcard: cards[i],
                              onFavorite: () async {
                                final userId = await ref.read(authUserIdProvider.future);
                                if (userId != null) {
                                  await ref.read(pref.preferencesServiceProvider).addFavorite(userId, cards[i].id);
                                  if (mounted) setState(() {});
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: _index > 0
                                ? () => _pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut)
                                : null,
                            child: const Text('Previous'),
                          ),
                          const SizedBox(width: 12),
                          FilledButton(
                            onPressed: _index < cards.length - 1
                                ? () async {
                                    final userId = await ref.read(authUserIdProvider.future);
                                    if (userId != null) {
                                      await ref.read(pref.preferencesServiceProvider).incrementTodayProgress(userId);
                                    }
                                    if (mounted) {
                                      _pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
                                    }
                                  }
                                : null,
                            child: const Text('Next'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


