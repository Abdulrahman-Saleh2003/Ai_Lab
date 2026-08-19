
import 'package:ai_lab/models/models.dart';

enum ChatStatus { initial, loading, success, error }

class ChatState {
  final List<Message> messages;
  final bool isAiTyping;
  final String inputText;
  final ChatStatus status;

  const ChatState({
    this.messages = const [],
    this.isAiTyping = false,
    this.inputText = '',
    this.status = ChatStatus.initial,
  });

  ChatState copyWith({
    List<Message>? messages,
    bool? isAiTyping,
    String? inputText,
    ChatStatus? status,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isAiTyping: isAiTyping ?? this.isAiTyping,
      inputText: inputText ?? this.inputText,
      status: status ?? this.status,
    );
  }
}