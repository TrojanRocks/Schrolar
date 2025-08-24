import 'package:json_annotation/json_annotation.dart';

part 'user_preferences.g.dart';

@JsonSerializable()
class UserPreferences {
  final String userId;
  final List<String> interests; // category keys
  final Set<String> favoriteFlashcardIds;

  const UserPreferences({
    required this.userId,
    required this.interests,
    this.favoriteFlashcardIds = const {},
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) => _$UserPreferencesFromJson(json);
  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);
}

