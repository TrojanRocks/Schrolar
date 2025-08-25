import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import '../models/flashcard.dart';

class FlashcardService {
  Future<List<Flashcard>> loadAll() async {
    final data = await rootBundle.loadString('assets/data/flashcards.json');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => Flashcard.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<List<Flashcard>> loadByInterests(List<String> interests) async {
    final all = await loadAll();
    if (interests.isEmpty) return all;
    final interestSet = interests.map((e) => e.toLowerCase()).toSet();
    return all.where((f) => interestSet.contains(f.category.toLowerCase())).toList();
  }
}


