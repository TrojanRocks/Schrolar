import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onAction;
  final String? actionLabel;
  final EdgeInsetsGeometry padding;
  const SectionHeader({super.key, required this.icon, required this.title, this.onAction, this.actionLabel, this.padding = const EdgeInsets.fromLTRB(16, 20, 16, 8)});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Icon(icon, color: cs.onSurfaceVariant),
          const SizedBox(width: 8),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          if (onAction != null)
            TextButton(onPressed: onAction, child: Text(actionLabel ?? 'See all')),
        ],
      ),
    );
  }
}
