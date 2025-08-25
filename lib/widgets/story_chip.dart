import 'package:flutter/material.dart';

class StoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const StoryChip({super.key, required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ]),
              shape: BoxShape.circle,
            ),
            child: Container(
              margin: const EdgeInsets.all(3),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Icon(icon, color: Colors.black87),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 72,
          child: Text(label, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}


