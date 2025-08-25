import 'package:shared_preferences/shared_preferences.dart';

class TopicProgressService {
  String _key(String topicId) => 'topic_last_index_$topicId';

  Future<int> getLastIndex(String topicId) async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_key(topicId)) ?? 0;
  }

  Future<void> setLastIndex(String topicId, int index) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_key(topicId), index);
  }
}


