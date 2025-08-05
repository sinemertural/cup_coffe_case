import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChatRepository {
  Future<void> saveChatHistory(List<Map<String, dynamic>> messages);
  Future<List<Map<String, dynamic>>> loadChatHistory();
}

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<void> saveChatHistory(List<Map<String, dynamic>> messages) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('chat_history', jsonEncode(messages));
  }

  @override
  Future<List<Map<String, dynamic>>> loadChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getString('chat_history');
    if (history != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(history));
    }
    return [];
  }
}

