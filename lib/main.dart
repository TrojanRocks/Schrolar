import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_shell.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'providers/persona_providers.dart';
import 'theme/app_theme.dart';
import 'screens/topic_flashcards_screen.dart';
import 'data/mock_data.dart';
import 'screens/topics_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (DefaultFirebaseOptions.isConfigured) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    }
  } catch (_) {}
  runApp(const ProviderScope(child: SchrolarApp()));
}

class SchrolarApp extends StatelessWidget {
  const SchrolarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final personaState = ref.watch(personaControllerProvider);
      final theme = themeFor(personaState.persona, personaState.themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light);
      return MaterialApp(
        title: 'EduShorts',
        theme: themeFor(personaState.persona, Brightness.light),
        darkTheme: themeFor(personaState.persona, Brightness.dark),
        themeMode: personaState.themeMode,
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashScreen(),
          '/signin': (_) => const SignInScreen(),
          '/signup': (_) => const SignUpScreen(),
          '/onboarding': (_) => const OnboardingScreen(),
          '/home': (_) => const HomeShell(),
          '/profile': (_) => const ProfileScreen(),
          '/settings': (_) => const SettingsScreen(),
          '/topic': (ctx) {
            final String title = ModalRoute.of(ctx)!.settings.arguments as String;
            final cards = kTopicCards[title] ?? const [
              {'q': 'No cards found for this topic', 'a': 'Add cards in mock_data.dart > kTopicCards.'}
            ];
            return TopicFlashcardsScreen(topicId: title, topicTitle: title, cards: cards);
          },
          '/topics': (_) => const TopicsPage(),
        },
      );
    });
  }
}
