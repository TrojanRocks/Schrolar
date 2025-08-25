import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class GroupedFlashcardsCard extends StatefulWidget {
  final String heading;
  final List<Flashcard> sections;
  final VoidCallback? onFavorite;

  const GroupedFlashcardsCard({
    super.key,
    required this.heading,
    required this.sections,
    this.onFavorite,
  });

  @override
  State<GroupedFlashcardsCard> createState() => _GroupedFlashcardsCardState();
}

class _GroupedFlashcardsCardState extends State<GroupedFlashcardsCard> {
  final ScrollController _listController = ScrollController();

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sorted = [...widget.sections]
      ..sort((a, b) => (a.orderInGroup ?? 0).compareTo(b.orderInGroup ?? 0));
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
                    widget.heading,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_add_outlined),
                  onPressed: widget.onFavorite,
                )
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Scrollbar(
                controller: _listController,
                thumbVisibility: true,
                child: ListView.separated(
                  controller: _listController,
                  primary: false,
                  itemCount: sorted.length,
                  separatorBuilder: (_, __) => const Divider(height: 24),
                  itemBuilder: (context, index) {
                    final sec = sorted[index];
                    return InkWell(
                      onTap: () => _openSectionDetail(context, sorted, index),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sec.title, style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 8),
                            ..._splitContent(sec.content).map((part) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(part, style: Theme.of(context).textTheme.bodyLarge),
                                )),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: () => _openSectionDetail(context, sorted, index),
                                icon: const Icon(Icons.open_in_new),
                                label: const Text('Expand'),
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
          ],
        ),
      ),
    );
  }

  List<String> _splitContent(String content) {
    // Break long content into visually digestible paragraphs
    const int target = 140;
    final words = content.split(' ');
    final List<String> parts = [];
    final StringBuffer buf = StringBuffer();
    for (final w in words) {
      if ((buf.length + w.length + 1) > target) {
        parts.add(buf.toString());
        buf.clear();
      }
      if (buf.isNotEmpty) buf.write(' ');
      buf.write(w);
    }
    if (buf.isNotEmpty) parts.add(buf.toString());
    return parts.isEmpty ? [content] : parts;
  }

  void _openSectionDetail(BuildContext context, List<Flashcard> all, int startIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) {
        int current = startIndex;
        final ScrollController modalController = ScrollController();
        return StatefulBuilder(builder: (ctx, setState) {
          final sec = all[current];
          return SafeArea(
            child: SizedBox(
              height: MediaQuery.of(ctx).size.height * 0.75,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sec.title, style: Theme.of(ctx).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Scrollbar(
                        controller: modalController,
                        thumbVisibility: true,
                        child: ListView(
                          controller: modalController,
                          primary: false,
                          children: _splitContent(sec.content)
                              .map((p) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Text(p, style: Theme.of(ctx).textTheme.bodyLarge),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton.icon(
                          onPressed: current > 0
                              ? () => setState(() => current -= 1)
                              : null,
                          icon: const Icon(Icons.chevron_left),
                          label: const Text('Previous'),
                        ),
                        FilledButton.icon(
                          onPressed: current < all.length - 1
                              ? () => setState(() => current += 1)
                              : null,
                          icon: const Icon(Icons.chevron_right),
                          label: const Text('Next'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}


