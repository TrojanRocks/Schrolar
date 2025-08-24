import 'package:json_annotation/json_annotation.dart';

part 'flashcard.g.dart';

@JsonSerializable()
class Flashcard {
  final String id;
  final String title;
  final String content;
  final String category; // e.g., Interview Prep, Exam Prep, etc.
  final String? imageUrl;
  final String? videoUrl;

  const Flashcard({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.imageUrl,
    this.videoUrl,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) => _$FlashcardFromJson(json);
  Map<String, dynamic> toJson() => _$FlashcardToJson(this);
}

