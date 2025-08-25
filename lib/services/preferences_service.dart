import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;
  PreferencesService._internal();

  Database? _db;

  Future<Database> _getDb() async {
    if (_db != null) return _db!;
    final Directory dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, 'schrolar_prefs.db');
    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user_preferences (
            user_id TEXT PRIMARY KEY,
            interests TEXT NOT NULL
          );
        ''');
        await db.execute('''
          CREATE TABLE favorites (
            user_id TEXT NOT NULL,
            flashcard_id TEXT NOT NULL,
            PRIMARY KEY (user_id, flashcard_id)
          );
        ''');
        await db.execute('''
          CREATE TABLE progress (
            user_id TEXT NOT NULL,
            date TEXT NOT NULL,
            count INTEGER NOT NULL,
            PRIMARY KEY (user_id, date)
          );
        ''');
      },
    );
    return _db!;
  }

  Future<List<String>> getInterests(String userId) async {
    final db = await _getDb();
    final rows = await db.query('user_preferences', where: 'user_id = ?', whereArgs: [userId]);
    if (rows.isEmpty) return [];
    final interests = rows.first['interests'] as String;
    if (interests.trim().isEmpty) return [];
    return interests.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  Future<void> saveInterests(String userId, List<String> interests) async {
    final db = await _getDb();
    final interestsStr = interests.join(',');
    await db.insert(
      'user_preferences',
      {'user_id': userId, 'interests': interestsStr},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> getFavorites(String userId) async {
    final db = await _getDb();
    final rows = await db.query('favorites', where: 'user_id = ?', whereArgs: [userId]);
    return rows.map((r) => r['flashcard_id'] as String).toList();
  }

  Future<void> addFavorite(String userId, String flashcardId) async {
    final db = await _getDb();
    await db.insert('favorites', {'user_id': userId, 'flashcard_id': flashcardId}, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<void> removeFavorite(String userId, String flashcardId) async {
    final db = await _getDb();
    await db.delete('favorites', where: 'user_id = ? AND flashcard_id = ?', whereArgs: [userId, flashcardId]);
  }

  Future<int> getTodayProgress(String userId) async {
    final db = await _getDb();
    final today = DateTime.now();
    final key = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    final rows = await db.query('progress', where: 'user_id = ? AND date = ?', whereArgs: [userId, key]);
    if (rows.isEmpty) return 0;
    return (rows.first['count'] as int?) ?? 0;
  }

  Future<void> incrementTodayProgress(String userId) async {
    final db = await _getDb();
    final today = DateTime.now();
    final key = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    final current = await getTodayProgress(userId);
    final next = current + 1;
    await db.insert(
      'progress',
      {'user_id': userId, 'date': key, 'count': next},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getCurrentStreak(String userId) async {
    final db = await _getDb();
    int streak = 0;
    DateTime day = DateTime.now();
    while (true) {
      final key = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      final rows = await db.query('progress', where: 'user_id = ? AND date = ?', whereArgs: [userId, key]);
      if (rows.isEmpty) break;
      streak += 1;
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }
}


