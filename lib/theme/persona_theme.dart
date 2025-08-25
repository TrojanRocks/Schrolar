import 'package:flutter/material.dart';

@immutable
class PersonaTheme extends ThemeExtension<PersonaTheme> {
  final LinearGradient heroGradient;
  final double cardRadius;
  final double elevation;
  final Color chipBg;
  final Color chipFg;

  const PersonaTheme({
    required this.heroGradient,
    required this.cardRadius,
    required this.elevation,
    required this.chipBg,
    required this.chipFg,
  });

  @override
  PersonaTheme copyWith({
    LinearGradient? heroGradient,
    double? cardRadius,
    double? elevation,
    Color? chipBg,
    Color? chipFg,
  }) => PersonaTheme(
        heroGradient: heroGradient ?? this.heroGradient,
        cardRadius: cardRadius ?? this.cardRadius,
        elevation: elevation ?? this.elevation,
        chipBg: chipBg ?? this.chipBg,
        chipFg: chipFg ?? this.chipFg,
      );

  @override
  PersonaTheme lerp(ThemeExtension<PersonaTheme>? other, double t) {
    if (other is! PersonaTheme) return this;
    return PersonaTheme(
      heroGradient: LinearGradient(
        colors: List<Color>.generate(2, (i) => Color.lerp(heroGradient.colors[i], other.heroGradient.colors[i], t) ?? heroGradient.colors[i]),
      ),
      cardRadius: Tween<double>(begin: cardRadius, end: other.cardRadius).transform(t),
      elevation: Tween<double>(begin: elevation, end: other.elevation).transform(t),
      chipBg: Color.lerp(chipBg, other.chipBg, t) ?? chipBg,
      chipFg: Color.lerp(chipFg, other.chipFg, t) ?? chipFg,
    );
  }
}
