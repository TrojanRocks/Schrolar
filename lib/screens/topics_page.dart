import 'package:flutter/material.dart';

class TopicItem {
  final String title;
  final String subtitle;
  final IconData icon;
  const TopicItem(this.title, this.subtitle, this.icon);
}

const List<TopicItem> kDemoTopics = [
  TopicItem('System Design Basics', 'Foundations for scalable systems', Icons.architecture_outlined),
  TopicItem('SQL Functions 101', 'Aggregations, strings, dates', Icons.storage_outlined),
  TopicItem('Data Structures: Arrays & HashMaps', 'Core interview patterns', Icons.view_module_outlined),
  TopicItem('JavaScript Async (Promises & Await)', 'Concurrency basics for web', Icons.javascript_outlined),
  TopicItem('Basics of AI & ML', 'Concepts and real-world uses', Icons.psychology_alt_outlined),
];

class TopicsPage extends StatelessWidget {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Topics')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.9),
        itemCount: kDemoTopics.length,
        itemBuilder: (_, i) {
          final t = kDemoTopics[i];
          return Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed('/topic', arguments: t.title),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(color: cs.primaryContainer, borderRadius: BorderRadius.circular(12)),
                      child: Icon(t.icon, color: cs.onPrimaryContainer),
                    ),
                    const SizedBox(height: 10),
                    Text(t.title, style: Theme.of(context).textTheme.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Text(t.subtitle, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


