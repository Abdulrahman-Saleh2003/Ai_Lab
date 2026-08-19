
import 'package:ai_lab/controller/home/Chat/chat_state.dart';
import 'package:ai_lab/models/home/Chat/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatController extends Notifier<ChatState> {
  @override
  ChatState build() {
    return ChatState(
      messages: [
        Message(
          id: '1',
          text:
              'مرحباً أحمد، أنا مساعدك الذكي. كيف يمكنني مساعدتك في تحليل تقاريرك اليوم؟',
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
          suggestion: Suggestion(
            title: 'تحليل آخر تقرير دم',
            subtitle: 'تم التحديث أمس',
            icon: 'bloodtype',
          ),
        ),
        Message(
          id: '2',
          text: 'أريد رؤية ملخص لنتائج الفحص الأخير. هل هناك أي قراءات مقلقة؟',
          sender: MessageSender.user,
          timestamp: DateTime.now(),
        ),
      ],
    );
  }

  void updateInput(String text) {
    state = state.copyWith(inputText: text);
  }

  void sendMessage() {
    final text = state.inputText.trim();
    if (text.isEmpty) return;

    final userMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      inputText: '',
      isAiTyping: true,
      status: ChatStatus.loading,
    );

    // محاكاة رد الـ AI
    Future.delayed(const Duration(seconds: 2), () {
      final aiMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'حسناً، دعني أراجع آخر تقرير دم لك...',
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, aiMessage],
        isAiTyping: false,
        status: ChatStatus.success,
      );
    });
  }

  void clearChat() {
    state = state.copyWith(
      messages: [],
      isAiTyping: false,
      inputText: '',
      status: ChatStatus.initial,
    );
  }
}
