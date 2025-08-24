import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardCard extends StatelessWidget {
  final Flashcard flashcard;
  final VoidCallback? onFavorite;
  const FlashcardCard({super.key, required this.flashcard, this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    flashcard.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_add_outlined),
                  onPressed: onFavorite,
                )
              ],
            ),
            const SizedBox(height: 8),
            Chip(label: Text(flashcard.category)),
            const SizedBox(height: 16),
            Text(
              flashcard.content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}


