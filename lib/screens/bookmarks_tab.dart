import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/preferences_providers.dart';

class BookmarksTab extends ConsumerWidget {
  const BookmarksTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favs = ref.watch(favoritesControllerProvider);
    if (favs.isEmpty) {
      return const Center(child: Text('No bookmarks yet'));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: favs.map((id) => ListTile(leading: const Icon(Icons.bookmark), title: Text(id))).toList(),
    );
  }
}


