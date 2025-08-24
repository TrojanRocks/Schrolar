import 'package:flutter/material.dart';

class DailyProgressIndicator extends StatelessWidget {
  final int completedToday;
  const DailyProgressIndicator({super.key, required this.completedToday});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.bolt, size: 18),
        const SizedBox(width: 8),
        Text('Today\'s progress: $completedToday')
      ],
    );
  }
}


