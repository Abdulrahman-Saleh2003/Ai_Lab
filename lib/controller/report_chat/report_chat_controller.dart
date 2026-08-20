import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:ai_lab/controller/report_chat/report_chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportChatController extends Notifier<ReportChatState> {
  @override
  ReportChatState build() {
    return const ReportChatState();
  }

  void initialize(String reportId) {
    if (state.reportId != reportId) {
      state = ReportChatState(reportId: reportId);
    }
  }

  Future<void> sendQuestion(String question, {String? reportId}) async {
    final targetReportId = reportId ?? state.reportId;
    final text = question.trim();
    if (text.isEmpty || state.isSending || targetReportId.isEmpty) return;

    final msgId = DateTime.now().millisecondsSinceEpoch.toString();
    final newMsg = ReportChatMessage(
      id: msgId,
      question: text,
      isLoading: true,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      reportId: targetReportId,
      messages: [...state.messages, newMsg],
      isSending: true,
      status: ReportChatStatus.loading,
    );

    try {
      final res = await ref.read(homeDataProvider).askReportQuestion(
            reportId: targetReportId,
            question: text,
          );

      res.fold(
        (failure) {
          final updatedMessages = state.messages.map((m) {
            if (m.id == msgId) {
              return m.copyWith(
                isLoading: false,
                isError: true,
              );
            }
            return m;
          }).toList();

          state = state.copyWith(
            messages: updatedMessages,
            isSending: false,
            status: ReportChatStatus.failure,
            errorMessage: failure.message,
          );
        },
        (data) {
          final Map map = data is Map ? data : {};
          final html = map['answer_html']?.toString() ??
              map['response']?.toString() ??
              map['answer']?.toString();
          final raw = map['answer']?.toString() ?? map['message']?.toString();
          final updatedMessages = state.messages.map((m) {
            if (m.id == msgId) {
              return m.copyWith(
                isLoading: false,
                answerHtml: html,
                answer: raw,
                isError: false,
              );
            }
            return m;
          }).toList();

          state = state.copyWith(
            messages: updatedMessages,
            isSending: false,
            status: ReportChatStatus.success,
          );
        },
      );
    } catch (e) {
      final updatedMessages = state.messages.map((m) {
        if (m.id == msgId) {
          return m.copyWith(
            isLoading: false,
            isError: true,
          );
        }
        return m;
      }).toList();

      state = state.copyWith(
        messages: updatedMessages,
        isSending: false,
        status: ReportChatStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  void clearChat() {
    state = state.copyWith(
      messages: [],
      isSending: false,
      status: ReportChatStatus.initial,
    );
  }
}
