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
  final String? groupId; // Connect related flashcards (e.g., RADIO)
  final int? orderInGroup; // Defines progression in a group

  const Flashcard({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.imageUrl,
    this.videoUrl,
    this.groupId,
    this.orderInGroup,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) => _$FlashcardFromJson(json);
  Map<String, dynamic> toJson() => _$FlashcardToJson(this);

  // Manual constructor to avoid needing codegen when fields are added
  factory Flashcard.fromMap(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      groupId: json['groupId'] as String?,
      orderInGroup: (json['orderInGroup'] as num?)?.toInt(),
    );
  }
}

