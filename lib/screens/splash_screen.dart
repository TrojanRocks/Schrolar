import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../providers/flashcard_providers.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authUserIdProvider, (prev, next) {
      if (next.isLoading) return;
      final userId = next.valueOrNull;
      if (userId == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            Navigator.of(context).pushReplacementNamed('/signin');
          }
        });
      } else {
        // If interests are empty, go to onboarding first
        ref.read(interestsProvider.future).then((interests) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) return;
            if (interests.isEmpty) {
              Navigator.of(context).pushReplacementNamed('/onboarding');
            } else {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          });
        });
      }
    });
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}


