import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/preferences_providers.dart' as pref;
import '../providers/flashcard_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(pref.favoritesProvider);
    final streak = ref.watch(streakProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 32, child: Icon(Icons.person)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('User', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  streak.maybeWhen(data: (s) => Text('🔥 Streak $s'), orElse: () => const SizedBox.shrink()),
                ],
              ),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit), label: const Text('Edit'))
            ],
          ),
          const SizedBox(height: 16),
          favorites.when(
            data: (ids) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bookmarks (${ids.length})', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                for (final id in ids) ListTile(leading: const Icon(Icons.bookmark), title: Text(id)),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
        ],
      ),
    );
  }
}


