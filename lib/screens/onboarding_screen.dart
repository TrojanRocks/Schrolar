import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../services/preferences_service.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final List<String> _allInterests = const [
    'Interview Prep',
    'Exam Prep',
    'General Knowledge',
    'Domain Updates',
    'Quick Upskilling',
    'Quick Learning'
  ];
  final Set<String> _selected = {};

  Future<void> _save() async {
    final userId = await ref.read(authUserIdProvider.future);
    if (userId == null) return;
    await PreferencesService().saveInterests(userId, _selected.toList());
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick your interests')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final interest in _allInterests)
                FilterChip(
                  label: Text(interest),
                  selected: _selected.contains(interest),
                  onSelected: (sel) {
                    setState(() {
                      if (sel) {
                        _selected.add(interest);
                      } else {
                        _selected.remove(interest);
                      }
                    });
                  },
                )
            ],
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _selected.isEmpty ? null : _save,
            child: const Text('Continue'),
          )
        ],
      ),
    );
  }
}


