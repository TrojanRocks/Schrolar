import 'package:flutter/material.dart';

class AnimatedTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  const AnimatedTextField({super.key, required this.icon, required this.label, required this.controller, this.obscureText = false, this.keyboardType});

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField> {
  bool _focused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() => _focused = _focusNode.hasFocus));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        boxShadow: _focused
            ? [BoxShadow(color: cs.primary.withOpacity(0.25), blurRadius: 16, spreadRadius: 2)]
            : const [],
        borderRadius: (Theme.of(context).inputDecorationTheme.border as OutlineInputBorder?)?.borderRadius ?? BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: Icon(widget.icon),
        ),
        validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
      ),
    );
  }
}

class AnimatedPrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  const AnimatedPrimaryButton({super.key, required this.label, required this.onPressed});

  @override
  State<AnimatedPrimaryButton> createState() => _AnimatedPrimaryButtonState();
}

class _AnimatedPrimaryButtonState extends State<AnimatedPrimaryButton> with SingleTickerProviderStateMixin {
  double _scale = 1;
  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]);
    final radius = (Theme.of(context).filledButtonTheme.style?.shape?.resolve({}) as RoundedRectangleBorder?)?.side.strokeAlign;
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.98),
      onTapUp: (_) => setState(() => _scale = 1),
      onTapCancel: () => setState(() => _scale = 1),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _scale,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: widget.onPressed,
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}


