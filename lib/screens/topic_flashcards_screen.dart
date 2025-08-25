import 'package:flutter/material.dart';
import '../services/topic_progress_service.dart';

class TopicFlashcardsScreen extends StatefulWidget {
  final String topicId;
  final String topicTitle;
  final List<Map<String, String>> cards; // {q, a}
  const TopicFlashcardsScreen({super.key, required this.topicId, required this.topicTitle, required this.cards});

  @override
  State<TopicFlashcardsScreen> createState() => _TopicFlashcardsScreenState();
}

class _TopicFlashcardsScreenState extends State<TopicFlashcardsScreen> {
  final PageController _pageCtrl = PageController();
  final TopicProgressService _progress = TopicProgressService();
  int _index = 0;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    final last = await _progress.getLastIndex(widget.topicId);
    if (!mounted) return;
    setState(() => _index = last.clamp(0, widget.cards.length - 1));
    await Future<void>.delayed(const Duration(milliseconds: 10));
    _pageCtrl.jumpToPage(_index);
  }

  Future<void> _persist(int idx) async {
    await _progress.setLastIndex(widget.topicId, idx);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topicTitle),
        actions: [
          Center(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('${_index + 1}/${widget.cards.length}'))),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: PageView.builder(
              controller: _pageCtrl,
              onPageChanged: (i) {
                setState(() {
                  _index = i;
                  _showAnswer = false;
                });
                _persist(i);
              },
              itemCount: widget.cards.length,
              itemBuilder: (_, i) {
                final card = widget.cards[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: _FlipCard(
                    front: _QaFace(title: 'Question', text: card['q'] ?? ''),
                    back: _QaFace(title: 'Answer', text: card['a'] ?? ''),
                    showBack: _showAnswer,
                    onFlipped: () => setState(() => _showAnswer = !_showAnswer),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: _index > 0 ? () => _pageCtrl.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeOut) : null,
                  child: const Text('Previous'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => setState(() => _showAnswer = !_showAnswer),
                  child: Text(_showAnswer ? 'Hide Answer' : 'Show Answer'),
                ),
                const SizedBox(width: 8),
                FilledButton.tonal(
                  onPressed: _index < widget.cards.length - 1 ? () => _pageCtrl.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeOut) : null,
                  child: const Text('Next'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _QaFace extends StatelessWidget {
  final String title;
  final String text;
  const _QaFace({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: cs.primary)),
          const SizedBox(height: 8),
          Expanded(child: SingleChildScrollView(child: Text(text, style: Theme.of(context).textTheme.bodyLarge))),
        ]),
      ),
    );
  }
}

class _FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final bool showBack;
  final VoidCallback onFlipped;
  const _FlipCard({required this.front, required this.back, required this.showBack, required this.onFlipped});

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));

  @override
  void didUpdateWidget(covariant _FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.showBack != widget.showBack) {
      if (widget.showBack) {
        _ctrl.forward();
      } else {
        _ctrl.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onFlipped,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          final angle = _ctrl.value * 3.14159;
          final isBack = angle > 1.5708;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);
          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: isBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(3.14159),
                    child: widget.back,
                  )
                : widget.front,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}


