import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String body;
  const PostDetailScreen({super.key, required this.id, required this.title, required this.imageUrl, required this.body});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        children: [
          Hero(
            tag: 'post-$id',
            child: AspectRatio(
              aspectRatio: 16/9,
              child: Image.network(
                imageUrl,
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
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(List.filled(3, body).join('\n\n')),
          )
        ],
      ),
    );
  }
}


