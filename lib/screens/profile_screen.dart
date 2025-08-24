import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/preferences_providers.dart' as pref;

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(pref.favoritesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: favorites.when(
        data: (ids) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Favorites (${ids.length})', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            for (final id in ids) ListTile(title: Text(id)),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}


