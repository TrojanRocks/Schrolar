import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/persona_providers.dart';
import 'persona_theme.dart';

ThemeData themeFor(UserPersona persona, Brightness brightness) {
  final bool isLight = brightness == Brightness.light;

  late final ColorScheme scheme;
  late final PersonaTheme ptheme;

  if (persona == UserPersona.student && isLight) {
    scheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF4F46E5),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFDEE2FF),
      onPrimaryContainer: Color(0xFF0B0F3A),
      secondary: Color(0xFF06B6D4),
      onSecondary: Color(0xFF002A31),
      secondaryContainer: Color(0xFFBFF4FF),
      onSecondaryContainer: Color(0xFF05232A),
      tertiary: Color(0xFF22C55E),
      onTertiary: Color(0xFF06240F),
      error: Color(0xFFDC2626),
      onError: Color(0xFFFFFFFF),
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFF0F172A),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF0F172A),
      surfaceVariant: Color(0xFFF1F5F9),
      onSurfaceVariant: Color(0xFF334155),
      outline: Color(0xFF94A3B8),
      shadow: Colors.black12,
      inverseSurface: Color(0xFF0F172A),
      onInverseSurface: Color(0xFFFFFFFF),
      inversePrimary: Color(0xFF4F46E5),
    );
    ptheme = const PersonaTheme(
      heroGradient: LinearGradient(colors: [Color(0xFF06B6D4), Color(0xFF4F46E5)]),
      cardRadius: 22,
      elevation: 2,
      chipBg: Color(0xFFEFF6FF),
      chipFg: Color(0xFF0F172A),
    );
  } else if (persona == UserPersona.student && !isLight) {
    scheme = const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFA5B4FF),
      onPrimary: Color(0xFF0B0F3A),
      primaryContainer: Color(0xFF303A8C),
      onPrimaryContainer: Color(0xFFE7EAFF),
      secondary: Color(0xFF67E8F9),
      onSecondary: Color(0xFF05232A),
      secondaryContainer: Color(0xFF155E67),
      onSecondaryContainer: Color(0xFFD9FBFF),
      tertiary: Color(0xFF86EFAC),
      onTertiary: Color(0xFF082711),
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
      inversePrimary: Color(0xFFA5B4FF),
    );
    ptheme = const PersonaTheme(
      heroGradient: LinearGradient(colors: [Color(0xFF67E8F9), Color(0xFFA5B4FF)]),
      cardRadius: 22,
      elevation: 2,
      chipBg: Color(0xFF1C1F27),
      chipFg: Color(0xFFE5E7EB),
    );
  } else if (persona == UserPersona.professional && isLight) {
    scheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF1F2937),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFD1D5DB),
      onPrimaryContainer: Color(0xFF0A0E14),
      secondary: Color(0xFF374151),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFE5E7EB),
      onSecondaryContainer: Color(0xFF111827),
      tertiary: Color(0xFFF59E0B),
      onTertiary: Color(0xFF1B1608),
      error: Color(0xFFB91C1C),
      onError: Color(0xFFFFFFFF),
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFF0F172A),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF0F172A),
      surfaceVariant: Color(0xFFF3F4F6),
      onSurfaceVariant: Color(0xFF374151),
      outline: Color(0xFF9CA3AF),
      shadow: Colors.black12,
      inverseSurface: Color(0xFF0F172A),
      onInverseSurface: Color(0xFFFFFFFF),
      inversePrimary: Color(0xFF4F46E5),
    );
    ptheme = const PersonaTheme(
      heroGradient: LinearGradient(colors: [Color(0xFF1F2937), Color(0xFF111827)]),
      cardRadius: 20,
      elevation: 1,
      chipBg: Color(0xFFE5E7EB),
      chipFg: Color(0xFF111827),
    );
  } else {
    scheme = const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF9CA3AF),
      onPrimary: Color(0xFF0B0D12),
      primaryContainer: Color(0xFF374151),
      onPrimaryContainer: Color(0xFFE5E7EB),
      secondary: Color(0xFF6B7280),
      onSecondary: Color(0xFF0B0D12),
      secondaryContainer: Color(0xFF1F2937),
      onSecondaryContainer: Color(0xFFD1D5DB),
      tertiary: Color(0xFFFBBF24),
      onTertiary: Color(0xFF1A1406),
      error: Color(0xFFF87171),
      onError: Color(0xFF1F0A0A),
      background: Color(0xFF0B0B10),
      onBackground: Color(0xFFE5E7EB),
      surface: Color(0xFF0F1115),
      onSurface: Color(0xFFE5E7EB),
      surfaceVariant: Color(0xFF171B22),
      onSurfaceVariant: Color(0xFFC7CAD1),
      outline: Color(0xFF8B8FA1),
      shadow: Colors.black45,
      inverseSurface: Color(0xFFE5E7EB),
      onInverseSurface: Color(0xFF0F1115),
      inversePrimary: Color(0xFF818CF8),
    );
    ptheme = const PersonaTheme(
      heroGradient: LinearGradient(colors: [Color(0xFF111827), Color(0xFF0B0B10)]),
      cardRadius: 20,
      elevation: 1,
      chipBg: Color(0xFF171B22),
      chipFg: Color(0xFFE5E7EB),
    );
  }

  final base = ThemeData(useMaterial3: true, colorScheme: scheme);
  return base.copyWith(
    textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
      displaySmall: GoogleFonts.inter(fontWeight: FontWeight.w900, color: scheme.onSurface),
      titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w900, color: scheme.onSurface),
      bodyLarge: GoogleFonts.inter(fontWeight: FontWeight.w400, color: scheme.onSurface),
      bodyMedium: GoogleFonts.inter(fontWeight: FontWeight.w400, color: scheme.onSurfaceVariant),
      labelLarge: GoogleFonts.inter(fontWeight: FontWeight.w600, color: scheme.onPrimary),
      labelMedium: GoogleFonts.inter(fontWeight: FontWeight.w600, color: scheme.onSurface),
    ),
    cardTheme: CardThemeData(
      elevation: ptheme.elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ptheme.cardRadius)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      border: OutlineInputBorder(borderSide: BorderSide(color: scheme.outline), borderRadius: BorderRadius.circular(ptheme.cardRadius)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: scheme.outline), borderRadius: BorderRadius.circular(ptheme.cardRadius)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: scheme.primary, width: 2), borderRadius: BorderRadius.circular(ptheme.cardRadius)),
      hintStyle: TextStyle(color: scheme.onSurfaceVariant),
      labelStyle: TextStyle(color: scheme.onSurfaceVariant),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surface,
      indicatorColor: scheme.primary.withOpacity(0.12),
      iconTheme: WidgetStateProperty.resolveWith((states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? scheme.primary : scheme.onSurfaceVariant,
          )),
      labelTextStyle: WidgetStateProperty.resolveWith((states) => GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: states.contains(WidgetState.selected) ? scheme.primary : scheme.onSurfaceVariant,
          )),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        foregroundColor: scheme.onPrimary,
        backgroundColor: scheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ptheme.cardRadius)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: scheme.onSurface,
        side: BorderSide(color: scheme.outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ptheme.cardRadius)),
      ),
    ),
    extensions: [ptheme],
  );
}
