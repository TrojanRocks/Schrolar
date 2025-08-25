import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Brand color schemes
const ColorScheme _lightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFDD2A7B),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFD0E3),
  onPrimaryContainer: Color(0xFF3F001F),
  secondary: Color(0xFF515BD4),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDDE0FF),
  onSecondaryContainer: Color(0xFF0D1640),
  tertiary: Color(0xFFF58529),
  onTertiary: Color(0xFF111827),
  error: Color(0xFFDC2626),
  onError: Color(0xFFFFFFFF),
  background: Color(0xFFFFFFFF),
  onBackground: Color(0xFF0F172A),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF0F172A),
  surfaceVariant: Color(0xFFF4F4F5),
  onSurfaceVariant: Color(0xFF3F3F46),
  outline: Color(0xFFA1A1AA),
  shadow: Colors.black12,
  inverseSurface: Color(0xFF0F172A),
  onInverseSurface: Color(0xFFFFFFFF),
  inversePrimary: Color(0xFF9E1E57),
);

const ColorScheme _darkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFF5AA8),
  onPrimary: Color(0xFF48001F),
  primaryContainer: Color(0xFF7C1147),
  onPrimaryContainer: Color(0xFFFFD7E8),
  secondary: Color(0xFF9AA1FF),
  onSecondary: Color(0xFF0A0F33),
  secondaryContainer: Color(0xFF2D338A),
  onSecondaryContainer: Color(0xFFE3E6FF),
  tertiary: Color(0xFFFF9C4E),
  onTertiary: Color(0xFF1B1B1B),
  error: Color(0xFFF87171),
  onError: Color(0xFF1F0A0A),
  background: Color(0xFF0B0B10),
  onBackground: Color(0xFFE5E7EB),
  surface: Color(0xFF0F1115),
  onSurface: Color(0xFFE5E7EB),
  surfaceVariant: Color(0xFF1C1F27),
  onSurfaceVariant: Color(0xFFC7CAD1),
  outline: Color(0xFF8B8FA1),
  shadow: Colors.black45,
  inverseSurface: Color(0xFFE5E7EB),
  onInverseSurface: Color(0xFF0F1115),
  inversePrimary: Color(0xFFFF5AA8),
);

ThemeData lightTheme() {
  final base = ThemeData(useMaterial3: true, colorScheme: _lightScheme);
  return base.copyWith(
    textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
      titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w700),
      titleMedium: GoogleFonts.inter(fontWeight: FontWeight.w700),
      labelLarge: GoogleFonts.inter(fontWeight: FontWeight.w600),
      labelMedium: GoogleFonts.inter(fontWeight: FontWeight.w600),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

ThemeData darkTheme() {
  final base = ThemeData(useMaterial3: true, colorScheme: _darkScheme);
  return base.copyWith(
    textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
      titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w700),
      titleMedium: GoogleFonts.inter(fontWeight: FontWeight.w700),
      labelLarge: GoogleFonts.inter(fontWeight: FontWeight.w600),
      labelMedium: GoogleFonts.inter(fontWeight: FontWeight.w600),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
