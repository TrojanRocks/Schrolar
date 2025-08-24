// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    UserPreferences(
      userId: json['userId'] as String,
      interests: (json['interests'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      favoriteFlashcardIds:
          (json['favoriteFlashcardIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
    );

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'interests': instance.interests,
      'favoriteFlashcardIds': instance.favoriteFlashcardIds.toList(),
    };
