import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../providers/persona_providers.dart';

class AnimatedBackground extends StatefulWidget {
  final UserPersona persona;
  const AnimatedBackground({super.key, required this.persona});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isStudent = widget.persona == UserPersona.student;
    final gradient = isStudent
        ? const LinearGradient(colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)], begin: Alignment.topLeft, end: Alignment.bottomRight)
        : const LinearGradient(colors: [Color(0xFF111827), Color(0xFF1F2937)], begin: Alignment.topLeft, end: Alignment.bottomRight);

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return CustomPaint(
          painter: _BgPainter(_ctrl.value, isStudent: isStudent, gradient: gradient),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _BgPainter extends CustomPainter {
  final double t;
  final bool isStudent;
  final Gradient gradient;
  _BgPainter(this.t, {required this.isStudent, required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    final decoPaint = Paint()
      ..color = Colors.white.withOpacity(isStudent ? 0.10 : 0.06)
      ..style = PaintingStyle.fill;

    if (isStudent) {
      // floating circles (playful)
      for (int i = 0; i < 6; i++) {
        final dx = (size.width / 6) * i + 20 * math.sin(2 * math.pi * (t + i * .17));
        final dy = (size.height / 6) * (i % 3 + 1) + 16 * math.cos(2 * math.pi * (t + i * .23));
        canvas.drawCircle(Offset(dx, dy), 18 + 6 * math.sin(2 * math.pi * (t + i * .31)), decoPaint);
      }
    } else {
      // subtle lines (professional)
      final linePaint = Paint()
        ..color = Colors.white.withOpacity(0.08)
        ..strokeWidth = 1.5;
      for (int i = 0; i < 8; i++) {
        final shift = 20 * math.sin(2 * math.pi * (t + i * .15));
        final y = (size.height / 9) * (i + 1) + shift;
        canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BgPainter oldDelegate) => oldDelegate.t != t || oldDelegate.isStudent != isStudent;
}


