import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserPersona { student, professional }

class PersonaState {
  final UserPersona persona;
  final ThemeMode themeMode;
  const PersonaState({required this.persona, required this.themeMode});

  PersonaState copyWith({UserPersona? persona, ThemeMode? themeMode}) =>
      PersonaState(persona: persona ?? this.persona, themeMode: themeMode ?? this.themeMode);
}

class PersonaService {
  static const _kPersona = 'persona_v1';
  static const _kThemeMode = 'theme_mode_v1';

  Future<PersonaState> load() async {
    final p = await SharedPreferences.getInstance();
    final personaStr = p.getString(_kPersona) ?? 'student';
    final modeStr = p.getString(_kThemeMode) ?? 'system';
    final persona = personaStr == 'professional' ? UserPersona.professional : UserPersona.student;
    final mode = switch (modeStr) { 'light' => ThemeMode.light, 'dark' => ThemeMode.dark, _ => ThemeMode.system };
    return PersonaState(persona: persona, themeMode: mode);
  }

  Future<void> save(PersonaState state) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_kPersona, state.persona.name);
    await p.setString(_kThemeMode, switch (state.themeMode) { ThemeMode.light => 'light', ThemeMode.dark => 'dark', ThemeMode.system => 'system' });
  }
}

class PersonaController extends StateNotifier<PersonaState> {
  final PersonaService service;
  PersonaController(this.service) : super(const PersonaState(persona: UserPersona.student, themeMode: ThemeMode.system)) {
    _init();
  }
  Future<void> _init() async {
    state = await service.load();
  }
  Future<void> setPersona(UserPersona persona) async {
    state = state.copyWith(persona: persona);
    await service.save(state);
  }
  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await service.save(state);
  }
}

final personaServiceProvider = Provider((ref) => PersonaService());
final personaControllerProvider = StateNotifierProvider<PersonaController, PersonaState>((ref) {
  return PersonaController(ref.watch(personaServiceProvider));
});
