import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/flashcard_providers.dart';
import '../providers/preferences_providers.dart' as pref;
import '../providers/auth_providers.dart';
import '../models/flashcard.dart';
import '../widgets/flashcard_card.dart';
import '../widgets/grouped_flashcards_card.dart';
import '../widgets/info_post_card.dart';
import '../widgets/section_header.dart';
import '../data/mock_data.dart';
import '../theme/persona_theme.dart';
import 'post_detail_screen.dart';
import 'quick_bites_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _featuredCtrl = PageController(viewportFraction: 0.88);
  final PageController _testimonialsCtrl = PageController(viewportFraction: 0.9);
  final PageController _flashcardsPager = PageController();
  int _flashIndex = 0;

  @override
  void dispose() {
    _featuredCtrl.dispose();
    _testimonialsCtrl.dispose();
    _flashcardsPager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ptheme = Theme.of(context).extension<PersonaTheme>();
    final progressAsync = ref.watch(pref.todayProgressProvider);
    final streakAsync = ref.watch(streakProvider);
    final cardsAsync = ref.watch(flashcardsProvider);

    return NestedScrollView(
      headerSliverBuilder: (_, __) => [
        SliverAppBar(
          pinned: true,
          expandedHeight: 240,
          flexibleSpace: FlexibleSpaceBar(
            background: _HeroSection(gradient: ptheme?.heroGradient),
          ),
        ),
      ],
      body: CustomScrollView(
        slivers: [
          // Start here
          SliverToBoxAdapter(child: SectionHeader(icon: Icons.flag, title: 'Start here', padding: const EdgeInsets.fromLTRB(16, 12, 16, 8))),
          // Social proof / stats bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  _chip(context, '50K+ learners'),
                  const SizedBox(width: 8),
                  _chip(context, '4.8★ avg'),
                  const SizedBox(width: 8),
                  _chip(context, '3-min lessons'),
                ],
              ),
            ),
          ),

          // Quick Bites
          SliverToBoxAdapter(child: SectionHeader(icon: Icons.bubble_chart_outlined, title: 'Quick Bites', onAction: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QuickBitesScreen())))),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 260,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: kQuickBites.length,
                itemBuilder: (context, i) {
                  final qb = kQuickBites[i];
                  return SizedBox(
                    width: 280,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              qb.cover,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Container(
                                  color: Theme.of(context).colorScheme.surfaceVariant,
                                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                final cs = Theme.of(context).colorScheme;
                                return Container(
                                  color: cs.surfaceVariant,
                                  child: Icon(Icons.broken_image_outlined, color: cs.onSurfaceVariant),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(12)),
                                    child: Text(qb.badge, style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(qb.title, style: Theme.of(context).textTheme.bodyLarge)),
                                ]),
                                const SizedBox(height: 6),
                                Text(qb.summary, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Learning Paths
          SliverToBoxAdapter(child: SectionHeader(icon: Icons.route_outlined, title: 'Learning Paths', onAction: () {})),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 180,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: kLearningPaths.length,
                itemBuilder: (context, i) {
                  final lp = kLearningPaths[i];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _PathCard(title: '${lp.title} • ${lp.eta}', progress: lp.progress),
                  );
                },
              ),
            ),
          ),

          // Continue learning
          SliverToBoxAdapter(child: SectionHeader(icon: Icons.history, title: 'Continue learning', onAction: () {})),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: _ContinueCard(progressAsync: progressAsync, streakAsync: streakAsync),
            ),
          ),

          // QOTD
          SliverToBoxAdapter(child: SectionHeader(icon: Icons.help_outline, title: 'Question of the Day', onAction: () {})),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _DailyChallengeCard(),
            ),
          ),

          // Featured bites
          SliverToBoxAdapter(child: SectionHeader(icon: Icons.explore_outlined, title: 'Featured bites', onAction: () {})),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: PageView.builder(
                controller: _featuredCtrl,
                itemCount: kInfoPosts.length,
                itemBuilder: (context, i) {
                  final post = kInfoPosts[i];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PostDetailScreen(
                            id: post.id,
                            title: post.title,
                            imageUrl: post.imageUrl,
                            body: post.summary,
                          ),
                        ),
                      ),
                      child: InfoPostCard(
                        post: post,
                        onTap: () {},
                        onBookmark: () {},
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Why EduShorts
          SliverToBoxAdapter(child: SectionHeader(icon: Icons.lightbulb_outline, title: 'Why EduShorts', onAction: () {})),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(child: _valueProp(context, Icons.lunch_dining, '3-min curated lessons', 'Dense, memorable, and to the point.')),
                  const SizedBox(width: 8),
                  Expanded(child: _valueProp(context, Icons.play_circle, 'Text, visuals, videos', 'Pick what fits your style.')),
                  const SizedBox(width: 8),
                  Expanded(child: _valueProp(context, Icons.bolt, 'Based on your interests', 'Personalized picks that get better daily.')),
                ],
              ),
            ),
          ),

          // Testimonials
          SliverToBoxAdapter(child: SectionHeader(icon: Icons.record_voice_over_outlined, title: 'What learners say', onAction: () {})),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 140,
              child: PageView.builder(
                controller: _testimonialsCtrl,
                itemCount: kTestimonials.length,
                itemBuilder: (context, i) {
                  final t = kTestimonials[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Card(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('“${t['quote']}”', style: Theme.of(context).textTheme.bodyLarge),
                            const SizedBox(height: 8),
                            Text(t['author']!, style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Flashcards carousel
          SliverToBoxAdapter(child: SectionHeader(icon: Icons.view_carousel_outlined, title: 'Flashcards', onAction: () {})),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: kBottomNavigationBarHeight + 32),
              child: cardsAsync.when(
                data: (cards) {
                  if (cards.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: Text('No cards available. Pick interests in Settings.')),
                    );
                  }
                  final Map<String, List<Flashcard>> groups = {};
                  for (final c in cards) {
                    if (c.groupId != null) {
                      groups.putIfAbsent(c.groupId!, () => <Flashcard>[]).add(c);
                    } else {
                      groups.putIfAbsent(c.id, () => <Flashcard>[]).add(c);
                    }
                  }
                  final ordered = groups.values.toList()
                    ..sort((a, b) => (a.first.groupId ?? a.first.id).compareTo(b.first.groupId ?? b.first.id));
                  return Column(
                    children: [
                      SizedBox(
                        height: 360,
                        child: PageView.builder(
                          controller: _flashcardsPager,
                          onPageChanged: (i) => setState(() => _flashIndex = i),
                          itemCount: ordered.length,
                          itemBuilder: (_, i) {
                            final list = ordered[i];
                            final first = list.first;
                            if ((first.groupId?.isNotEmpty ?? false)) {
                              return Padding(
                                padding: const EdgeInsets.all(12),
                                child: GroupedFlashcardsCard(heading: first.groupId!, sections: list),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: FlashcardCard(flashcard: first),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: _flashIndex > 0
                                ? () => _flashcardsPager.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut)
                                : null,
                            child: const Text('Previous'),
                          ),
                          const SizedBox(width: 12),
                          FilledButton(
                            onPressed: _flashIndex < ordered.length - 1
                                ? () => _flashcardsPager.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut)
                                : null,
                            child: const Text('Next'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, st) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(child: Text('Error: $e')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelMedium),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final Gradient? gradient;
  const _HeroSection({this.gradient});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(gradient: gradient ?? const LinearGradient(colors: [Colors.indigo, Colors.cyan])),
      child: Container(
        color: Colors.black.withOpacity(isDark ? 0.35 : 0.20),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bite-sized learning, anytime, anywhere.',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    const Text('Learn fast with curated 3‑minute shorts.', style: TextStyle(color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
                Row(children: [
                  FilledButton(
                    onPressed: () {
                      // start/resume from first learning path topic
                      final title = kLearningPaths.first.title;
                      Navigator.of(context).pushNamed('/topic', arguments: title);
                    },
                    child: const Text('Start 3‑min Session'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pushNamed('/topics'),
                    child: const Text('Browse Topics'),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StoryCircle extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _StoryCircle({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ]),
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: const Icon(Icons.play_arrow_rounded),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(width: 72, child: Text(label, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center)),
      ],
    );
  }
}

class _PathCard extends StatelessWidget {
  final String title;
  final double progress;
  const _PathCard({required this.title, required this.progress});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyLarge),
              const Spacer(),
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () {
                    final cleanTitle = title.split(' • ').first;
                    Navigator.of(context).pushNamed('/topic', arguments: cleanTitle);
                  },
                  child: const Text('Resume'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DailyChallengeCard extends StatefulWidget {
  @override
  State<_DailyChallengeCard> createState() => _DailyChallengeCardState();
}

class _DailyChallengeCardState extends State<_DailyChallengeCard> {
  int? _selected;
  bool _revealed = false;
  @override
  Widget build(BuildContext context) {
    final q = kQotd;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(q.question, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: !_revealed
                ? Wrap(
                    key: const ValueKey('choices'),
                    spacing: 8,
                    children: List.generate(q.choices.length, (i) => ChoiceChip(
                          label: Text(q.choices[i]),
                          selected: _selected == i,
                          onSelected: (_) => setState(() => _selected = i),
                        )),
                  )
                : Container(
                    key: const ValueKey('result'),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (_selected == q.answerIndex ? Colors.green : Colors.red).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_selected == q.answerIndex ? 'Correct! 🎉' : 'Correct answer: ${q.choices[q.answerIndex]}'),
                  ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: () => setState(() => _revealed = true), child: const Text('Reveal')),
          )
        ]),
      ),
    );
  }
}

class _ContinueCard extends StatelessWidget {
  final AsyncValue<int> progressAsync;
  final AsyncValue<int> streakAsync;
  const _ContinueCard({required this.progressAsync, required this.streakAsync});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(width: 72, height: 72, decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(12))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Continue learning'),
                const SizedBox(height: 6),
                progressAsync.maybeWhen(data: (c) => Text('Today: $c cards'), orElse: () => const SizedBox()),
                streakAsync.maybeWhen(data: (s) => Text('🔥 Streak: $s'), orElse: () => const SizedBox()),
              ]),
            ),
            FilledButton(onPressed: () {}, child: const Text('Resume'))
          ],
        ),
      ),
    );
  }
}

Widget _valueProp(BuildContext context, IconData icon, String title, String subtitle) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(subtitle),
        ],
      ),
    ),
  );
}
