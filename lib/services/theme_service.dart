import 'package:shared_preferences/shared_preferences.dart';

enum ThemeVariant { student, professional }

class ThemeService {
  static const _key = 'theme_variant';

  Future<ThemeVariant> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    switch (raw) {
      case 'professional':
        return ThemeVariant.professional;
      case 'student':
      default:
        return ThemeVariant.student;
    }
  }

  Future<void> setTheme(ThemeVariant variant) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, variant.name);
  }
}


