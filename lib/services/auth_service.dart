import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

abstract class AuthService {
  Future<String?> getCurrentUserId();
  Future<void> signOut();
  Future<String> signUpWithEmail(String email, String password);
  Future<String> signInWithEmail(String email, String password);
  Future<String> signInWithGoogle();
}

class MockAuthService implements AuthService {
  static const _keyUserId = 'auth_user_id';
  static const _keyEmail = 'auth_email';

  @override
  Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  @override
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyEmail);
  }

  @override
  Future<String> signUpWithEmail(String email, String password) async {
    // Mock: persist a generated user id
    final userId = const Uuid().v4();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyEmail, email);
    return userId;
  }

  @override
  Future<String> signInWithEmail(String email, String password) async {
    // Mock: sign in as same user if email matches prior one, else generate
    final prefs = await SharedPreferences.getInstance();
    String? existingUserId = prefs.getString(_keyUserId);
    if (existingUserId == null) {
      existingUserId = const Uuid().v4();
    }
    await prefs.setString(_keyUserId, existingUserId);
    await prefs.setString(_keyEmail, email);
    return existingUserId;
  }

  @override
  Future<String> signInWithGoogle() async {
    final prefs = await SharedPreferences.getInstance();
    String? existingUserId = prefs.getString(_keyUserId);
    if (existingUserId == null) {
      existingUserId = const Uuid().v4();
    }
    await prefs.setString(_keyUserId, existingUserId);
    await prefs.setString(_keyEmail, 'google_user@example.com');
    return existingUserId;
  }
}



