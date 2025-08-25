import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class QuickBitesScreen extends StatelessWidget {
  const QuickBitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Quick Bites')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: kQuickBites.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final qb = kQuickBites[i];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AspectRatio(
                  aspectRatio: 16/9,
                  child: Image.network(
                    qb.cover,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: cs.surfaceVariant,
                        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: cs.surfaceVariant,
                        child: Icon(Icons.broken_image_outlined, color: cs.onSurfaceVariant),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: cs.primaryContainer, borderRadius: BorderRadius.circular(12)),
                    child: Text(qb.badge, style: TextStyle(color: cs.onPrimaryContainer)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(qb.title, style: Theme.of(context).textTheme.bodyLarge)),
                ]),
                const SizedBox(height: 6),
                Text(qb.summary, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                for (final b in qb.bullets) Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(children: [const Text('• '), Expanded(child: Text(b))]),
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
