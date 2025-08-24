import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../services/preferences_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final List<String> _allInterests = const [
    'Interview Prep',
    'Exam Prep',
    'General Knowledge',
    'Domain Updates',
    'Quick Upskilling',
    'Quick Learning'
  ];
  final Set<String> _selected = {};
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final userId = await ref.read(authUserIdProvider.future);
    if (userId == null) return;
    final interests = await PreferencesService().getInterests(userId);
    setState(() {
      _selected.addAll(interests);
      _loaded = true;
    });
  }

  Future<void> _save() async {
    final userId = await ref.read(authUserIdProvider.future);
    if (userId == null) return;
    await PreferencesService().saveInterests(userId, _selected.toList());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preferences saved')));
  }

  Future<void> _logout() async {
    await ref.read(authServiceProvider).signOut();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Manage Interests', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
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
                const SizedBox(height: 16),
                FilledButton(onPressed: _save, child: const Text('Save')),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: _logout,
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                )
              ],
            ),
    );
  }
}


