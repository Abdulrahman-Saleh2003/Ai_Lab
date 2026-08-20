import 'package:ai_lab/controller/home/Chat/chat_state.dart';
import 'package:ai_lab/controller/home/home_provider.dart';
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
              'مرحباً بك في نظام LabSync AI الذكي. كيف يمكنني مساعدتك في تحليل وفهم تقاريرك المخبرية اليوم؟',
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
          suggestion: Suggestion(
            title: 'تحليل آخر تقرير مخبري',
            subtitle: 'استعلام مباشر عبر RAG',
            icon: 'biotech',
          ),
        ),
      ],
    );
  }

  void updateInput(String text) {
    state = state.copyWith(inputText: text);
  }

  Future<void> sendMessage() async {
    final text = state.inputText.trim();
    if (text.isEmpty || state.isAiTyping) return;

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

    try {
      final homeState = ref.read(homeProvider);
      final recentReports = homeState.reports;

      if (recentReports.isNotEmpty) {
        final targetReport = recentReports.first;
        final res = await ref.read(homeDataProvider).askReportQuestion(
              reportId: targetReport.reportId,
              question: text,
            );

        res.fold(
          (failure) {
            final errorMsg = Message(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              text: 'تعذر الاتصال بالمساعد الذكي: ${failure.message}',
              sender: MessageSender.ai,
              timestamp: DateTime.now(),
            );
            state = state.copyWith(
              messages: [...state.messages, errorMsg],
              isAiTyping: false,
              status: ChatStatus.error,
            );
          },
          (data) {
            final answer = data['answer']?.toString() ??
                data['response']?.toString() ??
                data['message']?.toString() ??
                'تمت معالجة استفسارك بنجاح.';
            final aiMessage = Message(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              text: answer,
              sender: MessageSender.ai,
              timestamp: DateTime.now(),
            );
            state = state.copyWith(
              messages: [...state.messages, aiMessage],
              isAiTyping: false,
              status: ChatStatus.success,
            );
          },
        );
      } else {
        final aiMessage = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text:
              'لم يتم العثور على تقارير مخبرية مرفوعة في حسابك حالياً للإجابة عن هذا السؤال. يرجى رفع تقرير أولاً ليتمكن النظام من الإجابة بدقة.',
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        );
        state = state.copyWith(
          messages: [...state.messages, aiMessage],
          isAiTyping: false,
          status: ChatStatus.success,
        );
      }
    } catch (e) {
      final errorMsg = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'حدث خطأ غير متوقع أثناء معالجة السؤال.',
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
      );
      state = state.copyWith(
        messages: [...state.messages, errorMsg],
        isAiTyping: false,
        status: ChatStatus.error,
      );
    }
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
