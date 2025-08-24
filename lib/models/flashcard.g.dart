// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flashcard _$FlashcardFromJson(Map<String, dynamic> json) => Flashcard(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  category: json['category'] as String,
  imageUrl: json['imageUrl'] as String?,
  videoUrl: json['videoUrl'] as String?,
);

Map<String, dynamic> _$FlashcardToJson(Flashcard instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'category': instance.category,
  'imageUrl': instance.imageUrl,
  'videoUrl': instance.videoUrl,
};
