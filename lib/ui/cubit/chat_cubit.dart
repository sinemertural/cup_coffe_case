import 'package:cup_coffe_case/core/services/chat_service.dart';
import 'package:cup_coffe_case/data/entity/chat_message.dart';
import 'package:cup_coffe_case/data/state/chat_state.dart';
import 'package:cup_coffe_case/data/repo/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatService _chatService = ChatService();
  final ChatRepository _chatRepository = ChatRepositoryImpl();
  List<ChatMessage> _currentMessages = [];

  ChatCubit() : super(ChatInitial());

  Future<void> sendMessage(String message) async {
    try {
      final userMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: message,
        isUser: true,
        timestamp: DateTime.now(),
      );

      _currentMessages.add(userMessage);
      emit(ChatLoaded(List.from(_currentMessages)));

      final botResponse = await _chatService.sendMessage(message);
      final botMessage = ChatMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        text: botResponse,
        isUser: false,
        timestamp: DateTime.now(),
      );

      _currentMessages.add(botMessage);

      await _chatRepository.saveChatHistory(
        _currentMessages.map((msg) => msg.toJson()).toList(),
      );

      emit(ChatLoaded(List.from(_currentMessages)));
    } catch (e) {
      emit(ChatError('Mesaj gönderilemedi: $e'));
    }
  }

  Future<void> loadChatHistory() async {
    emit(ChatLoading());

    try {
      final history = await _chatRepository.loadChatHistory();
      _currentMessages = history.map((json) => ChatMessage.fromJson(json)).toList();

      _currentMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      
      emit(ChatLoaded(List.from(_currentMessages)));
    } catch (e) {
      emit(ChatError('Chat geçmişi yüklenemedi: $e'));
    }
  }

  void clearChat() {
    _currentMessages.clear();
    _chatRepository.saveChatHistory([]);
    emit(ChatInitial());
  }
}